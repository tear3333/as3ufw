package as3ufw.task {
	import as3ufw.asset.manager.XMLConfigurationLoader;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.logging.appenders.TraceAppender;
	import as3ufw.task.events.TaskEvent;
	import as3ufw.task.manager.ConcurrentTaskManager;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Richard.Jewson
	 */
	public class ConfigAssetLoaderTest extends Sprite {

		private var cmgr : ConcurrentTaskManager;

		public function ConfigAssetLoaderTest() {
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var traceAppender : TraceAppender = new TraceAppender();
			traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			_log = Log.getClassLogger(ConfigAssetLoaderTest);
			
			_log.info("Starting...");			
			
			cmgr = new ConcurrentTaskManager();
			
			cmgr.addTask(new XMLConfigurationLoader("xmlloader", "./data/config.xml"));
			
			cmgr.addEventListener(TaskEvent.COMPLETE, onComplete);
			cmgr.addEventListener(TaskEvent.UPDATE, onUpdate);
			
			cmgr.start();
		}

		private function onUpdate(event : TaskEvent) : void {
			_log.info(cmgr + " " + cmgr.metrics);
		}

		private function onComplete(event : TaskEvent) : void {
			_log.info("done!");
			cmgr.destroy();
		}
		
		private var _log : ILogger = Log.getClassLogger(ConfigAssetLoaderTest);
		
	}
}
