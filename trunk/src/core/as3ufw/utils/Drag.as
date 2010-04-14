package com.br.as3ufw.utils {
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * Flash Player's startDrag() and stopDrag() do not track the mouse cursor 
	 * when it travels outside the stage. This class attempts to provide that functionality, 
	 * and also adds a couple of useful bells and whistles.
	 */	
	public class Drag {

		public static const EVENT_DRAG_STARTED : String = "event_drag_started";
		public static const EVENT_DRAG_STOPPED : String = "event_drag_stopped";

		private static var target : DisplayObject;
		private static var mouseX : Number;
		private static var mouseY : Number;

		private static var velocity : Number = 0;

		private static var dragtimer : Timer;
		private static var rect : Rectangle;

		/**
		 * Starts a drag.  Equivalent to startDrag().
		 * @param	target			The DisplayObject to be dragged
		 * @param	lockCenter		Specifies whether the draggable sprite is locked to the center of the mouse position (<code>true</code>), or locked to the point where the user first clicked the sprite (<code>false</code>).
		 * @param	bounds			The rectangle in which dragging is bounded
		 */
		public static function start(target : DisplayObject, lockCenter : Boolean = false, bounds : Rectangle = null) : void {
			
			setTarget(target);
			setRegistrationPoint(lockCenter);
			
			rect = bounds;
			if (bounds != null) {
				if (bounds.width < 0)	rect = new Rectangle(bounds.x + bounds.width, bounds.y, -bounds.width, bounds.height);
				if (bounds.height < 0) 	rect = new Rectangle(bounds.x, bounds.y + bounds.height, bounds.width, -bounds.height);
			}
			
			if (dragtimer == null) {
				dragtimer = new Timer(Math.floor(1000 / target.stage.frameRate), 0);
				dragtimer.addEventListener(TimerEvent.TIMER, dragTimerEvent);
			}
			dragtimer.start();
		}

		/**
		 * Stops a drag in progress.  Equivalent to stopDrag().
		 */
		public static function stop() : void {
			dragtimer.stop();
		}

		
		private static function setTarget(t : DisplayObject) : void {
			target = t;
		}

		private static function setRegistrationPoint(lockCenter : Boolean = false) : void {
			if (lockCenter) {
				mouseX = int(target.width / 2);
				mouseY = int(target.height / 2);
			} else {
				mouseX = target.mouseX;
				mouseY = target.mouseY;
			}
		}

		private static function dragTimerEvent(evt : TimerEvent) : void {
			update();
			evt.updateAfterEvent();
		}

		private static function update() : void {
			
			target.x = target.parent.mouseX - mouseX;
			target.y = target.parent.mouseY - mouseY;
			
			if (rect != null) {
				target.x = Math.min(target.x, rect.right);	
				target.x = Math.max(target.x, rect.left);
				target.y = Math.min(target.y, rect.bottom);	
				target.y = Math.max(target.y, rect.top);
			}
		}
	}
}