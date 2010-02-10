package com.br.as3ufw.asset.tasks {
	import com.br.as3ufw.asset.tasks.impl.XMLLoaderTask;
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.task.ITaskRunnable;

	import flash.net.URLRequest;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetTaskFactory {

		private static var _loaders:Array;
		
		{
			_loaders = [];
			_loaders.push
		}

		public static function TaskByURLString(id : String, urlString : String,assetSet : AssetSet = null, params:Object = null) : ITaskRunnable {
			var url:URLRequest = new URLRequest(urlString);
			trace(urlString.search(/xml/));
			switch (true) {
				case urlString.search(/xml/): return new XMLLoaderTask(id,url,assetSet,params);
					break;
			}
			return null;
		}
	}
}
