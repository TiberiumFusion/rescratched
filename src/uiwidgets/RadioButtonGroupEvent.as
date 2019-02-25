package uiwidgets 
{
	/**
	 * Specific event fired by the RadioButtonGroup. For use by owners of RadioButtonGroup objects.
	 * @author TiberiumFusion
	 */
	
	import flash.events.Event;
	 
	public class RadioButtonGroupEvent extends Event
	{
		public static const SELECTED:String = "RadioButtonGroup_SELECTED";
		
		private var _buttonLabelText:String;
		public function get ButtonLabelText():String { return _buttonLabelText; }
		private var _buttonIndex:int;
		public function get ButtonIndex():int { return _buttonIndex; }
		private var _buttonTag:Object;
		public function get ButtonTag():Object { return _buttonTag; }
		
		public function RadioButtonGroupEvent(t:String, b:Boolean, c:Boolean, text:String, index:int, tag:Object)
		{
			super(t, b, c);
			_buttonLabelText = text;
			_buttonIndex = index;
			_buttonTag = tag;
		}
	}
}