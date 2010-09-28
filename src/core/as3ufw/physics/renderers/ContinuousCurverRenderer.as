package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class ContinuousCurverRenderer extends GraphicsRenderer {
		
		private var _join : Boolean;
		
		public function ContinuousCurverRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
			_join = true;
		}

		override public function render(g : ParticleGroup) : void {
			if (!g.particles || g.particleCount < 3) return;

			graphics.lineStyle(width, colour, alpha);
			graphics.moveTo( (g.particles.pos.x + g.particles.next.pos.x) * 0.5 , (g.particles.pos.y + g.particles.next.pos.y) * 0.5 );
			
			var particle : Particle = g.particles.next;
			while (particle.next) {
				graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + particle.next.pos.x) / 2, (particle.pos.y + particle.next.pos.y) / 2);
				particle = particle.next;
			}
			if (_join) {
				graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + g.particles.pos.x) / 2, (particle.pos.y + g.particles.pos.y) / 2);
				graphics.curveTo(g.particles.pos.x, g.particles.pos.y, (g.particles.pos.x + g.particles.next.pos.x) / 2, (g.particles.pos.y + g.particles.next.pos.y) / 2);
			}
		}
		
		public function get join() : Boolean {
			return _join;
		}
		
		public function set join(join : Boolean) : void {
			_join = join;
		}
	}
}
