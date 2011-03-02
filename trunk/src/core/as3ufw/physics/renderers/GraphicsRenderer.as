package as3ufw.physics.renderers {
	import as3ufw.physics.ParticleGroup;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class GraphicsRenderer implements IRenderer {
		public var graphics : Graphics;
		public var brushParams : BrushParams;

		public function GraphicsRenderer(graphics : Graphics, brushParams : BrushParams) {
			this.graphics = graphics;
			this.brushParams = brushParams;
		}

		virtual public function render(g : ParticleGroup) : void {
		}
	}
}
