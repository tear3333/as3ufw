package as3ufw.physics.tests {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.renderers.GradientSegmentCurveRenderer;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.utils.Random;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.BlendMode;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestM extends ParticleTestBase {
		public var center : Particle;
		private var invAttractor : Attractor;
		public var perpParticles : Vector.<Particle> = new Vector.<Particle>();

		public function ParticleTestM() {
			super();
			group.damping = 0.5;

			var pos : Vector2D = new Vector2D(mouseX, mouseY);
			center = Particle.GetParticle(pos);
			// group.addParticle(center);
			center.fixed = true;

			var points : int = 200;
			var mass1 : Number = 5.0;
			var mass2 : Number = 0.5;
			var baseMod : Number = 10.0;
			var partNum : Number = 100;

			for (var i : int = 0;i < points;i++) {
				var p : Particle = Particle.GetParticle(pos);
				// p.deltaT = 0.1*0.1;
				p.setMass(0.5 + (i * 1.5 / points));
				// i/20;
				group.addParticle(p);
				p.userData["i"] = Math.max(Math.min(i / points + Random.float(-0.5, 0.5), 1), 0);
				// p.userData["i"] = (Math.sin( (i/points) * (Math.PI) ));
				trace(p.userData["i"]);
				// var spring : Spring = new Spring(center, p, 10.1);
				// spring.length = 20;
				// group.addSpring(spring);
				perpParticles.push(p);
			}
			group.iterations = 1;
			// group.damping = 0.5;
			group.addRenderer(new PointRenderer(viewContext.graphics, new BrushParams(1,1)));
			group.addRenderer(new GradientSegmentCurveRenderer(renderContext.graphics, new BrushParams(0.15, 1, 0xF1ECD6), 0xA9925C));
			// group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, 3, 0x000000, 0.01));
			// invAttractor = new Attractor(Forces.Inverse,mousePos, 200);
			invAttractor = new Attractor(Forces.Inverse2, mousePos, 0.3);
			group.addForceGenerator(invAttractor);

			removeChild(renderContext);

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			oldMousePos.copy(mousePos);
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;

			// invAttractor

			center.pos.copy(mousePos);
			renderContext.graphics.clear();
			viewContext.graphics.clear();
			engine.update();
			if (lmb)
				bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);

			for each (var p:Particle in perpParticles) {
				p.userData.i += 0.01;
				// trace(p);
				if (p.userData.i > 1) p.userData.i = 00;
			}
		}
	}
}
