package inappd 
{
	/**
	 * Reference collection & organizer of user commands that operate with the Debug Console
	 * @author TiberiumFusion
	 */
	
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import inappd.dcmds.*;
	
	public class DebugCommandOrganizer 
	{
		//////////////////////////////////////////// COMMANDS ////////////////////////////////////////////
		// Record of all valid commands and their associated generator function
		private static var MasterCommandList:Dictionary = new Dictionary();
		MasterCommandList["setrender"] = function(subargs:Array):DebugCommand { return new DC_setrender(subargs); };
		MasterCommandList["turbo"] = function(subargs:Array):DebugCommand { return new DC_turbo(subargs); };
		
		
		// Validates a command against the MasterCommandList
		private static function validateCmdTopLevelName(command:String):String
		{
			if (command.length == 0)
				return null;
			
			// Commands follow a format of: <toplevelname> <option1> <option2> etc. (w/o the < > chars)
			// This validation only processes the toplevelname. It is up to the DebugCommand itself to do further verification
				
			var cmdWords:Array = command.split(/\s/);
			
			if (MasterCommandList[cmdWords[0]] != null)
				return cmdWords[0];
			else
				return null;
		}
		
		// Validates a command without creating a DebugCommand object for it
		public static function ValidateCommand(command:String):Boolean
		{
			return (validateCmdTopLevelName(command) != null);
		}
		
		// Validates and creates a DebugCommand from an input string
		public static function ParseCommand(command:String):DebugCommand
		{
			var topLevelCommand:String = validateCmdTopLevelName(command);
			var subargs:Array = command.split(/\s/);
			subargs.shift();
			
			if (topLevelCommand == null)
				return null;
			else
				return MasterCommandList[topLevelCommand](subargs);
		}
	}
}