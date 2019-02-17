package ui 
{
	/**
	 * Control that serves as a means to receive (and potentially send) in-app "debug" information/commands
	 * @author TiberiumFusion
	 */
	
	import flash.globalization.NumberFormatter;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.globalization.LocaleID;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import inappd.DCError;
	import inappd.DebugCommand;
	import inappd.DebugMessages;
	import inappd.FormattedString;
	import inappd.DebugCommandOrganizer;
	import inappd.FormattedStringList;
	import mx.utils.StringUtil;
	import uiwidgets.ScrollFrame;
	import uiwidgets.ScrollFrameContents;
	import util.Color;
	
	import uiwidgets.Scrollbar;
	
	public class DebugConsole extends Sprite
	{
		//////////////////////////////////////////// VARS ////////////////////////////////////////////
		public var LayoutTargetHeight:int = 200;
		private var layoutRequestedWidth:int;
		private var layoutRequestedHeight:int;
		private var graphicsAssist:Shape;
		
		private var topBrushBackground:int;
		private var topBrushBorder:int;
		private var historyBrushBackground:int;
		private var historyBrushBorder:int;
		private var inputBrushBackground:int;
		private var inputBrushBorder:int;
		
		private var history:TextField;
		private var historyCon:ScrollFrameContents;
		private var historyScroll:ScrollFrame;
		private var historyScrollHeight:int;
		
		private var inputHint:TextField;
		private var input:TextField;
		
		private var commandRecord:Vector.<String>;
		private var commandRecordSpot:uint;
		
		//////////////////////////////////////////// CTOR ////////////////////////////////////////////
		public function DebugConsole() 
		{
			init();
		}
		private function init():void
		{
			commandRecord = new Vector.<String>();
			
			addChild(graphicsAssist = new Shape());
			
			topBrushBackground = CSS.tabColor;
			topBrushBorder = CSS.borderDarker1Color;
			historyBrushBackground = CSS.panelColor;
			historyBrushBorder = CSS.borderColor;
			inputBrushBackground = CSS.panelColor;
			inputBrushBorder = CSS.borderDarker1Color;
			
			history = new TextField();
			history.type = TextFieldType.DYNAMIC;
			history.defaultTextFormat = CSS.consoleTextRegularFormat;
			history.multiline = true;
			history.embedFonts = true;
			history.cacheAsBitmap = true;
			history.antiAliasType = AntiAliasType.ADVANCED;
			history.mouseWheelEnabled = false;
			
			historyCon = new ScrollFrameContents();
			historyCon.color = historyBrushBackground;
			historyCon.hExtra = 0;
			historyCon.vExtra = 0;
			historyCon.AutoHScrollPadding = true;
			historyCon.AutoVScrollPadding = true;
			historyCon.addChild(history);
			
			historyScroll = new ScrollFrame();
			historyScroll.setContents(historyCon);
			historyScroll.allowVerticalScrollbar = true;
			historyScroll.allowHorizontalScrollbar = true;
			addChild(historyScroll);
			
			inputHint = new TextField();
			inputHint.type = TextFieldType.DYNAMIC;
			inputHint.defaultTextFormat = CSS.consoleTextBoldFormat;
			inputHint.embedFonts = true;
			inputHint.cacheAsBitmap = true;
			inputHint.antiAliasType = AntiAliasType.ADVANCED;
			inputHint.text = ">";
			inputHint.width = 20;
			addChild(inputHint);
			
			input = new TextField();
			input.type = TextFieldType.INPUT;
			input.defaultTextFormat = CSS.consoleTextRegularFormat;
			input.embedFonts = true;
			input.antiAliasType = AntiAliasType.ADVANCED;
			input.mouseWheelEnabled = false;
			input.multiline = false;
			addChild(input);
			
			// Listeners for visual reaction to user interaction with the input field
			function input_MouseOut(e:*):void
			{
				inputBrushBackground = CSS.panelColor;
				inputBrushBorder = CSS.borderDarker1Color;
				RedrawAllSolidRects();
			}
			function input_MouseOver(e:*):void
			{
				inputBrushBackground = CSS.panelLighterColor;
				inputBrushBorder = CSS.borderDarker2Color;
				RedrawAllSolidRects();
			}
			input.addEventListener(MouseEvent.MOUSE_OUT, input_MouseOut);
			input.addEventListener(MouseEvent.MOUSE_OVER, input_MouseOver);
			
			// Listener to catch special keys for input field
			function input_OnKeyDown(event:KeyboardEvent):void
			{
				// Enter key
				if (event.keyCode == 13 && input.text.length > 0)
				{
					var trimmed:String = StringUtil.trim(input.text);
					commandRecord.push(trimmed);
					commandRecordSpot = commandRecord.length;
					PushUserCommand(trimmed);
					input.text = "";
					event.preventDefault();
					event.stopImmediatePropagation();
				}
				// Up arrow
				else if (event.keyCode == 38)
				{
					if (commandRecordSpot > 0 && commandRecord.length > 0)
					{
						commandRecordSpot--;
						input.text = commandRecord[commandRecordSpot];
					}
				}
				// Down arrow
				else if (event.keyCode == 40)
				{
					if (commandRecordSpot < commandRecord.length - 1 && commandRecord.length > 0)
					{
						commandRecordSpot++;
						input.text = commandRecord[commandRecordSpot];
					}
				}
			}
			input.addEventListener(KeyboardEvent.KEY_DOWN, input_OnKeyDown);
		}
		
		// Process whatever the user has typed and execute it if it's a valid command
		public function PushUserCommand(command:String):void
		{
			var valid:Boolean = inappd.DebugCommandOrganizer.ValidateCommand(command);
			if (valid)
			{
				historyRecordValidCmd(command);
				
				var cmd:DebugCommand = inappd.DebugCommandOrganizer.ParseCommand(command);
				if (cmd != null) // Should never be null, but just in case
				{
					try
					{
						cmd.Execute(this);
					}
					catch (error:DCError)
					{
						// Commands may abort early due to bad input or other problems. This is always accomplished by throwing a DCError.
						// The aborting command itself is responsible for outputting relevant error details to the DebugConsole (before throwing).
					}
				}
			}
			else
			{
				historyRecordInvalidCmd(command);
			}
		}
		
		// User commands are sent to the history in two possible ways
		private function historyRecordValidCmd(command:String):void
		{
			var messageBody:FormattedStringList = new FormattedStringList(new FormattedString(command, CSS.consoleTextBoldFormat));
			HistoryAppendMessage(DebugMessages.Tag_ValidUserCmd, messageBody);
		}
		private function historyRecordInvalidCmd(command:String):void
		{
			var messageBody:FormattedStringList = new FormattedStringList();
			messageBody.AddText(new FormattedString("\"" + command + "\"", CSS.consoleTextDarkerRegularFormat));
			messageBody.AddText(new FormattedString(" is not a valid command", CSS.consoleTextRegularFormat));
			HistoryAppendMessage(DebugMessages.Tag_InvalidUserCmd, messageBody);
		}
		
		// Formats message parts and adds it to the history
		public function HistoryAppendMessage(tag:FormattedString, message:FormattedStringList):void
		{
			var atMaxScrollV:Boolean = !historyScroll.canScrollDown();
			
			if (history.text.length > 0)
				history.appendText("\n");
				
			var now:Date = new Date();
			var datetag:String = "["; // Looks like: [01:23:45:678]    (always 14 chars, excluding trailing space)
			if (now.getHours() < 10)
				datetag += "0";
			datetag += now.getHours() + ":";
			if (now.getMinutes() < 10)
				datetag += "0";
			datetag += now.getMinutes() + ":";
			if (now.getSeconds() < 10)
				datetag += "0";
			datetag += now.getSeconds() + ":";
			if (now.getMilliseconds() < 10)
				datetag += "00";
			else if (now.getMilliseconds() < 100)
				datetag += "0";
			datetag += now.getMilliseconds() + "] ";
			
			var cursor:uint = history.text.length;
			history.appendText(datetag);
			history.setTextFormat(CSS.consoleTextBlackRegularFormat, cursor, history.text.length - 1);
			
			tag.AppendToTextField(history, " ");
			
			message.AppendToTextField(history);
			
			UpdateHistoryTextLayout();
			
			// When a new message is appended to the history, we only auto scroll if the vertical scroll was maxed before the new message was added
			if (atMaxScrollV)
				ScrollHistoryToBottom();
		}
		
		public function ScrollHistoryToBottom():void
		{
			historyScroll.ScrollToV(1.0);
		}
		
		// Draws the segments of this control that are exclusively drawn by the graphicsAssist object
		public function RedrawAllSolidRects():void
		{
			var sg:Graphics = graphicsAssist.graphics;			
			sg.clear();
			
			// Background
			sg.beginFill(topBrushBorder);
			sg.drawRect(0, 0, layoutRequestedWidth, layoutRequestedHeight);
			sg.beginFill(topBrushBackground);
			sg.drawRect(1, 1, layoutRequestedWidth - 2, layoutRequestedHeight - 2);
			
			// History frame
			historyScrollHeight = layoutRequestedHeight - 30;
			sg.beginFill(historyBrushBorder);
			sg.drawRect(3, 3, layoutRequestedWidth - 6, historyScrollHeight);
			sg.beginFill(historyBrushBackground);
			sg.drawRect(4, 4, layoutRequestedWidth - 8, historyScrollHeight - 2);
			
			// Input
			sg.beginFill(inputBrushBorder);
			sg.drawRect(3, 3 + historyScrollHeight + 2, layoutRequestedWidth - 6, 22);
			sg.beginFill(inputBrushBackground);
			sg.drawRect(4, 4 + historyScrollHeight + 2, layoutRequestedWidth - 8, 20);
			
			sg.endFill();
		}
		
		// Increases the history control's bounds if needed, should be called after changing history.text
		public function UpdateHistoryTextLayout():void
		{
			if ((history.width != history.textWidth + 8) || (history.height != history.textHeight + 6))
			{
				history.width = history.textWidth + 8;
				history.height = history.textHeight + 6;
				historyCon.updateSize();	
			}
		}
		
		// Determines and sets the layout for the entire control
		public function PerformLayout(targetLayoutWidth:int):void
		{
			layoutRequestedWidth = targetLayoutWidth;
			layoutRequestedHeight = this.LayoutTargetHeight;
			
			RedrawAllSolidRects();
			
			UpdateHistoryTextLayout();
			
			historyScroll.x = 6;
			historyScroll.y = 4;
			historyScroll.setWidthHeight(layoutRequestedWidth - 11, historyScrollHeight - 2);
			
			inputHint.x = 7;
			inputHint.y = 3 + historyScrollHeight + 3;
			
			input.x = 19;
			input.y = 3 + historyScrollHeight + 3;
			input.width = layoutRequestedWidth - 10 - 16;
		}
		
		// Per frame step
		public function Step():void
		{
			// Nothing much here
		}
	}
}