package as3ufw.utils {
	import as3ufw.logging.Log;
	import as3ufw.logging.appenders.TraceAppender;
	import as3ufw.ui.layout.LayoutItemProxy;
	import as3ufw.ui.layout.components.Canvas;

	import org.bytearray.display.ScaleBitmapSprite;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Richard.Jewson
	 */
	public class LayoutScratch extends Sprite {

		[Embed(source="background.png")]
		private var bg : Class;

		public function LayoutScratch() {
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var traceAppender : TraceAppender = new TraceAppender();
			//traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			var bgbm : Bitmap = new bg();
			var bgSprt : ScaleBitmapSprite = new ScaleBitmapSprite(bgbm.bitmapData, new Rectangle(10, 10, 157, 12));
			
			var c : Canvas = new Canvas(300, 300);
			c.backgroundAlpha = 1;
			c.backgroundColor = 0x101010;
			c.backgroundImage = bgSprt;
			c.x = 50;
			c.y = 50;
			addChild(c);
			
			c.addEventListener(MouseEvent.CLICK, function():void {
				c.backgroundImage = null;
			});
			
			var tf : TextField = new TextField();
			var proxy : LayoutItemProxy = c.addManagedChild(tf);
			
			proxy.margin.width = 20;
			proxy.top = 0;
			proxy.widthPercent = 1;
			//proxy.widthPercent = 2;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.text = 'This is canvas. this is a test, to see how I react to size a position';
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.background = true;
			tf.backgroundColor = 0x10FF0000;
			c.refresh();
			log(tf.width);
			log(c.mask);
		}
	}
}
