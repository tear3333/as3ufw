package com.br.as3ufw.task.test {
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.asset.tasks.impl.CSSLoaderTask;
	import com.br.as3ufw.asset.tasks.AssetTaskFactory;
	import flash.system.Security;

	import com.br.as3ufw.asset.tasks.impl.SWFLoaderTask;

	import flash.net.URLRequest;
	import com.br.as3ufw.asset.tasks.impl.ImageLoaderTask;
	import com.br.as3ufw.asset.tasks.impl.XMLLoaderTask;
	import com.br.as3ufw.task.test.tasks.TestTask;

	import org.as3commons.logging.impl.DefaultLoggerFactory;

	import com.br.as3ufw.task.test.tasks.CancelableTestTask;
	import com.br.as3ufw.task.events.TaskEvent;
	import com.br.as3ufw.task.manager.ConcurrentTaskManager;
	import org.as3commons.logging.ILogger;

	import com.br.as3ufw.utils.ObjectUtils;
	import com.br.as3ufw.logging.SOSLoggerFactory;

	import org.as3commons.logging.LoggerFactory;

	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class BasicTest extends Sprite {
		
		private var _log : ILogger;
		
		private var assetSet:AssetSet;
		private var concurrentMgr:ConcurrentTaskManager;
		private var resultSet : Object;

		
		
		public function BasicTest() {
			
//			LoggerFactory.loggerFactory = new SOSLoggerFactory();
			LoggerFactory.loggerFactory = new DefaultLoggerFactory();
			_log = LoggerFactory.getClassLogger(BasicTest);
			
			_log.info("Basic Test starting...");
			
			assetSet = new AssetSet("main");
			resultSet = {};
			
			concurrentMgr = new ConcurrentTaskManager();
			
			concurrentMgr.addTask(new CancelableTestTask("Cancelable task 1"));
			concurrentMgr.addTask(new CancelableTestTask("Cancelable task 2"));
			concurrentMgr.addTask(new CancelableTestTask("Cancelable task 3"));
			concurrentMgr.addTask(new CancelableTestTask("Cancelable task 4"));
			concurrentMgr.addTask(new CancelableTestTask("Cancelable task 5",1000));
			
			concurrentMgr.addTask(new XMLLoaderTask("xml", new URLRequest("data/doc1.xml"),assetSet));
			//concurrentMgr.addTask(AssetTaskFactory.TaskByURLString("xml","data/doc1.xml"),assetSet);
			//AssetTaskFactory.TaskByURLString("xml","data/doc1.xml");
			
			
			concurrentMgr.addTask(new CSSLoaderTask("css", new URLRequest("data/sample.css"),assetSet));
			concurrentMgr.addTask(new ImageLoaderTask("image1", new URLRequest("data/P1000484.JPG"),assetSet));
			concurrentMgr.addTask(new ImageLoaderTask("image2", new URLRequest("data/P1000211.JPG"),assetSet));
			//concurrentMgr.addTask(new SWFLoaderTask("image", new URLRequest("http://www.nivea.co.uk/flash/main_navigation/main_navigation.swf")));
			
			concurrentMgr.addTask(new TestTask("Uncancelable task 6"));
			concurrentMgr.addEventListener(TaskEvent.COMPLETE, onComplete);
			
			_log.info("Basic Test isCancelable? : " + concurrentMgr.isCancelable);
			
			concurrentMgr.start(resultSet);
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
