package as3ufw.ui.controls {
	import as3ufw.ui.events.ScrollEvent;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Richard.Jewson
	 */
	public class ScrollBarController extends Sprite {

		private var orientation : String;
		
		private var view : ScrollBar;
		//private var _length:Number;
		
		private var repeatTimer : Timer;
		public var firstRepeatDelay : int;
		public var repeatInterval : int;
		
		private var repeatingEvent : String;

		public function ScrollBarController( orientation : String, view:ScrollBar ) {
			
			this.orientation = orientation;
			this.view = view;
			
			init();
		}

		private function init() : void {
			view.track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
			view.thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbDown);
			if (view.prev) view.prev.addEventListener(MouseEvent.MOUSE_DOWN, onPrevDown);
			if (view.next) view.next.addEventListener(MouseEvent.MOUSE_DOWN, onNextDown);
			
			firstRepeatDelay = 300;
			repeatInterval = 50;
			
			repeatTimer = new Timer(firstRepeatDelay, 0);
			repeatTimer.addEventListener(TimerEvent.TIMER, onRepeatTimer);
		}

		private function onTrackDown(event : MouseEvent) : void {
			if ( mouseY - view.track.y < view.thumb.y) repeatEvent(ScrollEvent.PREVIOUS);
			else repeatEvent(ScrollEvent.NEXT);
		}

		private function onThumbDown(event : MouseEvent) : void {
		}

		private function onPrevDown(event : MouseEvent) : void {
			repeatEvent(ScrollEvent.PREVIOUS);
		}

		private function onNextDown(event : MouseEvent) : void {
			repeatEvent(ScrollEvent.NEXT);
		}

		private function repeatEvent(eventType : String) : void {
			repeatingEvent = eventType;
			stage.addEventListener(MouseEvent.MOUSE_UP, killRepeatEvent);
			dispatchEvent(new ScrollEvent(repeatingEvent));
			repeatTimer.delay = firstRepeatDelay;
			repeatTimer.start();
		}
		private function killRepeatEvent(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, killRepeatEvent);
			repeatTimer.reset();
		}

		private function onRepeatTimer(event : TimerEvent) : void {
			if (repeatTimer.currentCount > 0) repeatTimer.delay = repeatInterval;
			dispatchEvent(new ScrollEvent(repeatingEvent));
		}
		
//		public function get length() : Number {
//			return _length;
//		}
//		
//		public function set length(length : Number) : void {
//			_length = length;
//		}		
	}
}
