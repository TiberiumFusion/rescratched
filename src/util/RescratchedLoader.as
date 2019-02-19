package util 
{
	/**
	 * Implementation of project loading features beyond that which offline Scratch 2.0 is capable of
	 * Able to load project data from the scratch.mit.edu servers, using an adaptation of the Phosphorus method
	 * @author TiberiumFusion
	 */
	
	import by.blooddy.crypto.CRC32Table;
	import flash.utils.ByteArray;
	import inappd.DebugMessages;
	import scratch.ScratchCostume;
	import scratch.ScratchObj;
	import scratch.ScratchSound;
	import scratch.ScratchStage;
	
	public class RescratchedLoader extends ProjectIO
	{
		private var _InProgress:Boolean = false;
		public function get InProgress():Boolean { return _InProgress; }
		private var _Aborted:Boolean = false;
		public function get Aborted():Boolean { return _Aborted; }
		private var _Finished:Boolean = false;
		public function get Finished():Boolean { return _Finished; }
		
		private var projectTitle:String;
		private var projectBytes:ByteArray;
		private var projectJSON:Object;
		private var projectStage:ScratchStage;
		private var projectAssetsMD5s:Array;
		private var projectAssetsMap:Object;
		
		public function RescratchedLoader(app:Scratch)
		{
			super(app);
		}
		
		///// Cancel the loading process
		public function AbortLoad():void
		{
			Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectAborted);
			_InProgress = false;
			_Aborted = true;
		}
		
		///// Finish the loading process
		public function FinishLoad():void
		{
			Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectFinished);
			_InProgress = false;
			_Finished = true;
		}
		
		///// Start of the process to download and install the entirety of a project from the Scratch servers
		public function BeginLoadSMEProject(projectID:String):void
		{
			_InProgress = true;
			
			var pIDClean:String = cleanProjectID(projectID);
			if (pIDClean == null)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectBadID(projectID));
				AbortLoad();
				return;
			}
			
			var bytesURL:String = Scratch.app.server.GetProjectBytesUrl(pIDClean);
			var titleURL:String = Scratch.app.server.GetProjectPageUrl(pIDClean);
			
			// Hand off to JS for now, which will return to us with the project data (hopefully)
			if (Scratch.app.jsEnabled)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectGetProject(pIDClean));
				// Must use JS to get the project data from SME
				Scratch.app.externalCall("JSSMELoadProjectBytes", null, bytesURL + "|" + titleURL);
				
				// Execution will resume in the ParseProjectBytesBase64() or ProjectLoadHTMLError() method
			}
			else
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectNoJS);
				AbortLoad();
				return;
			}
		}
		
		///// JS return calls this to send us the retrieved project bytes
		public function ParseProjectBytesBase64(encodedConcat:String):void
		{
			if (_Aborted)
				return;
				
			var splitValues:Array = encodedConcat.split("|");
			var projectEncoded:String = splitValues[0];
			var titleEncoded:String = splitValues[1];
			
			if (projectEncoded == null)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectGotNull);
				FinishLoad();
				return;
			}
			projectBytes = Base64Encoder.decode(projectEncoded);
			if (projectBytes.length == 0)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectZeroLength);
				FinishLoad();
				return;
			}
			else if (projectBytes.length < 10)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectNotEnoughBytes(projectBytes.length));
				FinishLoad();
				return;
			}
			else
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectProbablySuccessful(projectBytes.length));
				
				// Decode title
				var titleBytes:ByteArray = Base64Encoder.decode(titleEncoded);
				projectTitle = titleBytes.readUTFBytes(titleBytes.length);
				
				// Parse project bytes
				try
				{
					if (ObjReader.isOldProject(projectBytes)) // SB file
					{
						Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_ProjectBytesAreSB);
						Scratch.app.runtime.installProjectFromBytes(projectBytes, projectTitle);
						FinishLoad();
					}
					else if (bytesArePackedSB2(projectBytes)) // SB2 file
					{
						Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_ProjectBytesAreSB2);
						Scratch.app.runtime.installProjectFromBytes(projectBytes, projectTitle);
						FinishLoad();
					}
					else // Must be JSON (or garbage)
					{
						projectBytes.position = 0;
						projectJSON = util.JSON.parse(projectBytes.readUTFBytes(projectBytes.length));
						projectBytes.position = 0;
						
						if (projectJSON.hasOwnProperty("meta")) // SB3 project.json (Scratch 3.0, ick)
						{
							Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_ProjectBytesAreSB3JSON);
							FinishLoad();
						}
						else // SB2 project.json
						{
							Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_ProjectBytesAreSB2JSON);
							
							// Put into revert buffer
							Scratch.app.saveForRevert(projectBytes, false, false);
							
							// Retrieve the project assets from SME
							retrieveProjectAssets();
						}
					}
				}
				catch (error:Error)
				{
					Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_ProjectGenericInstallFail);
				}
			}
		}
		public function ProjectLoadHTMLError(errorCode:String):void
		{
			Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectHTMLError(errorCode, ". The provided ID is most likely a Scratch 3.0 project."));
			
			AbortLoad();
		}
		
		///// With the project JSON, we can now retrieve the project's assets and install the project
		private function retrieveProjectAssets():void
		{
			if (_Aborted)
				return;
				
			if (projectBytes == null || projectBytes.length < 10 || projectJSON == null)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectMissingData);
				AbortLoad();
				return;
			}
			
			projectStage = new ScratchStage();
			projectStage.readJSON(projectJSON);
			
			projectAssetsMD5s = getProjectAssetMD5s(projectStage.allObjects());
			var urlsString:String = "";
			for (var i:int = 0; i < projectAssetsMD5s.length; i++)
			{
				urlsString += Scratch.app.server.GetAssetUrl(projectAssetsMD5s[i]);
				if (i < projectAssetsMD5s.length - 1)
					urlsString += '|';
			}
			
			Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectGetAssets);
			Scratch.app.externalCall("JSSMELoadAllAssets", null, urlsString);
		}
		
		///// JS uses this to send retrieved assets bytes back to us for processing
		public function ParseAssetsBytesBase64(encoded:String):void
		{
			if (_Aborted)
				return;
				
			var assets:Array = encoded.split('|');
			var actualAssetCount:int = 0;
			for (var i:int = 0; i < assets.length; i++)
			{
				if (assets[i].length > 0)
					actualAssetCount++;
			}
			
			if (actualAssetCount != projectAssetsMD5s.length)
			{
				Scratch.app.LogToDebugConsole(DebugMessages.Tag_RescratchedLoader, DebugMessages.Msg_LoadSMEProjectAssetMismatch(actualAssetCount, projectAssetsMD5s.length));
				AbortLoad();
				return;
			}
			
			// Create asset map
			projectAssetsMap = new Object();
			for (var i:int = 0; i < projectAssetsMD5s.length; i++)
			{
				var decoded:ByteArray = Base64Encoder.decode(assets[i]);
				projectAssetsMap[projectAssetsMD5s[i]] = decoded;
			}
			
			// Complete the project install
			installAssets(projectStage.allObjects(), projectAssetsMap);
			app.runtime.decodeImagesAndInstall(projectStage);
			
			// Set project title on stage
			Scratch.app.setProjectName(projectTitle);
			
			FinishLoad();
		}
		
		//////////////////////////////////////////// HELPERS ////////////////////////////////////////////
		// Extract the id from a project URL
		private function cleanProjectID(input:String):String
		{
			if (input.length == 0)
				return null;
				
			if (input.match(/^\d+$/))
				return input;
			else
			{
				var marker:int = input.indexOf("projects/");
				if (marker < 0)
					return null;
				else
				{
					var spot:int = marker + 9;
					while (input.substr(spot, 1).match(/^\d+$/) && marker < input.length)
						spot++;
					return input.substring(marker + 9, spot);
				}
			}
		}
		// Check if a byte array is an SB2 file
		private function bytesArePackedSB2(bytes:ByteArray):Boolean
		{
			bytes.position = 0;
			var result:Boolean = (bytes.readUTFBytes(2) == "PK");
			bytes.position = 0;
			
			return result;
		}
		// Lists the MD5s of all of a project's assests
		private function getProjectAssetMD5s(objList:Array):Array
		{
			// Return list of MD5's for all project assets.
			var list:Array = new Array();
			for each (var obj:ScratchObj in objList)
			{
				for each (var c:ScratchCostume in obj.costumes)
				{
					if (list.indexOf(c.baseLayerMD5) < 0)
						list.push(c.baseLayerMD5);
					if (c.textLayerMD5)
						if (list.indexOf(c.textLayerMD5) < 0)
							list.push(c.textLayerMD5);
				}
				for each (var snd:ScratchSound in obj.sounds)
					if (list.indexOf(snd.md5) < 0)
						list.push(snd.md5);
			}
			return list;
		}
	}
}