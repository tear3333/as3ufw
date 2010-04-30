package as3ufw.asset.manager {
	import as3ufw.asset.tasks.impl.XMLLoaderTask;
	import as3ufw.task.manager.ConcurrentTaskManager;

	/**
	 * @author Richard.Jewson
	 */
	public class XMLConfigurationLoader extends XMLLoaderTask {
		public function XMLConfigurationLoader(id : String, url : *, assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, params);
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
			var containerTask : ConcurrentTaskManager = new ConcurrentTaskManager();
			
			var config:XML = content as XML;
			
			trace(config.toXMLString());
			
			_exec.taskPipeline.newtasks.push(containerTask);
		}
	}
}
