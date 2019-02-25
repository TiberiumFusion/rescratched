package uiwidgets 
{
	/**
	 * Specific event fired by the UpDownButton. For use with the NumericUpDown control.
	 * @author TiberiumFusion
	 */
	
	import flash.events.Event;
	 
	public class UpDownButtonEvent extends Event
	{
		public static const CLICKED:String = "UpDownButton_CLICKED";
		
		private var _sender:UpDownButton;
		public function get Sender():UpDownButton { return _sender; }
		
		public function UpDownButtonEvent(t:String, b:Boolean, c:Boolean, s:UpDownButton)
		{
			super(t, b, c);
			_sender = s;
		}
	}
}