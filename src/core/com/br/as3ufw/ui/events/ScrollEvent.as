package com.br.as3ufw.ui.events {
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ScrollEvent extends Event {
		
		public static var Previous:String = "previous";
		public static var Next:String = "next";
		public static var Drag:String = "drag";
		
		public function ScrollEvent(type : String) {
			super(type, false, false);
		}
		
		override public function clone() : Event {
			return new ScrollEvent(this.type);
		}
	}
}