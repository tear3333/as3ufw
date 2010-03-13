package com.br.as3ufw.physics.tests {
	import com.br.as3ufw.utils.Random;
	import com.br.as3ufw.physics.Particle;
	import com.br.as3ufw.physics.ParticleTestBase;
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
			emitter.angle+=Random.float(0.45, 0.55);
			emitter.velocity = Random.float(0.95, 1.05);
			emitter.emit({ttl:10000});
			engine.update();
			//group.renderPoints(graphics, 1);
			group.renderCurveLine(graphics, 3);
		}
	}
}
