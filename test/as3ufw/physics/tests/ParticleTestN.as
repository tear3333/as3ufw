package as3ufw.physics.tests {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.constraints.Spring;
	import as3ufw.physics.renderers.SegmentCurveNormalRenderer;
	import flash.display.BlendMode;
	import flash.events.Event;
	import org.rje.graphics.vector.brushes.BrushParams;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestN extends ParticleTestBase {

		public var center : Particle;

		public function ParticleTestN() {
			super();
			group.damping = 0.8;
			
			var pos : Vector2D = new Vector2D(200, 200);
			center = Particle.GetParticle(pos);
			//group.addParticle(center);
			center.fixed = true;
			
			for (var i : int = 0; i < 10; i++) {
				var p : Particle = Particle.GetParticle(pos);
				p.setMass(0.1*i);
				group.addParticle(p);	
					
				var spring : Spring = new Spring(center, p, 1);
				group.addConstraint(spring);
			}
			
			group.addRenderer(new SegmentCurveNormalRenderer(renderContext.graphics, new BrushParams(0.1,1)));

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
