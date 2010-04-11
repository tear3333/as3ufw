package org.rje.graphics.vector.brushes {
	import com.br.as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class CrossHatching extends AbstractBrush {
		
		private var length : Number;
		
		public function CrossHatching(params : BrushParams = null) {
			super(params);
			length = 10;
		}

		override public function doStroke(point : Vector2D) : void {

			if (!(point.x%2==0 && point.y%2==0)) return;	

			graphics.lineStyle(params.width, params.colour, 0.05);		
			
			graphics.moveTo(point.x-length, point.y);	
			graphics.lineTo(point.x+length, point.y);	
			graphics.moveTo(point.x, point.y-length);	
			graphics.lineTo(point.x, point.y+length);	
			
			lastPoint = point;
		}
	}
}
