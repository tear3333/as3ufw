package com.br.as3ufw.physics.renderers {
	import com.br.as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class GraphicsRenderer implements IRenderer {
		
		protected var graphics : Graphics;
		protected var width : Number;
		protected var colour : uint;
		protected var alpha : Number;

		public function GraphicsRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			this.alpha = alpha;
			this.colour = colour;
			this.width = width;
			this.graphics = graphics;
		}
		
		virtual public function render(g : ParticleGroup) : void {
		}
	}
}
