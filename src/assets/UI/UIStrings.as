package assets.UI 
{
	/**
	 * Centralized container for certain strings used in UI elements. Keeps horizontal scrollbars large in the classes that use these strings.
	 * @author TiberiumFusion
	 */
	public class UIStrings 
	{
		public static const DisplayProjectPreferences:Object =
		{
			dialogTitle: "Project Properties",
			gbInitials_header: "Initial Player Settings",
			gbInitials_desc: "These settings are applied only once, when the project loads. To manually re-apply these settings, click the Apply button. Green flag shift-click, Ctrl+M, and similar actions will not change these settings.",
			labelRenderMode: "Scratch stage render mode:",
			renderModeRadioOpt_2D: "2D",
			renderModeRadioOpt_3D: "3D",
			labelTurbo: "Turbo mode:",
			turboRadioOpt_Enabled: "Enabled",
			turboRadioOpt_Disabled: "Disabled",
			labelFlashFPS: "Flash stage FPS:",
			buttonSave: "Save",
			buttonApply: "Apply",
			buttonSaveApply: "Save & Apply",
			buttonCancel: "Cancel",
			helpPopup_OK: "OK",
			helpPopup_renderMode_title: "About: Scratch stage render mode",
			helpPopup_renderMode_desc: "Scratch has two modes for rendering sprites to the Scratch Stage.<br/><br/><b>2D mode</b> uses Flash's standard CPU renderer. <i>This is the recommended mode</i>, especially if your device has a weak GPU. 2D mode is the most visually accurate, renders SVGs correctly, and supports anti-aliasing, but has poor performance when the fisheye, whirl, pixelate, and mosaic effects are used.<br/><br/><b>3D mode</b> uses Flash's Stage3D renderer, which utilizes your computer's GPU. A capable GPU with decent memory and a fast bus, as well as a not-too-complex project, is necessary for this mode to outperform 2D mode. 3D mode often struggles to render SVGs correctly, but can manage the fisheye, whirl, pixelate, and mosaic effects at a decent speed.<br/><br/>Lines drawn by the pen blocks use a separate render method, and are not affected by the choice of 2D or 3D mode.<br/><br/>Vector graphics, especially large & complex ones, can easily bring both 2D and 3D mode to a crawl. Easily tesselatable vector shapes (i.e. triangles and rectangles) render much faster than other shapes.",
			helpPopup_turbo_title: "About: Turbo mode",
			helpPopup_turbo_desc: "Turbo Mode affects how much of a script the Scratch interpreter will execute per frame.<br/><br/><b>With Turbo Mode disabled</b>, scripts are suspended whenever they perform an action that requires a redraw. In other words, any pen stroke or change in a sprite's location/appearance will cause the executing script to pause until the Scratch Stage has been redrawn and a new frame begins.<br/><br/><b>With Turbo Mode enabled</b>, the entirety of every running script is executed from start to finish before the Scratch Stage is redrawn. Any pen stroke or change in a sprite's location/appearance will <i>not</i> suspend the script until the next frame. In particular, this allows for more than one pen stroke to be made per frame.<br/><br/>",
			helpPopup_flashFPS_title: "About: Flash stage FPS",
			helpPopup_flashFPS_desc: "Scratch runs within Flash, and is thus subject to the Flash runtime settings.<br/><br/>The Scratch stage, where sprites and pen strokes are displayed, is actually a kind of sprite itself within a greater stage: the Flash stage. By default, the Flash stage is configured for a target framerate of 30 FPS; that is, it will update and redraw no more than 30 times per second. Thus, the entire Scratch program, including the Scratch interpreter (which executes your project's scripts), cannot run faster than this target framerate. Increasing the Flash stage's target framerate will permit the entire Scratch program to update and redraw more times per second, at the expense of less computation & render time per frame.<br/><br/><i>A higher framerate will not magically make your project run faster.</i> Your project can only run as fast as your device can compute & render. The framerate is essentially an upper limit to how many of these update & render cycles are permitted per second.<br/><br/>Increasing the Flash stage FPS beyond 60 is rarely beneficial. Most monitors cannot refresh faster than 60 times per second, so a framerate over 60 will needlessly strain your device. Furthermore, the average human cannot \"see faster\" than 90 FPS.<br/><br/>When Turbo Mode is disabled, pen strokes and changes to sprite locations/appearances redraws synchronously with the Flash stage FPS. Because of this, increasing or decreasing the Flash stage FPS will directly affect the apparent speed of your project. For example, doubling the Flash stage FPS from 30 to 60 may cause sprites to move twice as fast.<br/><br/>The Interpreter Updates Per Second (IUPS) readout at the bottom-left of the Scratch stage can be used to determine what maximum framerate your project can manage. The IUPS value is the count of how many times per second the Scratch interpreter is currently updating & redrawing your project. If the IUPS is less than the Flash stage FPS, then your project is too intense to run at that target framerate. If the IUPS is even with the Flash stage FPS, then your project may benefit from a higher framerate."
		}
	}
}