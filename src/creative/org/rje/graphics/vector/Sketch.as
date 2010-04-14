package org.rje.graphics.vector {
	import as3ufw.geom.Vector2D;

	import org.rje.graphics.vector.brushes.CrossHatching;
	import org.rje.graphics.vector.brushes.CrossShader;
	import org.rje.graphics.vector.brushes.Fur;
	import org.rje.graphics.vector.brushes.IBrush;
	import org.rje.graphics.vector.brushes.Scribble;
	import org.rje.graphics.vector.brushes.Shade;
	import org.rje.graphics.vector.space.PointSpace;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Richard.Jewson
	 */
	public class Sketch extends Sprite {

		public var points : PointSpace;
		public var mouseDown : Boolean;
		public var brushList : Array;
		public var brush : IBrush;
		public var canvasBMD : BitmapData;
		public var canvas : Bitmap;
		public var shape : Shape;

		public function Sketch() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event) : void {

			points = new PointSpace();
			brushList = [];

			canvasBMD = new BitmapData(1000, 800, false, 0xFFFFFF);			
			canvas = new Bitmap(canvasBMD, "auto", false);
			addChild(canvas);
			
			shape = new Shape();
			
			brush = new Scribble();
			brush.graphicsContext = shape.graphics;
			brush.pointSpace = points;
			brushList.push(brush);
			
			brush = new Shade();
			brush.graphicsContext = shape.graphics;
			brush.pointSpace = points;
			brushList.push(brush);
			
			brush = new Shade(null, false);
			brush.graphicsContext = shape.graphics;
			brush.pointSpace = points;
			brushList.push(brush);			

			brush = new CrossShader();
			brush.graphicsContext = shape.graphics;
			brush.pointSpace = points;
			brushList.push(brush);			

			brush = new CrossHatching();
			brush.graphicsContext = shape.graphics;
			brush.pointSpace = points;
			brushList.push(brush);			

			brush = new Fur();
			brush.graphicsContext = shape.graphics;
			brush.pointSpace = points;
			brushList.push(brush);			
			
			brush = brushList[0];
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		
		private function onMouseDown(event : MouseEvent) : void {
			mouseDown = true;
			brush.startStroke(new Vector2D(stage.mouseX, stage.mouseY));
			render();
		}

		private function onMouseUp(event : MouseEvent) : void {
			mouseDown = false;
			brush.endStroke(new Vector2D(stage.mouseX, stage.mouseY));
			render();
		}

		private function onMouseMove(event : MouseEvent) : void {
			if (mouseDown) {
				brush.doStroke(new Vector2D(stage.mouseX, stage.mouseY));
				render();
			}
		}

		private function onMouseWheel(event : MouseEvent) : void {
			var index : int = brushList.indexOf(brush);
			if (event.delta > 0) {
				if (index == 0) return;
				brush = brushList[index - 1];
			} else {
				if (index == brushList.length - 1) return;
				brush = brushList[index + 1];
			}
			trace(getQualifiedClassName(brush));
		}

		private function render() : void {
			canvasBMD.draw(shape, null, null, BlendMode.NORMAL);
			shape.graphics.clear();
		}

		private function onEnterFrame(event : Event) : void {
			//canvasBMD.applyFilter(canvasBMD, canvasBMD.rect, new Point(0, 0), new BlurFilter(1.1,1.1,1));
			//var colourTransform : ColorTransform = new ColorTransform(1.01, 1.01, 1.01, 1);
			//canvasBMD.colorTransform(canvasBMD.rect, colourTransform);
		}
	}
}
