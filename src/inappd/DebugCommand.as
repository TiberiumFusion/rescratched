package inappd 
{
	import ui.DebugConsole;
	/**
	 * Represents an operation that is initiated by a user-typed command in the Debug Console
	 * This class should be considered semi-abstract. Only subclasses should be instantiated.
	 * @author TiberiumFusion
	 */
	
	public class DebugCommand 
	{
		protected var subArgs:Array;
		
		// Subclasses will use their ctor to initialize after super ctor (if needed)
		public function DebugCommand(subargs:Array)
		{
			this.subArgs = subargs;
		}
		
		// Subclasses will override this method with whatever operation their command will perform
		public function Execute(dconsole:DebugConsole = null):void
		{
			throw new Error("Execute() is not implemented for this class");
		}
		
		///// Some helpful die methods
		protected function dieNotEnoughArgs(dconsole:DebugConsole, expected:int, got:int):void
		{
			if (dconsole != null)
				dconsole.HistoryAppendMessage(DebugMessages.Tag_BadUserInput, DebugMessages.Msg_NotEnoughArgs(expected, got));
			throw new DCError("Not enough arguments");
		}
		protected function dieNotEnoughAtLeastArgs(dconsole:DebugConsole, expected:int, got:int):void
		{
			if (dconsole != null)
				dconsole.HistoryAppendMessage(DebugMessages.Tag_BadUserInput, DebugMessages.Msg_NotEnoughAtLeastArgs(expected, got));
			throw new DCError("Not enough at least arguments");
		}
		protected function dieTooManyArgs(dconsole:DebugConsole, expected:int, got:int):void
		{
			if (dconsole != null)
				dconsole.HistoryAppendMessage(DebugMessages.Tag_BadUserInput, DebugMessages.Msg_TooManyArgs(expected, got));
			throw new DCError("Too many arguments");
		}
		protected function dieBadArg(dconsole:DebugConsole, possibleValues:Array, actual:String, argPos:int):void
		{
			if (dconsole != null)
				dconsole.HistoryAppendMessage(DebugMessages.Tag_BadUserInput, DebugMessages.Msg_BadArg(possibleValues, actual, argPos));
			throw new DCError("Bad argument");
		}
	}
}