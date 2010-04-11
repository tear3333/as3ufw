package org.rje.graphics.vector.brushes {
	import com.br.as3ufw.geom.Vector2D;

	import flash.display.Shape;

	/**
	 * @author Richard.Jewson
	 */
	public class Shade extends AbstractBrush implements IBrush {

		private var create : Boolean;
		
		public function Shade(params:BrushParams = null, create:Boolean = true) {
			super(params);			
			this.create = create;
		}
		
		override public function startStroke(point : Vector2D) : void {
		}

		override public function doStroke(point:Vector2D) : void {
			points.search(point, 1000, this)
			lastPoint = point;
			if (create) points.addPoint(point);
		}
		
		override public function endStroke(point : Vector2D) : void {
		}
		
		override public function draw(point:Vector2D, targetPoint:Vector2D, ageDelta:Number, dSqr:Number, dX:Number, dY:Number ) : void {
			//if (g < 2000 && Math.random() > g / (2000/2)) {
			graphics.lineStyle(params.width, params.colour, ((1 - (dSqr / 1000)) * params.weight));
			graphics.moveTo(point.x, point.y);
			graphics.lineTo(targetPoint.x, targetPoint.y);
		}
		
	}
}
