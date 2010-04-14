package as3ufw.controls {
	import as3ufw.ui.controls.ScrollBarController;

	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class TestScrollBar extends ScrollBarController {
		
		private var refWidth : int		=  20;
		private var refHeight : int		= 100;
		private var thumbHeight : int	=  40;
		
		public function TestScrollBar(width:Number,fullHeight:Number,thumbHeight:Number) {
			
			super("", 
				createComponent( refWidth, refHeight,	0x303030), 
				createComponent( refWidth, thumbHeight,	0xA0A0A0), 
				createComponent( refWidth, refWidth,	0xFF0000), 
				createComponent( refWidth, refWidth,	0xFF0000));
		}
		
		public function createComponent(width:int,height:int,colour:uint):Sprite {
			var sprite:Sprite = new Sprite();
			with (sprite.graphics) {
				lineStyle(1,0);
				beginFill(colour);
				drawRect(0, 0, width, height);
				endFill();
			}
			return sprite;
		}
		
	}
}
