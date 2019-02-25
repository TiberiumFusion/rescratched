package uiwidgets 
{	
	/**
	 * Used by the RadioButtonGroup
	 * @author TiberiumFusion
	 */
	
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class RadioButton extends Sprite
	{
		private var label:TextField;
		private const labelTextFormat:TextFormat = new TextFormat(CSS.font, 13, CSS.textColor);
		private var _labelText:String;
		public function get LabelText():String { return _labelText; }
		public var Tag:Object;
		
		private var button:SimpleButton;
		private var buttonUp:Sprite;
		private var buttonOver:Sprite;
		private var buttonDown:Sprite;
		private var buttonSelect:Shape;
		
		private var hitTest:Shape;
		
		private var selected:Boolean = false;
		
		public function RadioButton(text:String, tag:Object = null)
		{
			Tag = tag;
			
			buttonUp = new Sprite();
			var buttonUpCenter:Shape = new Shape();
			buttonUpCenter.graphics.beginFill(0xcecbce);
			buttonUpCenter.graphics.drawCircle(0, 0, 6);
			buttonUpCenter.graphics.endFill();
			var insetDS1:DropShadowFilter = new DropShadowFilter(3, 65, 0x8c8a8c, 1, 4, 4, 1, BitmapFilterQuality.LOW, true);
			buttonUpCenter.filters = [insetDS1];
			buttonUp.addChild(buttonUpCenter);
			var buttonUpBorder:Shape = new Shape();
			buttonUpBorder.graphics.lineStyle(1, 0xced3d6, 1, false);
			buttonUpBorder.graphics.beginFill(0x0, 0);
			buttonUpBorder.graphics.drawCircle(0, 0, 7);
			buttonUpBorder.graphics.endFill();
			buttonUp.addChild(buttonUpBorder);
			
			buttonOver = new Sprite();
			var buttonOverCenter:Shape = new Shape();
			buttonOverCenter.graphics.beginFill(0xD6D3D6);
			buttonOverCenter.graphics.drawCircle(0, 0, 6);
			buttonOverCenter.graphics.endFill();
			var insetDS2:DropShadowFilter = new DropShadowFilter(3, 65, 0xB3AEB3, 1, 4, 4, 1, BitmapFilterQuality.LOW, true);
			buttonOverCenter.filters = [insetDS2];
			buttonOver.addChild(buttonOverCenter);
			var buttonOverBorder:Shape = new Shape();
			buttonOverBorder.graphics.lineStyle(1, 0xced3d6, 1, false);
			buttonOverBorder.graphics.beginFill(0x0, 0);
			buttonOverBorder.graphics.drawCircle(0, 0, 7);
			buttonOverBorder.graphics.endFill();
			buttonUp.addChild(buttonOverBorder);
			
			buttonDown = new Sprite();
			var buttonDownCenter:Shape = new Shape();
			buttonDownCenter.graphics.beginFill(0xA09CA0);
			buttonDownCenter.graphics.drawCircle(0, 0, 6);
			buttonDownCenter.graphics.endFill();
			var insetDS3:DropShadowFilter = new DropShadowFilter(3, 65, 0x757375, 1, 4, 4, 1, BitmapFilterQuality.LOW, true);
			buttonDownCenter.filters = [insetDS3];
			buttonDown.addChild(buttonDownCenter);
			var buttonDownBorder:Shape = new Shape();
			buttonDownBorder.graphics.lineStyle(1, 0xced3d6, 1, false);
			buttonDownBorder.graphics.beginFill(0x0, 0);
			buttonDownBorder.graphics.drawCircle(0, 0, 7);
			buttonDownBorder.graphics.endFill();
			buttonDown.addChild(buttonDownBorder);
			
			_labelText = text;
			label = new TextField();
			label.defaultTextFormat = labelTextFormat;
			label.autoSize = TextFieldAutoSize.LEFT;
			label.selectable = false;
			label.text = _labelText;
			addChild(label);
			label.x = 19;
			
			hitTest = new Shape();
			
			button = new SimpleButton(buttonUp, buttonOver, buttonDown, hitTest);
			button.useHandCursor = false;
			addChild(button);
			
			buttonSelect = new Shape();
			buttonSelect.graphics.beginFill(0x000);
			buttonSelect.graphics.drawCircle(0, 0, 3);
			buttonSelect.graphics.endFill();
			addChild(buttonSelect);
			buttonSelect.visible = false;
			
			PerformLayout();
			
			button.addEventListener(MouseEvent.CLICK, onClicked);
		}
		private function onClicked(e:MouseEvent):void
		{
			Select();
			dispatchEvent(new RadioButtonEvent(RadioButtonEvent.SELECTED, true, true, this));
		}
		
		public function PerformLayout():void
		{
			button.x = 7;
			button.y = 10;
			buttonSelect.x = 7;
			buttonSelect.y = 10;
			
			hitTest.x = -7;
			hitTest.y = -8;
			hitTest.graphics.clear();
			hitTest.graphics.beginFill(0xFF0000, 0.0);
			hitTest.graphics.drawRect(0, 0, GetActualWidth(), 15);
			hitTest.graphics.endFill();
		}
		
		public function GetActualWidth():int
		{
			return 22 + label.textWidth;
		}
		
		public function SetLabelText(text:String):void
		{
			_labelText = text;
			label.text = _labelText;
			
			PerformLayout();
		}
		
		public function Select():void
		{
			selected = true;
			buttonSelect.visible = true;
		}
		
		public function Deselect():void
		{
			selected = false;
			buttonSelect.visible = false;
		}
	}
}