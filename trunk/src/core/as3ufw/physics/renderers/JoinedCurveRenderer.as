package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class JoinedCurveRenderer extends GraphicsRenderer {

		public function JoinedCurveRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
		}
		
		override public function render(g : ParticleGroup) : void {
			if (!g.particles || g.particleCount < 3) return;

			graphics.lineStyle(width, colour, alpha);
			graphics.moveTo(g.particles.pos.x, g.particles.pos.y);

			var particle : Particle = g.particles.next;
			while (particle) {
				if (particle.next.next) {
					graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + particle.next.pos.x) / 2, (particle.pos.y + particle.next.pos.y) / 2);
				} else {
					graphics.curveTo(particle.pos.x, particle.pos.y, particle.next.pos.x, particle.next.pos.y);
					return;
				}
				particle = particle.next;
			}						
		}
	}
}
