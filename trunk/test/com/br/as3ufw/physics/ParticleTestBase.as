package com.br.as3ufw.physics {
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestBase extends Sprite {

		public var engine : ParticleEngine;
		public var group : ParticleGroup;

		public function ParticleTestBase() {
			init();
		}

		public function init() : void {
			engine = new ParticleEngine();
			group = new ParticleGroup();
			engine.addGroup(group);
		}

		public function start() : void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, stop)
		}

		public function stop(e:Event=null) : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(event : Event) : void {
		}
	}
}
