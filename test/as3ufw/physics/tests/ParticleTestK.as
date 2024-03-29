package as3ufw.physics.tests {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.constraints.Spring;
	import as3ufw.physics.renderers.SegmentCurveRenderer;
	import flash.display.BlendMode;
	import flash.events.Event;
	import org.rje.graphics.vector.brushes.BrushParams;



	/**
	 * @author richard.jewson
	 */
	public class ParticleTestK extends ParticleTestBase {
		public var center : Particle;

		public function ParticleTestK() {
			super();
			group.damping = 0.8;

			var pos : Vector2D = new Vector2D(200, 200);
			center = Particle.GetParticle(pos);
			// group.addParticle(center);
			center.fixed = true;

			var p : Particle = Particle.GetParticle(pos);
			p.setMass(5);
			group.addParticle(p);

			var spring : Spring = new Spring(center, p, 1);
			group.addConstraint(spring);

			group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, new BrushParams(1, 3)));

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			center.pos.copy(mousePos);
			renderContext.graphics.clear();
			graphics.clear();
			engine.update();
			if (lmb)
				bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);
		}
	}
}
