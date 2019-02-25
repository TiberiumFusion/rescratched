package uiwidgets 
{
	/**
	 * Used by the NumericUpDown control
	 * @author TiberiumFusion
	 */
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	public class UpDownButton extends Sprite
	{
		private var upShape:Shape;
		private var overShape:Shape;
		private var downShape:Shape;
		private var button:SimpleButton;
		
		public function set UseHandCursor(value:Boolean):void { button.useHandCursor = value; }
		
		public function UpDownButton(buttonWidth:int, buttonHeight:int, arrowUpsideDown:Boolean = false, useHand:Boolean = false)
		{
			var gradMat:Matrix = new Matrix();
			gradMat.createGradientBox(buttonWidth, buttonHeight, Math.PI / 2);
			
			const triangle:Vector.<Number> = new <Number>[buttonWidth*0.3,buttonHeight*0.7, buttonWidth*0.5,buttonHeight*0.2, buttonWidth*0.7,buttonHeight*0.7];
			const triangleInverted:Vector.<Number> = new <Number>[buttonWidth*0.3,buttonHeight*0.2, buttonWidth*0.5,buttonHeight*0.7, buttonWidth*0.7,buttonHeight*0.2];
			
			upShape = new Shape();
			upShape.graphics.beginGradientFill(GradientType.LINEAR, [0xE5E5E5, 0xCFCFCF], [100, 100], [0, 255], gradMat);
			upShape.graphics.drawRect(0, 0, buttonWidth, buttonHeight);
			upShape.graphics.beginFill(0x333333);
			upShape.graphics.drawTriangles(arrowUpsideDown ? triangleInverted : triangle);
			upShape.graphics.endFill();
			
			overShape = new Shape();
			overShape.graphics.beginGradientFill(GradientType.LINEAR, [0xF9F9F9, 0xEFEFEF], [100, 100], [0, 255], gradMat);
			overShape.graphics.drawRect(0, 0, buttonWidth, buttonHeight);
			overShape.graphics.beginFill(0x575757);
			overShape.graphics.drawTriangles(arrowUpsideDown ? triangleInverted : triangle);
			overShape.graphics.endFill();
			
			downShape = new Shape();
			downShape.graphics.beginGradientFill(GradientType.LINEAR, [0xB1B1B1, 0xCDCDCD], [100, 100], [0, 255], gradMat);
			downShape.graphics.drawRect(0, 0, buttonWidth, buttonHeight);
			downShape.graphics.beginFill(0x242424);
			downShape.graphics.drawTriangles(arrowUpsideDown ? triangleInverted : triangle);
			downShape.graphics.endFill();
			
			button = new SimpleButton(upShape, overShape, downShape, upShape);
			button.useHandCursor = useHand;
			addChild(button);
			
			button.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(event:MouseEvent):void
		{
			dispatchEvent(new UpDownButtonEvent(UpDownButtonEvent.CLICKED, true, true, this));
			event.stopImmediatePropagation();
		}
	}
}