package inappd 
{
	/**
	 * Collection of messages which are used by the DebugConsole
	 * @author TiberiumFusion
	 */
	
	import flash.text.TextFormat;
	
	public class DebugMessages
	{
		//////////////////////////////////////////// Debug Tags ////////////////////////////////////////////
		
		///// Standard message tags. Always 6 chars, where the first and last are either brackets or spaces
		public static const Tag_NeutralNoChange:FormattedString = new FormattedString("------", new TextFormat("InconsolataRegular", 12, 0x737373));
		public static const Tag_ValidUserCmd:FormattedString = new FormattedString("    >>", new TextFormat("InconsolataBold", 12, 0x353535));
		public static const Tag_InvalidUserCmd:FormattedString = new FormattedString("---- x", new TextFormat("InconsolataRegular", 12, 0xB32222));
		public static const Tag_BadUserInput:FormattedString = new FormattedString("xxxx x", new TextFormat("InconsolataRegular", 12, 0xE2760A));
		public static const Tag_ScratchStage:FormattedString = new FormattedString("[SSTG]", new TextFormat("InconsolataBold", 12, 0x257317));
		public static const Tag_ServerClient:FormattedString = new FormattedString("[SVCL]", new TextFormat("InconsolataBold", 12, 0x1E9FBB));
		public static const Tag_RescratchedLoader:FormattedString = new FormattedString("[RSLD]", new TextFormat("InconsolataBold", 12, 0x2062AA));
		public static const Tag_ScratchRuntime:FormattedString = new FormattedString("[SRUN]", new TextFormat("InconsolataBold", 12, 0xB76A1E));
		
		
		//////////////////////////////////////////// Debug Messages ////////////////////////////////////////////
		
		///// Constant messages
		public static const Msg_SStageWent2D:FormattedStringList = new FormattedStringList(new FormattedString("Scratch stage render mode set to 2D", CSS.consoleTextRegularFormat));
		public static const Msg_SStageAlready2D:FormattedStringList = new FormattedStringList(new FormattedString("Scratch stage is already in 2D mode", CSS.consoleTextRegularFormat));
		public static const Msg_SStageWent3D:FormattedStringList = new FormattedStringList(new FormattedString("Scratch stage render mode set to 3D", CSS.consoleTextRegularFormat));
		public static const Msg_SStageAlready3D:FormattedStringList = new FormattedStringList(new FormattedString("Scratch stage is already in 3D mode", CSS.consoleTextRegularFormat));
		public static const Msg_TurboSetOn:FormattedStringList = new FormattedStringList(new FormattedString("Turbo mode enabled", CSS.consoleTextRegularFormat));
		public static const Msg_TurboAlreadyOn:FormattedStringList = new FormattedStringList(new FormattedString("Turbo mode is already enabled", CSS.consoleTextRegularFormat));
		public static const Msg_TurboSetOff:FormattedStringList = new FormattedStringList(new FormattedString("Turbo mode disabled", CSS.consoleTextRegularFormat));
		public static const Msg_TurboAlreadyOff:FormattedStringList = new FormattedStringList(new FormattedString("Turbo mode is already disabled", CSS.consoleTextRegularFormat));
		public static const Msg_ProjectBytesAreSB:FormattedStringList = new FormattedStringList(new FormattedString("Retrieved bytes are an SB file", CSS.consoleTextRegularFormat));
		public static const Msg_ProjectBytesAreSB2:FormattedStringList = new FormattedStringList(new FormattedString("Retrieved bytes are an SB2 file", CSS.consoleTextRegularFormat));
		public static const Msg_ProjectBytesAreSB2JSON:FormattedStringList = new FormattedStringList(new FormattedString("Retrieved bytes are (probably) Scratch 2.0 JSON", CSS.consoleTextRegularFormat));
		public static const Msg_ProjectBytesAreSB3JSON:FormattedStringList = new FormattedStringList(new FormattedString("Retrieved bytes are Scratch 3.0 JSON", CSS.consoleTextRegularFormat));
		public static const Msg_ParsingSBProject:FormattedStringList = new FormattedStringList(new FormattedString("Parsing SB project...", CSS.consoleTextRegularFormat));
		public static const Msg_ParsingSB2Project:FormattedStringList = new FormattedStringList(new FormattedString("Parsing SB2 project...", CSS.consoleTextRegularFormat));
		public static const Msg_ProjectGenericInstallFail:FormattedStringList = new FormattedStringList(new FormattedString("Project failed to install", CSS.consoleTextRegularFormat));
		public static const Msg_RescratchedLoaderConflict:FormattedStringList = new FormattedStringList(new FormattedString("Rescratched is already in the process of retrieving a project from scratch.mit.edu. You must wait for this to finish before retrieving another one.", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectNoJS:FormattedStringList = new FormattedStringList(new FormattedString("Cannot retrieve project, JS interface is unavailable", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectGotNull:FormattedStringList = new FormattedStringList(new FormattedString("Project data download failed, no data was retrieved", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectZeroLength:FormattedStringList = new FormattedStringList(new FormattedString("Project data download failed, received 0 bytes", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectGetAssets:FormattedStringList = new FormattedStringList(new FormattedString("Requesting project assets from scratch.mit.edu...", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectMissingData:FormattedStringList = new FormattedStringList(new FormattedString("RSLoader does not have sufficient data to continue loading this project", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectAborted:FormattedStringList = new FormattedStringList(new FormattedString("Project load aborted", CSS.consoleTextRegularFormat));
		public static const Msg_LoadSMEProjectFinished:FormattedStringList = new FormattedStringList(new FormattedString("Project load finished", CSS.consoleTextRegularFormat));
		public static const Msg_RuntimeInstallingEmptyProject:FormattedStringList = new FormattedStringList(new FormattedString("Installing empty project...", CSS.consoleTextRegularFormat));
		public static const Msg_RuntimeInstallingProject:FormattedStringList = new FormattedStringList(new FormattedString("Installing project...", CSS.consoleTextRegularFormat));
		public static const Msg_RuntimeInstalledProject:FormattedStringList = new FormattedStringList(new FormattedString("Projection installation complete", CSS.consoleTextRegularFormat));
		
		///// General message generators
		// DebugCommand input
		public static function Msg_NotEnoughArgs(expected:int, actual:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Insufficient arguments. Expected " + expected + ", got " + actual + ".", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_NotEnoughAtLeastArgs(expected:int, actual:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Insufficient arguments. Expected at least " + expected + ", got " + actual + ".", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_TooManyArgs(expected:int, actual:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Too many arguments. Expected " + expected + ", got " + actual + ".", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_BadArg(possibleValues:Array, actual:String, argPos:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			var enumerated:String = "";
			for (var i:uint = 0; i < possibleValues.length; i++)
			{
				enumerated += "\"" + String(possibleValues[i]) + "\"";
				if (i != possibleValues.length - 1)
					enumerated += ", ";
			}
			message.AddText(new FormattedString("Argument " + argPos + ": \"" + actual + "\" is invalid. Possible values: " + enumerated, CSS.consoleTextRegularFormat));
			return message;
		}
		// Svar URLs field reporting
		public static function Msg_ReportSvarURL(name:String, value:String):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("URL override ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(name, CSS.consoleTextBoldFormat));
			message.AddText(new FormattedString(" is currently ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(value, CSS.consoleTextBoldFormat));
			return message;
		}
		public static function Msg_SetSvarURL(name:String, value:String):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("URL override ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(name, CSS.consoleTextBoldFormat));
			message.AddText(new FormattedString(" has been set to ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(value, CSS.consoleTextBoldFormat));
			return message;
		}
		// RescratchedIO project loading
		public static function Msg_LoadSMEProjectBadID(badID:String):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("The specified project ID ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(badID, CSS.consoleTextBoldFormat));
			message.AddText(new FormattedString(" could not be parsed", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_LoadSMEProjectGetProject(projectID:String):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Requesting project data for ID ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(projectID, CSS.consoleTextBoldFormat));
			message.AddText(new FormattedString(" from scratch.mit.edu...", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_LoadSMEProjectHTMLError(errorCode:String, extra:String = null):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Project data download failed, HTTP request error ", CSS.consoleTextRegularFormat));
			message.AddText(new FormattedString(errorCode, CSS.consoleTextBoldFormat));
			if (extra != null)
				message.AddText(new FormattedString(extra, CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_LoadSMEProjectNotEnoughBytes(length:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Project data download failed, only received " + length + " bytes", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_LoadSMEProjectProbablySuccessful(length:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Project data download finished, received " + length + " bytes", CSS.consoleTextRegularFormat));
			return message;
		}
		public static function Msg_LoadSMEProjectAssetMismatch(actual:int, expected:int):FormattedStringList
		{
			var message:FormattedStringList = new FormattedStringList();
			message.AddText(new FormattedString("Received mismatched number project assets. Got " + actual + ", expected " + expected, CSS.consoleTextRegularFormat));
			return message;
		}
	}
}