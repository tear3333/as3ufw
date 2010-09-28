package app.core.view.components {
	import app.core.view.events.ViewEvent;

	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.Event;

	public class BaseView extends Sprite {

		public function BaseView() {
			super();
			initialize();
		}

		public function show() : void {
			visible = true;
			dispatchEvent(new ViewEvent(ViewEvent.SHOW_START));
		}

		public function hide() : void {
			dispatchEvent(new ViewEvent(ViewEvent.HIDE_START));
		}

		protected function initialize() : void {
		}

		protected function show_complete(event : Event = null) : void {
			dispatchEvent(new ViewEvent(ViewEvent.SHOW_COMPLETE));
		}

		protected function hide_complete(event : Event = null) : void {
			visible = false;
			dispatchEvent(new ViewEvent(ViewEvent.HIDE_COMPLETE));
		}
	}
}