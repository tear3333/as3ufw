package as3ufw.physics.renderers {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class PointRenderer extends GraphicsRenderer {

		public function PointRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
		}
		
		override public function render(g : ParticleGroup) : void {
			graphics.lineStyle(1, colour, alpha);
			var hw:Number = width/2;
			var particle : Particle = g.particles;
			while (particle) {
				graphics.drawRect(particle.pos.x-hw, particle.pos.y-hw, width, width);
				particle = particle.next;
			}
		}
	}
}
