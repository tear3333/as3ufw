package com.br.as3ufw.graphics {
	import flash.geom.Rectangle;
	import com.br.as3ufw.graphics.bitmap.ScaleBitmap;
	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class DisplayTest extends Sprite {

		[Embed(source="test1.png")]
		private var TestImage : Class;

		public function DisplayTest() {
			
			var imageBitmap : Bitmap = new TestImage();
			
			ScaleBitmap.draw(imageBitmap.bitmapData, graphics, 200, 150, new Rectangle(25,25,50,50));
			
		}
	}
}
