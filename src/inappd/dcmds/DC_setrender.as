package inappd.dcmds 
{
	/**
	 * Sets the render method of the Scratch Stage
	 * @author TiberiumFusion
	 */
	
	import inappd.DebugCommand;
	import inappd.DebugCommandOrganizer;
	import inappd.DebugMessages;
	import inappd.FormattedString;
	import inappd.FormattedStringList;
	import ui.DebugConsole;
	
	public class DC_setrender extends DebugCommand
	{
		private const validArgs:Array = [ "2d", "3d" ]
		
		public function DC_setrender(subargs:Array) 
		{
			super(subargs);
		}
		
		override public function Execute(dconsole:DebugConsole = null):void
		{
			SCRATCH::allow3d
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
						if (pick == "2d")
						{
							if (Scratch.app.isIn3D)
								Scratch.app.go2D();
							else
								if (dconsole != null)
									dconsole.HistoryAppendMessage(DebugMessages.Tag_NeutralNoChange, DebugMessages.Msg_SStageAlready2D);
						}
						else if (pick == "3d")
						{
							if (!Scratch.app.isIn3D)
								Scratch.app.go3D();
							else
								if (dconsole != null)
									dconsole.HistoryAppendMessage(DebugMessages.Tag_NeutralNoChange, DebugMessages.Msg_SStageAlready3D);
						}
					}
				}
			}
		}
	}
}