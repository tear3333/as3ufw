package as3ufw.physics.renderers {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author Richard.Jewson
	 */
	public class TestPathRenderer  extends GraphicsRenderer {
		private var _join : Boolean;
		public var history : Vector.<GraphicsPath>;
		private var startOffset : int;
		private var _trail : int;

		public function TestPathRenderer(graphics : Graphics, brushParams : BrushParams) {
			super(graphics, brushParams);
			history = new Vector.<GraphicsPath>();
			startOffset = 0;
			_join = true;
		}

		override public function render(g : ParticleGroup) : void {
			if (!g.particles || g.particleCount < 3) return;

			var first : Vector2D;
			var last : Vector2D;
			var next : Vector2D;

			var gp : GraphicsPath = new GraphicsPath();
			history.push(gp);
			if (history.length > trail)
				history.shift();
			first = g.particles.pos.interp(0.5, g.particles.next.pos);
			last = first.clone();
			gp.moveTo(last.x, last.y);

			var particle : Particle = g.particles.next;
			while (particle.next) {
				next = particle.pos.interp(0.5, particle.next.pos);
				gp.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
				last.copy(next);
				particle = particle.next;
			}
			if (join) {
				next = particle.pos.interp(0.5, g.particles.pos);
				gp.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
				gp.curveTo(g.particles.pos.x, g.particles.pos.y, first.x, first.y);
			}
			// var aa:Number = 0;
			// for each (var path : GraphicsPath in history) {
			// graphics.lineStyle(2, colour + (0x000000), aa, true, "normal", CapsStyle.NONE);
			// graphics.drawPath(path.commands, path.data);	
			// aa+=0.01;
			// }
		}

		public function get join() : Boolean {
			return _join;
		}

		public function set join(join : Boolean) : void {
			_join = join;
		}

		public function get trail() : int {
			return _trail;
		}

		public function set trail(trail : int) : void {
			_trail = trail;
		}
	}
}
