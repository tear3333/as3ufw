package as3ufw.physics.tests {
	import as3ufw.physics.AngularSpringConstraint;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.Spring;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.physics.renderers.SegmentCurveRenderer;

	import flash.display.BlendMode;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestM extends ParticleTestBase {
		private var invAttractor : Attractor;

		public function ParticleTestM() {
			super();

			var a:Particle = new Particle(new Vector2D(200,200));
			var b:Particle = new Particle(new Vector2D(200,300));
			var c:Particle = new Particle(new Vector2D(200,200));
			group.addParticle(a);
			//group.addParticle(b);
			//group.addParticle(c);
			b.mass = Number.POSITIVE_INFINITY;
			c.mass = Number.POSITIVE_INFINITY;

			group.iterations = 10;
			group.damping = 0.9;
			
			group.addSpring(new AngularSpringConstraint(a, b, c, 10, 10, 0.01));
			//group.addSpring(new Spring(a, c, 1));
			//group.addSpring(new Spring(b, c, 1));
			
			engine.addForceGenerator(new Attractor(Forces.Uniform, mousePos, -200,100));
			
			group.addRenderer(new PointRenderer(renderContext.graphics, 4));
			
			start();
		}

		override public function onEnterFrame(event : Event) : void {
			oldMousePos.copy(mousePos);
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;

			// invAttractor

			renderContext.graphics.clear();
			viewContext.graphics.clear();
			engine.update();
		}
	}
}
