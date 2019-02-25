package uiwidgets 
{
	/**
	 * Control containing multiple radio buttons
	 * @author TiberiumFusion
	 */
	
	import flash.display.Sprite;
	 
	public class RadioButtonGroup extends Sprite
	{
		public var ButtonSpacing:int = 20;
		
		private var buttons:Vector.<RadioButton> = new Vector.<RadioButton>();
		
		public function RadioButtonGroup(...rest)
		{
			for each (var item:String in rest)
				AddOption(item);
		}
		
		private function onButtonSelected(e:RadioButtonEvent):void
		{
			selectButton(e.Sender);
		}
		private function selectButton(b:RadioButton):void
		{
			var selIndex:int = 0;
			for (var i:int = 0; i < buttons.length; i++)
			{
				var button:RadioButton = buttons[i];
				if (button == b)
				{
					button.Select();
					selIndex = i;
				}
				else
					button.Deselect();
			}
			
			dispatchEvent(new RadioButtonGroupEvent(RadioButtonGroupEvent.SELECTED, true, true, b.LabelText, selIndex, b.Tag));
		}
		
		public function SelectByLabel(labelText:String):void
		{
			for each (var button:RadioButton in buttons)
			{
				if (button.LabelText == labelText)
				{
					selectButton(button);
					break;
				}
			}
		}
		
		public function AddOption(text:String, tag:Object = null, index:int = -1):void
		{
			if (index == -1)
				index = buttons.length;
			for each (var b:RadioButton in buttons)
			{
				if (b.LabelText == text)
					throw new Error("A RadioButton with the label \"" + text + "\" already exists.");
			}
			
			var button:RadioButton = new RadioButton(text, tag);
			button.addEventListener(RadioButtonEvent.SELECTED, onButtonSelected, false, 0, true);
			buttons.splice(index, 0, button);
			addChild(button);
			
			PerformLayout();
		}
		
		public function RemoveOption(text:String):void
		{
			for (var i:int = 0; i < buttons.length; i++)
			{
				if (buttons[i].LabelText == text)
				{
					removeOptionAt(i);
					break;
				}
			}
			
			throw new Error("No RadioButton with the label \"" + text + "\" exists within this RadioButtonGroup");
		}
		public function RemoveOptionByIndex(index:int):void
		{
			if (index >= 0 && index < buttons.length)
				removeOptionAt(index);
		}
		private function removeOptionAt(i:int):void
		{
			removeChild(buttons[i]);
			buttons[i].removeEventListener(RadioButtonEvent.SELECTED, onButtonSelected);
			buttons.splice(i, 1);
			PerformLayout();
		}
		
		public function PerformLayout():void
		{
			var total:int = 0;
			for (var i:int = 0; i < buttons.length; i++)
			{
				buttons[i].PerformLayout();
				buttons[i].x = total + ((i > 0) ? ButtonSpacing : 0);
				total = buttons[i].x + buttons[i].GetActualWidth();
			}
		}
	}
}