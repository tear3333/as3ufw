package com.br.as3ufw.physics {
	import com.br.as3ufw.geom.Vector2D;
	import com.br.as3ufw.physics.emitters.PointEmitter;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestA extends ParticleTestBase {
		
		public var emitter:PointEmitter;

		public function ParticleTestA() {
			super();
			emitter = new PointEmitter();
			emitter.position = new Vector2D(300,200);
			emitter.velocity = 1;
			
			group.addEmitter(emitter);
			
			start();
		}
		
		override public function onEnterFrame(event : Event) : void {
			graphics.clear();
			emitter.angle+=0.5;
			var p:Particle = emitter.emit();
			//p.ttl = 3000;
			engine.update();
			//group.renderPoints(graphics, 1);
			group.renderCurveLine(graphics, 1);
		}
	}
}
