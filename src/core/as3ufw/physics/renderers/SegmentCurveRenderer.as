package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class SegmentCurveRenderer extends GraphicsRenderer {

		public function SegmentCurveRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
		}

		override public function render(g : ParticleGroup) : void {
			var particle : Particle = g.particles;
			while (particle) {
				graphics.lineStyle(width, colour, alpha);
				graphics.moveTo( (particle.oldPos.x + particle.prevPos.x) * 0.5 , (particle.oldPos.y + particle.prevPos.y) * 0.5 );
				graphics.curveTo(particle.prevPos.x, particle.prevPos.y, (particle.pos.x + particle.prevPos.x) / 2, (particle.pos.y + particle.prevPos.y) / 2);
				particle = particle.next;
			}
		}
	}
}