package as3ufw.physics {
	import as3ufw.geom.Vector2D;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestBase extends Sprite {

		public var engine : ParticleEngine;
		public var group : ParticleGroup;
		public var mousePos:Vector2D;
		
		public function ParticleTestBase() {
			init();
		}

		public function init() : void {
			engine = new ParticleEngine();
			group = new ParticleGroup();
			engine.addGroup(group);
			mousePos = new Vector2D();
		}

		public function start() : void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, stop);
		}

		public function stop(e:Event=null) : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(event : Event) : void {
		}
	}
}
