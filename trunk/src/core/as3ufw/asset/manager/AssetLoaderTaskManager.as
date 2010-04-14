package as3ufw.asset.manager {
	import as3ufw.task.manager.ConcurrentTaskManager;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetLoaderTaskManager extends ConcurrentTaskManager {
		public function AssetLoaderTaskManager(concurrency : int = 10) {
			super(concurrency);
		}

		public function addAsset() : void {
		}
	}
}
