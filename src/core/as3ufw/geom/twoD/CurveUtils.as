package as3ufw.geom.twoD {
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class CurveUtils {
		
		/**
		 * P(t) = P0*(1-t)^2 + P1*2*(1-t)*t + P2*t^2
		 */
		static public function InterpolateQuadraticBezier(p0:Vector2D,p1:Vector2D,p3:Vector2D, steps:int ) : Vector.<Vector2D> {
			var results:Vector.<Vector2D> = new Vector.<Vector2D>();
			for (var i : int = 0; i < steps; i++) {
				var t:Number = i/steps;
				var u:Number = 1-t;
			    //P = P0*u*u + P1*2*u*t + P2*t*t
				results.push( p0.mult(u*u).plusEquals(p1.mult(2*u*t).plusEquals(p3.mult(t*t))) );
			}
			return results;
		}
	}
}
