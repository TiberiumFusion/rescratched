package uiwidgets 
{
	/**
	 * Specific event fired by the RadioButton. For use in the RadioButtonGroup control.
	 * @author TiberiumFusion
	 */
	
	import flash.events.Event;
	 
	public class RadioButtonEvent extends Event
	{
		public static const SELECTED:String = "RadioButton_SELECTED";
		
		private var _sender:RadioButton;
		public function get Sender():RadioButton { return _sender; }
		
		public function RadioButtonEvent(t:String, b:Boolean, c:Boolean, s:RadioButton)
		{
			super(t, b, c);
			_sender = s;
		}
	}
}