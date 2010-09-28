package as3ufw.geom.twoD {
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class LineUtils {
		static public function sideOfLine(line1:Vector2D,line2:Vector2D,testPoint:Vector2D) : Number {
			return (line2.x - line1.x) * (testPoint.y - line1.y) - (line2.y - line1.y) * (testPoint.x - line1.x);
		}
	}
}
