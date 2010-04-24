package as3ufw.task {
	import flash.system.System;
	import as3ufw.asset.IAssetLoader;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.Dictionary;
	import as3ufw.asset.manager.AssetLoaderTaskManager;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.logging.appenders.TraceAppender;
	import as3ufw.task.events.TaskEvent;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetLoaderTest extends Sprite {

		private var mgr : AssetLoaderTaskManager;

		private var timer:Timer;

		public function AssetLoaderTest() {
			
			timer = new Timer(100);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var traceAppender : TraceAppender = new TraceAppender();
			traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			_log = Log.getClassLogger(BasicTest);
			
			_log.info("AssetLoaderTest starting...");			
			
			mgr = new AssetLoaderTaskManager();
			
			mgr.add("1", "./data/image1.png");
			mgr.add("2", "./data/sample.css");
			mgr.add("3", "./data/doc1.xml");
			mgr.add("4", "./data/fake");
			
			mgr.addEventListener(TaskEvent.COMPLETE, onComplete);
			//mgr.addEventListener(TaskEvent.UPDATE, onUpdate);
			
			mgr.start();
			//timer.start();
		}

		private function onTimer(event : TimerEvent) : void {
		}

		private function onComplete(event : TaskEvent) : void {
			_log.info("done!");
		}
		
		private var _log : ILogger = Log.getClassLogger(AssetLoaderTest);
		
	}
}
