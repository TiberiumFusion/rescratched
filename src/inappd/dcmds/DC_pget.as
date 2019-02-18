package inappd.dcmds 
{
	/**
	 * Retrieves a project from the scratch.mit.edu servers
	 * @author TiberiumFusion
	 */
	
	import inappd.DebugCommand;
	import inappd.DebugCommandOrganizer;
	import inappd.DebugMessages;
	import inappd.FormattedString;
	import inappd.FormattedStringList;
	import ui.DebugConsole;
	import util.RescratchedLoader;
	
	public class DC_pget extends DebugCommand
	{	
		public function DC_pget(subargs:Array) 
		{
			super(subargs);
		}
		
		override public function Execute(dconsole:DebugConsole = null):void
		{
			if (subArgs.length == 0)
				dieNotEnoughArgs(dconsole, 1, 0);
			else if (subArgs.length > 1)
				dieTooManyArgs(dconsole, 1, subArgs.length);
			else
			{
				Scratch.app.LoadProjectFromSME(subArgs[0]);
			}
		}
	}
}