package ui.windows
{
	/**
	 * Modal dialog to edit a project's preferences
	 * @author TiberiumFusion
	 */
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import scratch.ProjectPrefs;
	import uiwidgets.Button;
	import uiwidgets.FauxGroupBox;
	import uiwidgets.NumericUpDown;
	import uiwidgets.NumericUpDownEvent;
	import uiwidgets.RadioButton;
	import uiwidgets.RadioButtonGroup;
	import uiwidgets.RadioButtonGroupEvent;
	
	public class DialogProjectPreferences extends Sprite
	{
		//////////////////////////////////////////// VARS ////////////////////////////////////////////
		public static var Width:int = 530;
		public static var Height:int = 276;
		
		private const labelTextFormat:TextFormat = new TextFormat(CSS.font, 14, CSS.textColor);
		private const descTextFormat:TextFormat = new TextFormat(CSS.font, 12, 0x747578);
		
		private var shape:Shape;
		private var title:TextField;
		
		private var gbInitials:FauxGroupBox;
		private var gbInitialsDesc:TextField;
		
		private var labelRenderMode:TextField;
		private var renderModeRadio:RadioButtonGroup;
		
		private var labelTurbo:TextField;
		private var turboRadio:RadioButtonGroup;
		
		private var labelFlashFPS:TextField;
		private var flashFPSNumeric:NumericUpDown;
		
		private var buttonSave:Button;
		private var buttonApply:Button;
		private var buttonSaveApply:Button;
		private var buttonCancel:Button;
		
		private var tempPrefs:ProjectPrefs;
		
		//////////////////////////////////////////// CTOR ////////////////////////////////////////////
		public function DialogProjectPreferences(pp:ProjectPrefs)
		{
			tempPrefs = pp.Copy();
			init();
		}
		private function init():void
		{
			// Shape to draw frame structure
			shape = new Shape();
			addChild(shape);
			
			// GB for initial config settings
			gbInitials = new FauxGroupBox("Initial Player Settings", Width - 36, Height - 90);
			addChild(gbInitials);
			gbInitialsDesc = new TextField();
			gbInitialsDesc.defaultTextFormat = descTextFormat;
			gbInitialsDesc.selectable = false;
			gbInitialsDesc.multiline = true;
			gbInitialsDesc.wordWrap = true;
			gbInitialsDesc.text = "These settings are applied only once, when the project loads. To manually re-apply these settings, click the Apply button. Green flag shift-click, Ctrl+M, and similar actions will not change these settings.";
			addChild(gbInitialsDesc);
			
			// Title label
			title = new TextField();
			title.defaultTextFormat = CSS.titleFormat;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.selectable = false;
			title.text = "Project Properties";
			addChild(title);
			
			// Option render mode
			labelRenderMode = createLabel("Scratch stage render mode:");
			addChild(labelRenderMode);
			
			renderModeRadio = new RadioButtonGroup();
			renderModeRadio.AddOption("2D", "2d");
			renderModeRadio.AddOption("3D", "3d");
			addChild(renderModeRadio);
			if (tempPrefs.InitialRenderMode == "2d") renderModeRadio.SelectByLabel("2D");
			else if (tempPrefs.InitialRenderMode == "3d") renderModeRadio.SelectByLabel("3D");
			function renderModeRadio_Selected(e:RadioButtonGroupEvent):void { tempPrefs.InitialRenderMode = e.ButtonTag as String; }
			renderModeRadio.addEventListener(RadioButtonGroupEvent.SELECTED, renderModeRadio_Selected);
			
			// Option turbo mode
			labelTurbo = createLabel("Turbo mode:");
			addChild(labelTurbo);
			
			turboRadio = new RadioButtonGroup();
			turboRadio.AddOption("Disabled", false);
			turboRadio.AddOption("Enabled", true);
			addChild(turboRadio);
			if (tempPrefs.InitialTurbo) turboRadio.SelectByLabel("Enabled");
			else turboRadio.SelectByLabel("Disabled");
			function turboRadio_Selected(e:RadioButtonGroupEvent):void { tempPrefs.InitialTurbo = e.ButtonTag as Boolean; }
			turboRadio.addEventListener(RadioButtonGroupEvent.SELECTED, turboRadio_Selected);
			
			// Option flash stage fps
			labelFlashFPS = createLabel("Flash stage FPS:");
			addChild(labelFlashFPS);
			
			flashFPSNumeric = new NumericUpDown(60, 30, 1, 240, 1, 0);
			addChild(flashFPSNumeric);
			flashFPSNumeric.SetValue(tempPrefs.InitialFlashStageTargetFPS);
			function flashFPSNumeric_Changed(e:NumericUpDownEvent):void { tempPrefs.InitialFlashStageTargetFPS = e.Sender.Value; }
			flashFPSNumeric.addEventListener(NumericUpDownEvent.CHANGED, flashFPSNumeric_Changed);
			
			// Button Save
			buttonSave = new Button("Save", buttonOK_onClick);
			addChild(buttonSave);
			
			// Button Apply
			buttonApply = new Button("Apply", buttonApply_onClick);
			addChild(buttonApply);
			
			// Button Save & Apply
			buttonSaveApply = new Button("Save & Apply", buttonSaveApply_onClick);
			addChild(buttonSaveApply);
			
			// Button Cancel
			buttonCancel = new Button("Cancel", buttonCancel_onClick);
			addChild(buttonCancel);
			
			// Initial layout
			PerformLayout();
			// and ds filter
			var ds:DropShadowFilter = new DropShadowFilter();
			ds.blurX = ds.blurY = 8;
			ds.distance = 5;
			ds.alpha = 0.75;
			ds.color = 0x333333;
			filters = [ds];
			
			// Drag events
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function createLabel(labelText:String):TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = labelTextFormat;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			tf.text = labelText;
			return tf;
		}
		
		private function buttonOK_onClick():void
		{
			Scratch.app.stagePane.projectPrefs = tempPrefs;
			dispatchEvent(new DialogProjectPreferencesEvent(DialogProjectPreferencesEvent.REQUEST_CLOSE, true, true, this));
		}
		private function buttonApply_onClick():void
		{
			Scratch.app.ConfigFromProjPrefs(tempPrefs);
		}
		private function buttonSaveApply_onClick():void
		{
			Scratch.app.stagePane.projectPrefs = tempPrefs;
			Scratch.app.ConfigFromProjPrefs();
			dispatchEvent(new DialogProjectPreferencesEvent(DialogProjectPreferencesEvent.REQUEST_CLOSE, true, true, this));
		}
		private function buttonCancel_onClick():void
		{
			dispatchEvent(new DialogProjectPreferencesEvent(DialogProjectPreferencesEvent.REQUEST_CLOSE, true, true, this));
		}
		
		public function PerformLayout():void
		{
			var g:Graphics = shape.graphics;
			
			g.clear();
			
			// Title bar
			g.lineStyle(1, 0xB0B0B0, 1, true);
			var mat:Matrix = new Matrix();
			mat.createGradientBox(31, 31, Math.PI / 2);
			g.beginGradientFill(GradientType.LINEAR, [0xE0E0E0, 0xD0D0D0], [100, 100], [0, 255], mat);
			g.drawTriangles(new <Number>[1,31, 31,0, 31,31]);
			g.lineStyle();
			g.drawRect(30, 0, Width - 31, 31);
			g.beginFill(0xB0B0B0);
			g.drawRect(31, 0, Width - 31, 1);
			g.drawRect(Width - 1, 0, 1, 31);
			
			// Title label
			title.x = (Width / 2) - (title.textWidth / 2);
			title.y = 6;
			
			// Central region
			g.lineStyle(0.5, 0xB0B0B0, 1, true);
			g.beginFill(0xFFFFFF);
			g.drawRect(1, 1 + 30, Width - 2, Height - 30 - 2);
			
			const leftAlign:int = 20 + 10;
			var topAdv:int = 63;
			const vertSpacing:int = 10;
			
			// Initial settings GB
			gbInitials.x = 18;
			gbInitials.y = 40;
			gbInitialsDesc.x = leftAlign;
			gbInitialsDesc.y = topAdv;
			gbInitialsDesc.width = gbInitials.width - 10;
			topAdv += gbInitialsDesc.textHeight + 20;
			
			// Option render mode
			labelRenderMode.x = leftAlign;
			labelRenderMode.y = topAdv;
			renderModeRadio.x = labelRenderMode.x + labelRenderMode.textWidth + 20;
			renderModeRadio.y = labelRenderMode.y;
			topAdv += renderModeRadio.height + vertSpacing;
			
			// Option turbo
			labelTurbo.x = leftAlign;
			labelTurbo.y = topAdv;
			turboRadio.x = labelTurbo.x + labelTurbo.textWidth + 20;
			turboRadio.y = labelTurbo.y;
			topAdv += turboRadio.height + vertSpacing;
			
			// Option flash stage fps
			labelFlashFPS.x = leftAlign;
			labelFlashFPS.y = topAdv;
			flashFPSNumeric.x = labelFlashFPS.x + labelFlashFPS.textWidth + 20;
			flashFPSNumeric.y = labelFlashFPS.y;
			topAdv += flashFPSNumeric.height + vertSpacing;
			
			// Button Apply
			buttonApply.x = (Width / 2) - buttonApply.width - 18;
			buttonApply.y = Height - buttonApply.height - 15;
			
			// Button Save & Apply
			buttonSaveApply.x = buttonApply.x + buttonApply.width + 7;
			buttonSaveApply.y = buttonApply.y;
			
			// Button Cancel
			buttonCancel.x = buttonSaveApply.x + buttonSaveApply.width + 7;
			buttonCancel.y = buttonApply.y;
			
			// Button Save
			buttonSave.x = buttonApply.x - buttonSave.width - 7;
			buttonSave.y = buttonApply.y;
			
			g.endFill();
		}
		
		private function onMouseDown(evt:MouseEvent):void { if (evt.target == this || evt.target == title) startDrag(); }
		private function onMouseUp(evt:MouseEvent):void { stopDrag(); }
	}
}