package com.br.as3ufw.asset.manager {
	import com.br.as3ufw.task.manager.ConcurrentTaskManager;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetLoaderTaskManager extends ConcurrentTaskManager {
		public function AssetLoaderTaskManager(concurrency : int = 10) {
			super(concurrency);
		}
	}
}
