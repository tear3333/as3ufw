package com.br.as3ufw.graphics.bitmap {
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ScaleBitmap {

		public static function draw(bmd : BitmapData, graphics : Graphics, newWidth : Number, newHeight : Number, inner : Rectangle, outer : Rectangle = null) : void {	
			
			if (outer == null) {
				outer = bmd.rect;
				//outer = new Rectangle(0, 0, sw, sh);
			}
			var widths : Array = [inner.left,inner.width,bmd.width - inner.right];
			var heights : Array = [inner.top,inner.height,bmd.height - inner.bottom];
			
			var matrix : Matrix = new Matrix();
			var offsetX : Number = 0;
			var offsetY : Number = 0;
			var dx : Number = 0;
			var dy : Number = 0;
			var dWidth : Number = 0;
			var dHeight : Number = 0;
			for ( var x:int = 0; x < 3; x++) {
				var width:Number = widths[x] as Number;
				dWidth = x == 1 ? newWidth - widths[0] - widths[2] : widths[x];
				dy = offsetY = 0;
				for (var y:int = 0; y < 3; y++) {
					var height:Number = heights[y] as Number;
					dHeight = y == 1 ? newHeight - heights[0] - heights[2] : heights[y];
					if (dWidth > 0 && dHeight > 0) {
						matrix.a = dWidth / width;
						matrix.d = dHeight / height;
						matrix.tx = -offsetX * matrix.a + dx;
						matrix.ty = -offsetY * matrix.d + dy;
						matrix.translate(-outer.left, -outer.top);

						graphics.beginBitmapFill(bmd, matrix, false, true);
						graphics.drawRect(dx - outer.left, dy - outer.top, dWidth, dHeight);
						graphics.endFill();
					}
					offsetY += height;
					dy += dHeight;
				}
				offsetX += width;
				dx += dWidth;
			}
		}
	}
}