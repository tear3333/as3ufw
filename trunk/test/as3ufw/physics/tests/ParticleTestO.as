package as3ufw.physics.tests {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.constraints.Spring;
	import as3ufw.physics.renderers.GradientSegmentCurveRenderer;
	import as3ufw.utils.Random;
	import flash.display.BlendMode;
	import flash.events.Event;
	import org.rje.graphics.vector.brushes.BrushParams;



	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestO extends ParticleTestBase {
		public var center : Particle;
		public var control : Particle;
		public var perpParticles : Vector.<Particle> = new Vector.<Particle>();
		public var currentAngle : Number = -100;

		public function ParticleTestO() {
			super();
			group.damping = 0.6;

			var pos : Vector2D = new Vector2D(200, 200);
			center = Particle.GetParticle(pos);
			// group.addParticle(center);
			center.fixed = true;

			control = Particle.GetParticle(pos);
			control.setMass(5);
			control.draw = false;
			group.addParticle(control);

			var spring : Spring = new Spring(center, control, 1);
			group.addConstraint(spring);

			for (var i : int = -20; i < 20; i++) {
				// if (i==0) continue;
				var pp : Particle = Particle.GetParticle(new Vector2D());
				pp.userData.len = i * 1.5;
				// pp.userData["i"] = (Math.sin( (i/40) * (Math.PI) ));
				pp.userData.i = Random.float(0.7, 1);
				perpParticles.push(pp);
				pp.fixed = true;
				group.addParticle(pp);
			}
			removeChild(renderContext);

			// group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, 1, 0x000000, 0.5));
			group.addRenderer(new GradientSegmentCurveRenderer(renderContext.graphics, new BrushParams(0.99, 2, 0xF1ECD6), 0xA9925C));
			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			center.pos.copy(mousePos);
			renderContext.graphics.clear();
			graphics.clear();

			var d : Vector2D = control.pos.minus(control.prevPos);
			var m : Number = d.magnitude;
			// trace(m);
			var n : Vector2D = d.normalize().leftHandNormal();
			for each (var perpPart:Particle in perpParticles) {
				perpPart.oldPos.copy(perpPart.prevPos);
				perpPart.prevPos.copy(perpPart.pos);
				perpPart.pos.copy(control.pos.plus(n.mult(perpPart.userData.len)));
				// perpPart.pos.copy(control.pos.plus(n.mult(perpPart.userData.len * Math.min((m/4),2))));
				// perpPart.pos.copy(d.mult(perpPart.userData.len));
				perpPart.userData.i += 0.01;
				if (perpPart.userData.i > 1) perpPart.userData.i = 00;
			}

			engine.update();
			if (lmb && m > 1)
				bmd.draw(renderContext, null, null, BlendMode.MULTIPLY, null, true);
		}
	}
}
