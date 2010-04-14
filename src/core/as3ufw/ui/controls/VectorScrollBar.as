package as3ufw.ui.controls {
	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class VectorScrollBar extends ScrollBar {
		
		public function VectorScrollBar(orientation:String) {
			super(orientation);
		}
		
		override public function init() : void {
			_barWidth  = 20;
			_barLength = 100;
			
			track = new Sprite();
			thumb = new Sprite();
			prev = new Sprite();
			next = new Sprite();
			
			addChild(track);
			addChild(thumb);
			addChild(prev);
			addChild(next);

			super.init();
		}		
		
		override public function redraw() : void {
			if (useNextPrevButtons) {
				drawComponent( (prev as Sprite).graphics,  _barWidth, _barWidth,	0xFF0000); 
				prev.x = 0;
				prev.y = 0;
				drawComponent( (next as Sprite).graphics,  _barWidth, _barWidth,	0xFF0000);			
				drawComponent( (track as Sprite).graphics, _barWidth, _barLength - (2*_barWidth),	0x303030);
			} else {
				drawComponent( (track as Sprite).graphics, _barWidth, _barLength,	0x303030);
			}
			drawComponent( (thumb as Sprite).graphics, _barWidth, _thumbLength,	0xA0A0A0);
		}
		
		private function drawComponent(targetGraphics:Graphics,width:int,height:int,colour:uint):void {
			with (targetGraphics) {
				lineStyle(1,0);
				beginFill(colour);
				drawRect(0, 0, width, height);
				endFill();
			}
		}
		
	}
}
