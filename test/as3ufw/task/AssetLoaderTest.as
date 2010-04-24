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

		private var dict:Dictionary;
		private var timer:Timer;

		public function AssetLoaderTest() {
			
			dict = new Dictionary(true);
			timer = new Timer(100);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var traceAppender : TraceAppender = new TraceAppender();
			traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			_log = Log.getClassLogger(BasicTest);
			
			_log.info("AssetLoaderTest starting...");			
			
			var mgr : AssetLoaderTaskManager = new AssetLoaderTaskManager();
			
			dict["1"] = mgr.add("1", "./data/image1.png");
			dict["2"] = mgr.add("2", "./data/sample.css");
			dict["3"] = mgr.add("3", "./data/doc1.xml");
			dict["4"] = mgr.add("4", "./data/fake");
			
			mgr.addEventListener(TaskEvent.COMPLETE, onComplete);
			//mgr.addEventListener(TaskEvent.UPDATE, onUpdate);
			
			mgr.start();
			timer.start();
		}

		private function onTimer(event : TimerEvent) : void {
			for each (var i : IAssetLoader in dict) {
				_log.info(i);
			}
			_log.info('----');
		}

		private function onComplete(event : TaskEvent) : void {
			_log.info("done!");
			System.gc();
		}
		
		private var _log : ILogger = Log.getClassLogger(AssetLoaderTest);
		
	}
}
