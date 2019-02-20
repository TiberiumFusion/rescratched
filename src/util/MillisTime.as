package util 
{
	/**
	 * Provides the current time in millis since the unix epoch
	 * @author TiberiumFusion
	 */
	
	import flash.utils.*;
	 
	public class MillisTime 
	{
		private static const dtInit:Number = new Date().time;
		private static const dtVM:int = getTimer();
		public static function MillisNow():Number
		{
			return dtInit + (CachedTimer.getCachedTimer() - dtVM);
		}
	}
}