package scratch 
{
	/**
	 * Collection of user preferences that are specific to a project. These are saved within the project.json.
	 * @author TiberiumFusion
	 */
	
	public class ProjectPrefs 
	{
		// Fields prefixed with "Initial" are values that applied once (at project load) and are not changed by application lifecycle-bound actions (i.e. Ctrl + M, shift click green flag, etc.)
		public var InitialRenderMode:String;			// 2d, 3d
		public var InitialTurbo:Boolean;
		public var InitialFlashStageTargetFPS:Number;	// 1 to 240
		
		public function ProjectPrefs()
		{
			// Default ctor should be rarely used
		}
		public static function FromDefaultUserPrefs():ProjectPrefs
		{
			// A new collection of project preferences inherits applicable values from the application-wide UserPrefs
			return Scratch.app.userPrefs.DefaultProjectPrefs.Copy();
		}
		public static function FromJSONCompatibleObject(obj:Object):ProjectPrefs
		{
			var pp:ProjectPrefs = new ProjectPrefs();
			pp.InitialRenderMode = obj.InitialRenderMode;
			pp.InitialTurbo = obj.InitialTurbo;
			pp.InitialFlashStageTargetFPS = obj.InitialFlashStageTargetFPS;
			return pp;
		}
		
		private function copyFrom(other:ProjectPrefs):void
		{
			this.InitialRenderMode = other.InitialRenderMode;
			this.InitialTurbo = other.InitialTurbo;
			this.InitialFlashStageTargetFPS = other.InitialFlashStageTargetFPS;
		}
		public function Copy():ProjectPrefs
		{
			var newPP:ProjectPrefs = new ProjectPrefs();
			newPP.copyFrom(this);
			return newPP;
		}
		
		public function ToJSONCompatibleObject():Object
		{
			var obj:Object = new Object();
			obj.InitialRenderMode = this.InitialRenderMode;
			obj.InitialTurbo = this.InitialTurbo;
			obj.InitialFlashStageTargetFPS = this.InitialFlashStageTargetFPS;
			return obj;
		}
	}
}