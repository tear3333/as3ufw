package com.br.as3ufw.utils {
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class TestDrag extends Sprite {
		public function TestDrag() {
			
			var target:Sprite = new Sprite();
			target.graphics.lineStyle(1,0);
			target.graphics.beginFill(0);
			target.graphics.drawRect(0, 0, 20, 100);
			target.graphics.endFill();
			target.x = 100;
			target.y = 100;
			addChild(target);
			target.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
		}

		private function beginDrag(event : MouseEvent) : void {
			stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			Drag.start(DisplayObject(event.target),false,new Rectangle(100,50,0,200));
		}
		private function endDrag(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			Drag.stop();
		}
	}
}

