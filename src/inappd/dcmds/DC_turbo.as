package inappd.dcmds 
{
	/**
	 * Sets turbo mode on or off
	 * @author TiberiumFusion
	 */
	
	import inappd.DebugCommand;
	import inappd.DebugCommandOrganizer;
	import inappd.DebugMessages;
	import inappd.FormattedString;
	import inappd.FormattedStringList;
	import ui.DebugConsole;
	
	public class DC_turbo extends DebugCommand
	{
		private const validArgs:Array = [ "on", "off" ]
		
		public function DC_turbo(subargs:Array) 
		{
			super(subargs);
		}
		
		override public function Execute(dconsole:DebugConsole = null):void
		{
			// Validate arg count
			if (subArgs.length == 0)
				dieNotEnoughArgs(dconsole, 1, 0);
			else if (subArgs.length > 1)
				dieTooManyArgs(dconsole, 1, subArgs.length);
			else
			{
				// Validate arg
				var pick:String = subArgs[0];
				if (validArgs.indexOf(pick) == -1)
					dieBadArg(dconsole, validArgs, pick, 1);
				else
				{
					// Execute command
					if (pick == "on")
					{
						if (!Scratch.app.interp.turboMode)
							Scratch.app.toggleTurboMode();
						else
							if (dconsole != null)
								dconsole.HistoryAppendMessage(DebugMessages.Tag_NeutralNoChange, DebugMessages.Msg_TurboAlreadyOn);
					}
					else if (pick == "off")
					{
						if (Scratch.app.interp.turboMode)
							Scratch.app.toggleTurboMode();
						else
							if (dconsole != null)
								dconsole.HistoryAppendMessage(DebugMessages.Tag_NeutralNoChange, DebugMessages.Msg_TurboAlreadyOff);
					}
				}
			}
		}
	}
}