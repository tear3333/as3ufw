package as3ufw.asset.manager {
	import as3ufw.asset.tasks.impl.XMLLoaderTask;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.task.core.TaskManagerExecutor;
	import as3ufw.task.manager.ConcurrentTaskManager;

	/**
	 * @author Richard.Jewson
	 */
	public class XMLConfigurationLoader extends XMLLoaderTask {

		private var containerTask : ConcurrentTaskManager;

		public function XMLConfigurationLoader(id : String, url : *, assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, params);
			containerTask = new ConcurrentTaskManager();
		}

		override public function onComplete() : void {
			createLoaderTasks();
		}		

		/*	<assetConfig>
		 * 		<global>
		 * 			<replace token='...'>...value to replace with...</replace>
		 * 		</global>
		 * 		<group assetSet='...' id='...' prependID='true'>
		 *			<item id='...' type='' priority>...url...</item>
		 *			<group assetSet='...' id='...' prependID='true'>
		 *				...
		 *			</group>
		 *		</group>
		 *	</assetConfig>
		 */
		virtual public function createLoaderTasks() : * {
			
			var config : XML = content as XML;
			
			if (config == null) {
				_log.debug("The XML configuration file didnt load correctly");
				return;
			}
			
			for each (var group : XML in config.group) {
				containerTask.addTask(processGroup(group));
			}
			
			_exec.taskPipeline.newtasks.push(containerTask);
		}

		private function processGroup(group : XML) : TaskManagerExecutor {
			var groupLoaderMgr : AssetLoaderTaskManager = new AssetLoaderTaskManager();
			
			for each (var item : XML in group.item) {
				_log.info("Processing item:" + item.toXMLString());
				groupLoaderMgr.add(item.@id, item);
			}
			for each (var childgroup : XML in group.group) {
				_log.info("Processing Sub-group:" + childgroup.toXMLString());
				groupLoaderMgr.addTask(processGroup(childgroup));
			}			
			return groupLoaderMgr;
		}

		private static var _log : ILogger = Log.getClassLogger(XMLConfigurationLoader);
	}
}
