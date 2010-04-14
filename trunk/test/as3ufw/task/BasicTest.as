package as3ufw.task {
	import as3ufw.asset.manager.AssetSet;
	import as3ufw.asset.tasks.impl.CSSLoaderTask;
	import as3ufw.asset.tasks.impl.ImageLoaderTask;
	import as3ufw.asset.tasks.impl.XMLLoaderTask;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.logging.appenders.TraceAppender;
	import as3ufw.task.events.TaskEvent;
	import as3ufw.task.manager.ConcurrentTaskManager;
	import as3ufw.utils.ObjectUtils;

	import taskTestSuite.support.TestTask;

	import flash.display.Sprite;
	import flash.net.URLRequest;

	/**
	 * @author Richard.Jewson
	 */
	public class BasicTest extends Sprite {
		
		private var _log : ILogger;
		
		private var assetSet:AssetSet;
		private var concurrentMgr:ConcurrentTaskManager;
		private var resultSet : Object;
		
		public function BasicTest() {
			
			var traceAppender:TraceAppender = new TraceAppender();
			traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			_log = Log.getClassLogger(BasicTest);
			
			_log.info("Basic Test starting...");
			
			assetSet = new AssetSet("main");
			resultSet = {};
			
			concurrentMgr = new ConcurrentTaskManager();
			
			concurrentMgr.addTask(new TestTask("TestTask 1",200));
			concurrentMgr.addTask(new TestTask("TestTask 2",300));
			concurrentMgr.addTask(new TestTask("TestTask 3",400));
			concurrentMgr.addTask(new TestTask("TestTask 4",500));
			concurrentMgr.addTask(new TestTask("TestTask 5",1000));
			
			concurrentMgr.addTask(new XMLLoaderTask("xml", new URLRequest("data/doc1.xml"),assetSet));
			//concurrentMgr.addTask(AssetTaskFactory.TaskByURLString("xml","data/doc1.xml"),assetSet);
			//AssetTaskFactory.TaskByURLString("xml","data/doc1.xml");
			
			
			concurrentMgr.addTask(new CSSLoaderTask("css", new URLRequest("data/sample.css"),assetSet));
			concurrentMgr.addTask(new ImageLoaderTask("image1", new URLRequest("data/image1.png"),assetSet));
			//concurrentMgr.addTask(new SWFLoaderTask("image", new URLRequest("http://www.nivea.co.uk/flash/main_navigation/main_navigation.swf")));
			
			//TODO This on tests a timed out task
			//concurrentMgr.addTask(new TestTask("TestTask 6",0));
			
			concurrentMgr.addEventListener(TaskEvent.COMPLETE, onComplete);
			
			_log.info("Basic Test isCancelable? : " + concurrentMgr.isCancelable);
			
			concurrentMgr.start();
		}
		
		private function onComplete(event : TaskEvent) : void {
			_log.info("ConcurrentMgr is complete.");
			_log.info("assetSet=" + assetSet.toString());
			_log.info("resultSet=" + ObjectUtils.toString(resultSet));
//			var result:Array = [];	
//			concurrentMgr.exec(function(result:Array){result.push(this.toString()+this.id);}, true, [result]);
//			for each (var s:String in result) {
//				_log.info(">"+s);
//			}
		}
	}
}
