package com.br.as3ufw.ui.events {
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ScrollEvent extends Event {
		
		public static var PREVIOUS:String = "previous";
		public static var NEXT:String = "next";
		public static var DRAG:String = "drag";
		
		public function ScrollEvent(type : String) {
			super(type, false, false);
		}
		
		override public function clone() : Event {
			return new ScrollEvent(this.type);
		}
	}
}
