package as3ufw.physics.renderers {
	import org.rje.graphics.vector.brushes.BrushParams;
	import flash.display.CapsStyle;

	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class ContinuousCurveRenderer extends GraphicsRenderer {

		private var _join : Boolean;

		public function ContinuousCurveRenderer(graphics : Graphics,brushParams:BrushParams) {
			super(graphics, brushParams);
			_join = true;
		}

		override public function render(g : ParticleGroup) : void {
			if (!g.particles || g.particleCount < 3) return;

			var first : Vector2D;
			var last : Vector2D;
			var next : Vector2D;

			var particle : Particle;

			brushParams.startDrawingMode(graphics);
			//graphics.lineStyle(brushParams.width, brushParams.colour, brushParams.alpha,brushParams.hinting,"normal",brushParams.caps);
			//Need to handle joined lines differently
			if (join) {
				
				first = g.particles.pos.interp(0.5, g.particles.next.pos);
				last = first.clone();
				graphics.moveTo(first.x, first.y);
				
				particle = g.particles.next;
				while (particle.next) {
					next = particle.pos.interp(0.5, particle.next.pos);
					graphics.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
					last.copy(next);
					particle = particle.next;
				}
				next = particle.pos.interp(0.5, g.particles.pos);
				graphics.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
				graphics.curveTo(g.particles.pos.x, g.particles.pos.y, first.x, first.y);
				
			} else {

				first = g.particles.pos.clone();
				last = first.clone();
				graphics.moveTo(first.x, first.y);		

				particle = g.particles.next;
				while (particle.next.next) {
					next = particle.pos.interp(0.5, particle.next.pos);
					graphics.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
					last.copy(next);
					particle = particle.next;
				}
				graphics.curveTo(particle.pos.x, particle.pos.y, particle.next.pos.x, particle.next.pos.y);
			}
			brushParams.endDrawingMode(graphics);
		}

		public function get join() : Boolean {
			return _join;
		}

		public function set join(join : Boolean) : void {
			_join = join;
		}
	}
}
