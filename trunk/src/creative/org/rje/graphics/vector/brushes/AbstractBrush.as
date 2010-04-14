package org.rje.graphics.vector.brushes {
	import as3ufw.geom.Vector2D;

	import org.rje.graphics.vector.space.PointSpace;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractBrush implements IBrush {

		protected var graphics : Graphics;
		protected var lastPoint : Vector2D;
		protected var points : PointSpace;
		protected var params : BrushParams;		

		public function AbstractBrush( params : BrushParams = null ) {
			this.params = params ? params : BrushParams.standardParams.clone();
		}

		virtual public function startStroke(point : Vector2D) : void {
			lastPoint = point;
			points.addPoint(point);
		}

		virtual public function doStroke(point : Vector2D) : void {
			lastPoint = point;
			points.addPoint(point);
		}

		virtual public function endStroke(point : Vector2D) : void {
			points.addPoint(point);
		}

		virtual public function set pointSpace(points : PointSpace) : void {
			this.points = points;
		}

		public function set graphicsContext(graphics : Graphics) : void {
			this.graphics = graphics;
		}

		public function draw(point : Vector2D, targetPoint : Vector2D, ageDelta : Number, dSqr : Number, dX : Number, dY : Number ) : void {
		}
	}
}
