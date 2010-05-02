package as3ufw.task {
	import as3ufw.task.manager.ConcurrentTaskManager;
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

		private var cmgr : ConcurrentTaskManager;

		private var timer:Timer;

		public function AssetLoaderTest() {
			
			timer = new Timer(100);
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var traceAppender : TraceAppender = new TraceAppender();
			traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			_log = Log.getClassLogger(AssetLoaderTest);
			
			_log.info("AssetLoaderTest starting...");			
			
			cmgr = new ConcurrentTaskManager();
			
			cmgr.addTask(createMgr("a"));
			
			var sub:AssetLoaderTaskManager = createMgr("b");
			sub.addTask(createMgr("ba"));
			sub.addTask(createMgr("bb"));
			cmgr.addTask(sub);
			
			cmgr.addTask(createMgr("c"));
			
			cmgr.addEventListener(TaskEvent.COMPLETE, onComplete);
			cmgr.addEventListener(TaskEvent.UPDATE, onUpdate);
			
			cmgr.start();
			//timer.start();
		}


		private function createMgr(prefix:String) : AssetLoaderTaskManager {
			var mgr:AssetLoaderTaskManager = new AssetLoaderTaskManager();
			
			mgr.add(prefix+"1", "./data/image1.png");
			mgr.add(prefix+"2", "./data/sample.css");
			mgr.add(prefix+"3", "./data/doc1.xml");
			//mgr.add("4", "./data/fake");
			return mgr;
		}

		
		private function onTimer(event : TimerEvent) : void {
		}

		private function onUpdate(event : TaskEvent) : void {
			_log.info(cmgr + " " + cmgr.metrics);
		}

		private function onComplete(event : TaskEvent) : void {
			_log.info("done!");
			cmgr.destroy();
		}
		
		private var _log : ILogger = Log.getClassLogger(AssetLoaderTest);
		
	}
}
