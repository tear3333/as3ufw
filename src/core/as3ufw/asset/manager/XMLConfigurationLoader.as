package as3ufw.asset.manager {
	import as3ufw.asset.tasks.impl.XMLLoaderTask;
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
			
			for each (var group : XML in config.group) {
				trace(group.toXMLString());
			}
			
			_exec.taskPipeline.newtasks.push(containerTask);
		}

		private function processGroup(group : XML, taskManager : TaskManagerExecutor ) : void {
		}
	}
}
