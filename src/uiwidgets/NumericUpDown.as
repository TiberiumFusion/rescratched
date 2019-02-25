package uiwidgets 
{
	/**
	 * Holds a numeric user input that can be directly entered or incremented/decremented
	 * @author TiberiumFusion
	 */
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class NumericUpDown extends Sprite
	{
		private var frameWidth:int;
		private const frameHeight:int = 18;
		private const buttonsWidth:int = 14;
		private const buttonsHeight:int = 8;
		
		private var shape:Shape;
		
		private const tfFormat:TextFormat = new TextFormat(CSS.font, 12, 0x5C5C5C, null, null, null, null, null, TextFormatAlign.RIGHT);
		private var tf:TextField;
		private var tfTextPrev:String;
		
		private var inc:UpDownButton;
		private var dec:UpDownButton;
		
		private var _value:Number = 0;
		public function get Value():Number { return _value; }
		private var minimum:Number = 0;
		private var maximum:Number = 0;
		private var step:Number = 0;
		private var decimalPlaces:int = 0;
		
		public function NumericUpDown(width:int = 100, initialVal:Number = 0, min:Number = 0, max:Number = 100, step:Number = 0, decimalPlaces:int = 3)
		{
			this.frameWidth = width;
			
			_value = initialVal;
			minimum = min;
			maximum = max;
			this.step = step;
			if (decimalPlaces < 0 || decimalPlaces > 20) throw new Error("NumericUpDown decimalDigits must be between 0 and 20, inclusive.");
			this.decimalPlaces = decimalPlaces;
			
			shape = new Shape();
			addChild(shape);
			
			tf = new TextField();
			tf.defaultTextFormat = tfFormat;
			tf.type = TextFieldType.INPUT;
			tf.multiline = false;
			tf.wordWrap = false;
			tf.width = frameWidth - buttonsWidth - 2;
			tf.height = frameHeight;
			addChild(tf);
			tf.addEventListener(TextEvent.TEXT_INPUT, onTFChangedPreview);
			tf.addEventListener(FocusEvent.FOCUS_OUT, onTFFocusChange);
			//tf.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, onTFFocusChange);
			//tf.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onTFFocusChange);
			
			inc = new UpDownButton(buttonsWidth, buttonsHeight);
			addChild(inc);
			inc.x = frameWidth - buttonsWidth;
			inc.y = 1;
			inc.addEventListener(UpDownButtonEvent.CLICKED, onIncClicked);
			
			dec = new UpDownButton(buttonsWidth, buttonsHeight, true);
			addChild(dec);
			dec.x = frameWidth - buttonsWidth;
			dec.y = 1 + buttonsHeight + 1;
			dec.addEventListener(UpDownButtonEvent.CLICKED, onDecClicked);
			
			PerformLayout();
		}
		
		private function onIncClicked(event:Event):void
		{
			_value += step;
			tf.text = String(_value);
			ValidateInput();
		}
		private function onDecClicked(event:Event):void
		{
			_value -= step;
			tf.text = String(_value);
			ValidateInput();
		}
		
		private function onTFChangedPreview(event:TextEvent):void
		{
			tfTextPrev = tf.text;
			if (decimalPlaces == 0)
			{
				if (event.text.match(/[^\d\-]+/))
				{
					event.preventDefault();
					event.stopImmediatePropagation();
				}
			}
			else
			{
				if (event.text.match(/[^\d\-\.\,]+/))
				{
					event.preventDefault();
					event.stopImmediatePropagation();
				}
			}
		}
		private function onTFFocusChange(event:Event):void
		{
			if (isNaN(Number(tf.text)))
				tf.text = tfTextPrev;
				
			ValidateInput();
		}
		
		public function ValidateInput(sendEvent:Boolean = true):void
		{
			if (isNaN(Number(tf.text)))
				tf.text = "0";
			
			_value = Number(tf.text);
			if (_value < minimum) _value = minimum;
			if (_value > maximum) _value = maximum;
			formatDisplayValue(_value);
			
			if (sendEvent)
				dispatchEvent(new NumericUpDownEvent(NumericUpDownEvent.CHANGED, true, true, this));
		}
		
		public function SetValue(val:Number):void
		{
			_value = val;
			if (_value < minimum) _value = minimum;
			if (_value > maximum) _value = maximum;
			formatDisplayValue(_value);
		}
		
		private function formatDisplayValue(num:Number):void
		{
			if (decimalPlaces < 20)
			{
				var test:String = num.toFixed(decimalPlaces + 1); // toFixed rounds instead of simply truncating
				if (decimalPlaces == 0)
					tf.text = test.substr(0, test.length - 2);
				else
					tf.text = test.substr(0, test.length - 1);
			}
			else
				tf.text = num.toFixed(decimalPlaces);
		}
		
		public function PerformLayout():void
		{
			ValidateInput(false);
			
			var g:Graphics = shape.graphics;
			g.clear();
			g.lineStyle(1, 0xC0C0C0, 1, true);
			g.beginFill(0xF9F9F9);
			g.drawRect(0, 0, frameWidth, frameHeight);
			g.lineStyle(1, 0xC7C7C7, 1, true);
			g.moveTo(frameWidth - buttonsWidth - 1, 0);
			g.lineTo(frameWidth - buttonsWidth - 1, frameHeight);
			g.lineStyle(1, 0xA7A7A7, 1, true);
			g.moveTo(frameWidth - buttonsWidth - 1, buttonsHeight + 1);
			g.lineTo(frameWidth, buttonsHeight + 1);
			g.endFill();
			
			tf.width = frameWidth - buttonsWidth - 2;
			tf.x = 0;
			tf.y = 0;
		}
	}
}