package inappd 
{
	/**
	 * Special exception which is thrown by DebugCommands in order to cease exeuction early (e.g. from bad input)
	 * @author TiberiumFusion
	 */
	public class DCError extends Error
	{		
		public function DCError(message:String = null, id:int = 0) 
		{
			super(message, id);
		}	
	}
}