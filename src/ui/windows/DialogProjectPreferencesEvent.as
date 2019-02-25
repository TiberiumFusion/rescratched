package ui.windows 
{
	/**
	 * Events fired by the DialogProjectPreferences window
	 * @author TiberiumFusion
	 */
	
	import flash.events.Event;
	 
	public class DialogProjectPreferencesEvent extends Event
	{
		public static const REQUEST_CLOSE:String = "DialogProjectPreferences_REQUEST_CLOSE";
		
		private var _sender:DialogProjectPreferences;
		public function get Sender():DialogProjectPreferences { return _sender; }
		
		public function DialogProjectPreferencesEvent(t:String, b:Boolean, c:Boolean, s:DialogProjectPreferences)
		{
			super(t, b, c);
			_sender = s;
		}
	}
}