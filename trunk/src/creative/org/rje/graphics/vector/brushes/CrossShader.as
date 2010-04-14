package org.rje.graphics.vector.brushes {
	import as3ufw.utils.Random;
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class CrossShader extends AbstractBrush implements IBrush {
		private var threshold : Number;

		public function CrossShader(params : BrushParams = null, threshold:Number = 10000) {
			super(params);			
			this.threshold = threshold;
		}

		override public function startStroke(point : Vector2D) : void {
		}

		override public function doStroke(point : Vector2D) : void {
			
			points.search(point, threshold+Random.integer(threshold-threshold/2, threshold+threshold*2), this);
			
			lastPoint = point;
		}

		override public function endStroke(point : Vector2D) : void {
		}

		override public function draw(point : Vector2D, targetPoint : Vector2D, ageDelta : Number, dSqr : Number, dX : Number, dY : Number ) : void {
			trace((dSqr / (threshold/2)));
			if (Math.random() > dSqr / (threshold/2)) {
			//if (Math.random() > 0.96){//dSqr / (threshold / 2)) {
			//trace(1 - (dSqr / threshold));
				graphics.lineStyle(params.width, params.colour, ((1 - (dSqr / threshold)) * params.weight));
				graphics.moveTo(point.x, point.y);
				graphics.lineTo(targetPoint.x, targetPoint.y);
			}		
		}
	}
}
