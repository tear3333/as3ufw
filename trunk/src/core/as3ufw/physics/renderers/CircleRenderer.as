package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class CircleRenderer extends GraphicsRenderer {

		public function CircleRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
		}

		override public function render(g : ParticleGroup) : void {
			if (!g.particles || g.particleCount < 3) return;

			graphics.lineStyle(width, colour, alpha);
			graphics.beginFill(0xFF0000);
			graphics.moveTo( (g.particles.pos.x + g.particles.next.pos.x) * 0.5 , (g.particles.pos.y + g.particles.next.pos.y) * 0.5 );
			
			var particle : Particle = g.particles.next;
			while (particle) {
				if (particle.next) {
					graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + particle.next.pos.x) / 2, (particle.pos.y + particle.next.pos.y) / 2);
				} else {
					graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + g.particles.pos.x) / 2, (particle.pos.y + g.particles.pos.y) / 2);
					graphics.curveTo(g.particles.pos.x, g.particles.pos.y, (g.particles.pos.x + g.particles.next.pos.x) / 2, (g.particles.pos.y + g.particles.next.pos.y) / 2);
					return;
				}
				particle = particle.next;
			}
			graphics.endFill();					
		}
	}
}
