package as3ufw.physics.renderers {
	import as3ufw.geom.twoD.LineUtils;
	import as3ufw.geom.Vector2D;
	import as3ufw.geom.twoD.CurveUtils;
	import flash.display.CapsStyle;

	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class SegmentCurveNormalRenderer extends GraphicsRenderer {

		public function SegmentCurveNormalRenderer(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) {
			super(graphics, width, colour, alpha);
		}

		override public function render(g : ParticleGroup) : void {
			var count:int = 0;
			var particle : Particle = g.particles;
			while (particle) {
				graphics.lineStyle(width, colour + (0x000000), alpha,true,"normal",CapsStyle.NONE);

				var points:Vector.<Vector2D> = CurveUtils.InterpolateQuadraticBezier(
					new Vector2D((particle.oldPos.x + particle.prevPos.x) * 0.5 , (particle.oldPos.y + particle.prevPos.y) * 0.5), 
					new Vector2D(particle.prevPos.x, particle.prevPos.y), 
					new Vector2D((particle.pos.x + particle.prevPos.x) * 0.5, (particle.pos.y + particle.prevPos.y) * 0.5), 
					5);
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
					  
				particle = particle.next;
				count++;
			}
		}
	}
}