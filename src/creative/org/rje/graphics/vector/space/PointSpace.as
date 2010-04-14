package org.rje.graphics.vector.space {
	import as3ufw.geom.Vector2D;

	import org.rje.graphics.vector.brushes.IBrush;

	/**
	 * @author Richard.Jewson
	 */
	public class PointSpace {

		public var points : Vector.<Vector2D>;

		public function PointSpace() {
			points = new Vector.<Vector2D>();
		}

		virtual public function addPoint(point : Vector2D) : void {
			points.push(point);
		}

		virtual public function removePoint(point : Vector2D) : void {
			var i : int = points.indexOf(point);
			if (i > -1) points.splice(i, 1);
		}

		virtual public function search(point : Vector2D, distance : Number, brush : IBrush) : void {
			var ageDelta : int = points.length;
			for each (var p : Vector2D in points ) {
				var dX : Number = p.x - point.x;
				var dY : Number = p.y - point.y;
				var dSqr : Number = dX * dX + dY * dY;
				if (dSqr < distance) {
					brush.draw(point, p, ageDelta, dSqr, dX, dY);
				}
				ageDelta--;
			}
		}
	}
}
