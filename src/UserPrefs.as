package 
{
	import scratch.ProjectPrefs;
	/**
	 * Collection of user preferences. These are application-wide and are likely stored as a browser cookie or SOL.
	 * @author TiberiumFusion
	 */
	
	public class UserPrefs 
	{
		public var SavedataRescratchedExtras:Boolean = true;
		
		public var DefaultProjectPrefs:ProjectPrefs;
		
		public function UserPrefs()
		{
			DefaultProjectPrefs = new ProjectPrefs();
			DefaultProjectPrefs.InitialRenderMode = "2d";
			DefaultProjectPrefs.InitialTurbo = false;
			DefaultProjectPrefs.InitialFlashStageTargetFPS = 30;
		}
	}
}