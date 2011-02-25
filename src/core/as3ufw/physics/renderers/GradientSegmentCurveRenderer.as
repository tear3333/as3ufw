package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;
	import as3ufw.utils.DisplayUtils;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.CapsStyle;
	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class GradientSegmentCurveRenderer extends GraphicsRenderer {
		private var targetColour : uint;

		public function GradientSegmentCurveRenderer(graphics : Graphics, brushParams : BrushParams, targetColour : uint = 0) {
			super(graphics, brushParams);
			this.targetColour = targetColour;
		}

		override public function render(g : ParticleGroup) : void {
			var count : int = 0;
			var particle : Particle = g.particles;
			while (particle) {
				if (particle.draw) {
					// graphics.lineStyle(width, DisplayUtils.interpolateColors(colour,0xA9925C,particle.userData.i), alpha,true,"normal",CapsStyle.NONE);
					graphics.lineStyle(brushParams.width, DisplayUtils.interpolateColors(brushParams.colour, targetColour, particle.userData.i), brushParams.alpha, brushParams.hinting, brushParams.caps);
					graphics.moveTo((particle.oldPos.x + particle.prevPos.x) * 0.5, (particle.oldPos.y + particle.prevPos.y) * 0.5);
					graphics.curveTo(particle.prevPos.x, particle.prevPos.y, (particle.pos.x + particle.prevPos.x) / 2, (particle.pos.y + particle.prevPos.y) / 2);
				}
				particle = particle.next;
				count++;
			}
		}
	}
}