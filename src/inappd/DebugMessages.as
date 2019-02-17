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
		public static const Tag_ServerClient:FormattedString = new FormattedString("[SVCL]", new TextFormat("InconsolataBold", 12, 0xB55F11));
		
		
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
	}
}