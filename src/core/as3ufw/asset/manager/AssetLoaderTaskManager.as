package as3ufw.asset.manager {
	import as3ufw.asset.IAssetLoader;
	import as3ufw.asset.tasks.impl.CSSLoaderTask;
	import as3ufw.asset.tasks.impl.ImageLoaderTask;
	import as3ufw.asset.tasks.impl.SWFLoaderTask;
	import as3ufw.asset.tasks.impl.TextLoaderTask;
	import as3ufw.asset.tasks.impl.VideoLoaderTask;
	import as3ufw.asset.tasks.impl.XMLLoaderTask;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.task.manager.ConcurrentTaskManager;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetLoaderTaskManager extends ConcurrentTaskManager {

		public static var mapping : Object = {
			image	: ImageLoaderTask, 
			jpg 	: ImageLoaderTask, 
			jpeg	: ImageLoaderTask, 
			png		: ImageLoaderTask, 
			video	: VideoLoaderTask, 
			flv		: VideoLoaderTask, 
			f4v		: VideoLoaderTask, 
			f4p		: VideoLoaderTask, 
			swf		: SWFLoaderTask, 
			css		: CSSLoaderTask, 
			xml 	: XMLLoaderTask, 
			text	: TextLoaderTask
		};

		public function AssetLoaderTaskManager(concurrency : int = 10) {
			super(concurrency);
		}

		/*
		 * @param id:String 
		 * @param url:* 
		 * @param id:String 
		 */
		public function add(id : String,url : String,assetSet : AssetSet = null, params : Object = null) : IAssetLoader {
			var type : String = ( params && params.hasOwnProperty('type') ) ? params['type'] : extractExtension(url) ;
			if (type == null) {
				_log.fatal('Cannot determine asset type to add: id=' + id);
				return null;
			}
			var loaderClazz : Class = mapping[type.toLowerCase()];
			if (loaderClazz == null) {
				_log.fatal('Cannot determine loader class for type=' + loaderClazz);
				return null;
			}
			var loader:IAssetLoader = new loaderClazz(id, url, assetSet, params) as IAssetLoader;
			addTask(loader);
			
			return loader;
		}

		override public function onComplete() : void {
			super.onComplete();
			
			destroy();
		}

		//onc

		private function extractExtension(url : String) : String {
			var searchString : String = url.indexOf("?") > -1 ? url.substring(0, url.indexOf("?")) : url;
			var finalPart : String = searchString.substring(searchString.lastIndexOf("/"));;
			return finalPart.substring(finalPart.lastIndexOf(".") + 1).toLowerCase();
		}

		public static function registerType(type:String,clazz:Class):void {
			mapping[type] = clazz;
		}
		
		public static function unregisterType(type:String):void {
			mapping[type] = null;
			delete mapping[type];
		}

		private static var _log : ILogger = Log.getClassLogger(AssetLoaderTaskManager);
	}
}
