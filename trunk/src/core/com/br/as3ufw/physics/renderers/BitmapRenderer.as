package com.br.as3ufw.physics.renderers {
	import com.br.as3ufw.physics.Particle;
	import com.br.as3ufw.physics.ParticleGroup;

	import flash.display.BitmapData;

	/**
	 * @author Richard.Jewson
	 */
	public class BitmapRenderer implements IRenderer {

		private var bitmapData : BitmapData;

		public function BitmapRenderer(bitmapData : BitmapData) {
			this.bitmapData = bitmapData;
		}

		virtual public function render(g : ParticleGroup) : void {
			var particle : Particle = g.particles;
			bitmapData.lock();
			while (particle) {
				bitmapData.setPixel(int(particle.pos.x), int(particle.pos.y), 0x000000);
				particle = particle.next;
			}
			bitmapData.unlock();
		}
	}
}
