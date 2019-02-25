package uiwidgets 
{
	/**
	 * Specific event fired by the NumericUpDown control when its value changes.
	 * @author TiberiumFusion
	 */
	
	import flash.events.Event;
	 
	public class NumericUpDownEvent extends Event
	{
		public static const CHANGED:String = "NumericUpDown_CHANGED";
		
		private var _sender:NumericUpDown;
		public function get Sender():NumericUpDown { return _sender; }
		
		public function NumericUpDownEvent(t:String, b:Boolean, c:Boolean, s:NumericUpDown)
		{
			super(t, b, c);
			_sender = s;
		}
	}
}