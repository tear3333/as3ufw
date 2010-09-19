package as3ufw.physics.tests {
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.physics.forces.RelativeAttractor;
	import as3ufw.physics.renderers.JoinedCurveRenderer;
	import as3ufw.utils.Random;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.emitters.PointEmitter;
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
			group.addRenderer(new JoinedCurveRenderer(graphics,3));
			//group.addRenderer(new PointRenderer(graphics,3));
			
			group.addForceGenerator(new RelativeAttractor(mousePos, 20, 10));
			
			start();
		}
		
		override public function onEnterFrame(event : Event) : void {
			
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			
			graphics.clear();
			emitter.angle+=Random.float(0.45, 0.55);
			emitter.velocity = Random.float(0.95, 1.05);
			emitter.emit({ttl:10000});
			engine.update();
		}
	}
}
