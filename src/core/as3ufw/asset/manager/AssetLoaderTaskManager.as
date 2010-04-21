package as3ufw.asset.manager {
	import as3ufw.asset.tasks.impl.VideoLoaderTask;
	import as3ufw.asset.tasks.impl.CSSLoaderTask;
	import as3ufw.asset.tasks.impl.SWFLoaderTask;
	import as3ufw.asset.tasks.impl.XMLLoaderTask;
	import as3ufw.asset.IAssetLoader;
	import as3ufw.asset.tasks.impl.ImageLoaderTask;
	import as3ufw.task.manager.ConcurrentTaskManager;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetLoaderTaskManager extends ConcurrentTaskManager {

		public static var mapping : Object = {
			jpg 	: ImageLoaderTask,
			jpeg	: ImageLoaderTask,
			png		: ImageLoaderTask,

			flv		: VideoLoaderTask,
			f4v		: VideoLoaderTask,

			swf		: SWFLoaderTask,
			
			css		: CSSLoaderTask,
			
			xml 	: XMLLoaderTask
		};

		public function AssetLoaderTaskManager(concurrency : int = 10) {
			super(concurrency);
		}

		/*
		 * @param id:String 
		 * @param url:* 
		 * @param id:String 
		 */
		public function add(id : String,url : *,assetSet : AssetSet = null, params : Object = null) : IAssetLoader {
			var loader : IAssetLoader;
			var extension : String;
			
			extension = 'jpg';
			
			loader = new mapping[extension.toLowerCase()](id,url,assetSet,params) as IAssetLoader;
			
			return loader;
		}
	}
}
