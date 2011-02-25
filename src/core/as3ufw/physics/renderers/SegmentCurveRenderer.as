package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class SegmentCurveRenderer extends GraphicsRenderer {
		public function SegmentCurveRenderer(graphics : Graphics, brushParams : BrushParams) {
			super(graphics, brushParams);
		}

		override public function render(g : ParticleGroup) : void {
			var count : int = 0;
			var particle : Particle = g.particles;
			while (particle) {
				if (particle.draw) {
					//brushParams.startDrawingMode(graphics, false);
					graphics.lineStyle(brushParams.width, particle.colour, brushParams.alpha,brushParams.hinting,"normal",brushParams.caps);
					graphics.moveTo((particle.oldPos.x + particle.prevPos.x) * 0.5, (particle.oldPos.y + particle.prevPos.y) * 0.5);
					graphics.curveTo(particle.prevPos.x, particle.prevPos.y, (particle.pos.x + particle.prevPos.x) / 2, (particle.pos.y + particle.prevPos.y) / 2);
				}
				particle = particle.next;
				count++;
			}
		}
	}
}