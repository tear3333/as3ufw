package as3ufw.physics.renderers {
	import as3ufw.geom.twoD.CurveUtils;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class ContinuousCurveNormalRenderer extends GraphicsRenderer {

		private var _join : Boolean;

		public function ContinuousCurveNormalRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
			_join = true;
		}

		override public function render(g : ParticleGroup) : void {
			if (!g.particles || g.particleCount < 3) return;

			var first:Vector2D;
			var last:Vector2D;
			var next:Vector2D;

			graphics.lineStyle(width, colour, alpha);
			first = g.particles.pos.interp(0.5, g.particles.next.pos);
			last = first.clone();
			graphics.moveTo(last.x,last.y);
			
			var particle : Particle = g.particles.next;
			while (particle.next) {
				next = particle.pos.interp(0.5, particle.next.pos);
				//graphics.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
				
				renderNormals(graphics, last, particle.pos,next,10);
				
				last.copy(next);
				particle = particle.next;
			}
			if (join) {
				next = particle.pos.interp(0.5, g.particles.pos);
				//graphics.curveTo(particle.pos.x, particle.pos.y, next.x, next.y);
				renderNormals(graphics, last, particle.pos,next,10);
				//graphics.curveTo(g.particles.pos.x, g.particles.pos.y, first.x, first.y);
				renderNormals(graphics, next, g.particles.pos,first,10);
			}
		}

		public function get join() : Boolean {
			return _join;
		}

		public function set join(join : Boolean) : void {
			_join = join;
		}
		
		private function renderNormals(g:Graphics,p0:Vector2D,p1:Vector2D,p2:Vector2D,steps:int):void {
				var points:Vector.<Vector2D> = CurveUtils.InterpolateQuadraticBezier(
					p0, 
					p1, 
					p2, 
					steps);
				var normal:Vector2D;
				for (var i : int = 1; i < points.length; i++) {
					var start:Vector2D = points[i-1];
					var delta:Vector2D = points[i].minus(start);
					normal = delta.leftHandNormal().mult(20);
					graphics.moveTo(start.x, start.y);
					graphics.lineTo(start.x+normal.x, start.y+normal.y);	  
				}
				var end:Vector2D = points[points.length-1];
				graphics.moveTo(end.x, end.y);
				graphics.lineTo(end.x+normal.x, end.y+normal.y);
		}
	}
}
