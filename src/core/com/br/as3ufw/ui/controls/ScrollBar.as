package com.br.as3ufw.ui.controls {
	import com.br.as3ufw.ui.events.ScrollEvent;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class ScrollBar extends Sprite {

		private var orientation : String;
		private var prev : DisplayObject;
		private var next : DisplayObject;
		private var track : DisplayObject;
		private var thumb : DisplayObject;

		public function ScrollBar( orientation : String, prev : DisplayObject, next : DisplayObject, track : DisplayObject, thumb : DisplayObject ) {
			
			this.orientation = orientation;
			this.prev = prev;
			this.next = next;
			this.track = track;
			this.thumb = thumb;
			
			init();
		}

		private function init() : void {
			if (prev) prev.addEventListener(MouseEvent.MOUSE_DOWN, onPrevDown);
			if (next) next.addEventListener(MouseEvent.MOUSE_DOWN, onNextDown);
			track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbDown);
		}

		private function onPrevDown(event : MouseEvent) : void {
			repeatEvent(new ScrollEvent(ScrollEvent.Previous));
		}

		private function onNextDown(event : MouseEvent) : void {
			repeatEvent(new ScrollEvent(ScrollEvent.Next));
		}

		private function onTrackDown(event : MouseEvent) : void {
		}

		private function onThumbDown(event : MouseEvent) : void {
		}

		private function repeatEvent(scrollEvent : ScrollEvent) : void {
		}
	}
}
