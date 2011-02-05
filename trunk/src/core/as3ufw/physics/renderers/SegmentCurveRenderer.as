package as3ufw.physics.renderers {
	import flash.display.CapsStyle;

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
			var count:int = 0;
			var particle : Particle = g.particles;
			while (particle) {
				if (particle.draw) {
					graphics.lineStyle(width, colour + (0x000000), alpha,true,"normal",CapsStyle.NONE);
					graphics.moveTo( (particle.oldPos.x + particle.prevPos.x) * 0.5 , (particle.oldPos.y + particle.prevPos.y) * 0.5 );
					graphics.curveTo(particle.prevPos.x, particle.prevPos.y, (particle.pos.x + particle.prevPos.x) / 2, (particle.pos.y + particle.prevPos.y) / 2);
				}
				particle = particle.next;
				count++;
			}
		}
	}
}