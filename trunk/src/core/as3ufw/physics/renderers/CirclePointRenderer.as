package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class CirclePointRenderer extends GraphicsRenderer {
		public function CirclePointRenderer(graphics : Graphics, brushParams : BrushParams) {
			super(graphics, brushParams);
		}

		override public function render(g : ParticleGroup) : void {
			graphics.lineStyle(1, brushParams.colour, brushParams.alpha);
			var hw : Number = brushParams.width / 2;
			var particle : Particle = g.particles;
			while (particle) {
				graphics.drawCircle(particle.pos.x - hw, particle.pos.y - hw, (particle.radius/2));
				particle = particle.next;
			}
		}
	}
}
