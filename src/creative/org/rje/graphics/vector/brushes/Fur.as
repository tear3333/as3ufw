package org.rje.graphics.vector.brushes {
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class Fur extends AbstractBrush {
		
		private var threshold : Number;

		public function Fur(params : BrushParams = null) {
			super(params);
			threshold = 2000;
		}

		override public function doStroke(point : Vector2D) : void {
			
			graphics.lineStyle(params.width, params.colour, 0.025);
			//graphics.moveTo(lastPoint.x, lastPoint.y);
			//graphics.lineTo(point.x, point.y);
			
			points.search(point, threshold, this);
			
			lastPoint = point;
			points.addPoint(point);
		}

		override public function draw(point : Vector2D, targetPoint : Vector2D, ageDelta : Number, dSqr : Number, dX : Number, dY : Number ) : void {
			if (Math.random() > dSqr / threshold) {
				graphics.moveTo(point.x + (dX * Math.random()), point.y + (dY * Math.random()));
				graphics.lineTo(point.x - (dX * Math.random()), point.y - (dY * Math.random()));
			}
		}
	}
}
