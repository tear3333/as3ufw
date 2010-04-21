package as3ufw.task {
	import as3ufw.asset.manager.AssetLoaderTaskManager;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.logging.appenders.TraceAppender;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetLoaderTest extends Sprite {

		private var _log : ILogger;

		public function AssetLoaderTest() {
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var traceAppender : TraceAppender = new TraceAppender();
			traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			_log = Log.getClassLogger(BasicTest);
			
			_log.info("Basic Test starting...");			
			
			var mgr:AssetLoaderTaskManager = new AssetLoaderTaskManager();
			
			mgr.add("1","test");
			
		}
	}
}
