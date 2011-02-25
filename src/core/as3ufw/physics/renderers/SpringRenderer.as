package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class SpringRenderer extends GraphicsRenderer {
		public function SpringRenderer(graphics : Graphics, brushParams : BrushParams) {
			super(graphics, brushParams);
		}

		override public function render(g : ParticleGroup) : void {
			graphics.lineStyle(1, brushParams.colour, brushParams.alpha);
			var hw : Number = brushParams.width / 2;
			var particle : Particle = g.particles;
			while (particle) {
				graphics.drawRect(particle.pos.x - hw, particle.pos.y - hw, brushParams.width, brushParams.width);
				particle = particle.next;
			}
		}
	}
}
