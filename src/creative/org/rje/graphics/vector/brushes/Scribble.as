package org.rje.graphics.vector.brushes {
	import com.br.as3ufw.geom.Vector2D;

	import flash.display.Shape;

	/**
	 * @author Richard.Jewson
	 */
	public class Scribble extends AbstractBrush implements IBrush {

		private var threshold : Number;
		private var capDistance : Number;

		public function Scribble(params:BrushParams = null, threshold:Number = 4000, capDistance:Number = 0.3) {
			super(params);
			this.threshold = threshold;
			this.capDistance = capDistance;
		}

		override public function doStroke(point:Vector2D) : void {
			
			graphics.lineStyle(params.width, params.colour, params.weight);
			graphics.moveTo(lastPoint.x, lastPoint.y);
			graphics.lineTo(point.x, point.y);
			
			points.search(point, threshold, this);
			
			lastPoint = point;
			points.addPoint(point);
		}

		override public function draw(point:Vector2D, targetPoint:Vector2D, ageDelta:Number, dSqr:Number, dX:Number, dY:Number ) : void {
			if (Math.random() > dSqr / (threshold/2)) {
				graphics.moveTo(point.x + (dX*capDistance), point.y + (dY*capDistance));
				graphics.lineTo(targetPoint.x - (dX*capDistance), targetPoint.y - (dY*capDistance));
			}
		}
	}
}
