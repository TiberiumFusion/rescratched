package uiwidgets 
{
	/**
	 * A groupbox visual that doesn't actually manage children objects.
	 * @author TiberiumFusion
	 */
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	 
	public class FauxGroupBox extends Sprite
	{
		private var header:TextField;
		private var shape:Shape;
		
		private var frameWidth:int;
		private var frameHeight:int;
		
		public function FauxGroupBox(headerText:String, width:int = 100, height:int = 100)
		{
			frameWidth = width;
			frameHeight = height;
			
			header = new TextField();
			header.autoSize = TextFieldAutoSize.LEFT;
			header.selectable = false;
			header.defaultTextFormat = new TextFormat(CSS.font, 13, 0x4F5051);
			header.text = headerText;
			addChild(header);
			
			shape = new Shape();
			addChild(shape);
			
			PerformLayout();
		}
		
		public function SetHeaderText(text:String):void
		{
			header.text = text;
			PerformLayout();
		}
		
		public function PerformLayout():void
		{
			header.x = 20;
			
			var yOff:int = 9;
			
			var g:Graphics = shape.graphics;
			g.clear();
			g.lineStyle(1, 0xB1B3B4, 1, true);
			g.moveTo(header.x - 8, yOff);
			g.lineTo(0, yOff);
			g.lineTo(0, frameHeight);
			g.lineTo(frameWidth, frameHeight);
			g.lineTo(frameWidth, yOff);
			g.lineTo(header.x + header.textWidth + 12, yOff);
		}
	}
}