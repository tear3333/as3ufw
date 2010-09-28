package app.core.view.events {
	import flash.events.Event;

	public class ViewEvent extends Event {
		public static const SHOW_START : String = 'showStart';
		public static const HIDE_START : String = 'hideStart';
		public static const SHOW_COMPLETE : String = 'showComplete';
		public static const HIDE_COMPLETE : String = 'hideComplete';

		public function ViewEvent(type : String) {
			super(type);
		}

		override public function clone() : Event {
			return super.clone();
		}
	}
}