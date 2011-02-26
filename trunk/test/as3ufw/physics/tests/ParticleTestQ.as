package as3ufw.physics.tests {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.constraints.Spring;
	import as3ufw.physics.renderers.SegmentCurveRenderer;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import org.rje.graphics.vector.brushes.BrushParams;



	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestQ extends ParticleTestBase {
		public var center : Particle;
		public var control : Particle;
		public var perpParticles : Vector.<Particle> = new Vector.<Particle>();
		public var currentAngle : Number = -100;

		public function ParticleTestQ() {
			super();
			group.damping = 0.8;

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

			addPart(-6);
			addPart(6);
			for (var i : int = -5; i < 5; i++) {
				addPart(i).colour = 0xFFFFFF;
			}
			removeChild(renderContext);
			renderContext.filters = [new DropShadowFilter()];
			group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, new BrushParams(1, 3)));
			// group.addRenderer(new GradientSegmentCurveRenderer(renderContext.graphics, 2, 0xF1ECD6,0xA9925C, 0.99));
			start();
		}

		public function addPart(indx : int) : Particle {
			var pp : Particle = Particle.GetParticle(new Vector2D());
			pp.userData.len = indx * 1.5;
			perpParticles.push(pp);
			pp.fixed = true;
			group.addParticle(pp);
			return pp;
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
			}

			engine.update();
			if (lmb)
				bmd.draw(renderContext, null, null, BlendMode.HARDLIGHT, null, true);
		}
	}
}
