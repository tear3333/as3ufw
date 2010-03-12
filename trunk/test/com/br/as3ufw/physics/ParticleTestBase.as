package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.emitters.Emitter;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestBase extends Sprite {
		
		public var engine:ParticleEngine;
		public var group:ParticleGroup;
		
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
		}

		public function stop() : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event : Event) : void {
		}
	}
}
