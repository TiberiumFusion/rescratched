package inappd.dcmds 
{
	/**
	 * Assign & echo relevant variables in Scratch.server
	 * @author TiberiumFusion
	 */
	
	import inappd.DebugCommand;
	import inappd.DebugCommandOrganizer;
	import inappd.DebugMessages;
	import inappd.FormattedString;
	import inappd.FormattedStringList;
	import ui.DebugConsole;
	
	public class DC_svar extends DebugCommand
	{
		private const validUrlFields:Array = [ "sitePrefix", "siteCdnPrefix", "assetPrefix", "assetCdnPrefix", "projectPrefix", "projectCdnPrefix", "internalAPI", "siteAPI", "staticFiles" ]
		
		public function DC_svar(subargs:Array) 
		{
			super(subargs);
		}
		
		override public function Execute(dconsole:DebugConsole = null):void
		{
			if (!Scratch.app.jsEnabled)
			{
				dconsole.HistoryAppendMessage(DebugMessages.Tag_ServerClient, DebugMessages.Msg_SvarNoJS);
				return;
			}
			
			if (subArgs.length == 0)
				dieNotEnoughAtLeastArgs(dconsole, 1, 0);
			else if (subArgs.length > 2)
				dieTooManyArgs(dconsole, 2, subArgs.length);
			else
			{
				var urlPick:String = subArgs[0];
				if (validUrlFields.indexOf(urlPick) == -1)
					dieBadArg(dconsole, validUrlFields, urlPick, 1);
				else
				{
					if (subArgs.length == 2) // Set the urlOverride
					{
						Scratch.app.server.SetURL(urlPick, subArgs[1]);
					}
					else // Report the urlOverride
					{
						if (dconsole == null)
							return;
						
						dconsole.HistoryAppendMessage(DebugMessages.Tag_ServerClient, DebugMessages.Msg_ReportSvarURL(urlPick, Scratch.app.server.GetURL(urlPick)));
					}
				}
			}
		}
	}
}