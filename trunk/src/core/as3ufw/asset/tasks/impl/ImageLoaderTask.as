package as3ufw.asset.tasks.impl {
	import as3ufw.asset.enum.LoaderTypes;
	import as3ufw.asset.manager.AssetSet;
	import as3ufw.asset.tasks.LoaderTask;
	import as3ufw.utils.ObjectUtils;

	import flash.display.Bitmap;

	/**
	 * @author Richard.Jewson
	 */
	public class ImageLoaderTask extends LoaderTask {
		public function ImageLoaderTask(id : String, url : *,assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, ObjectUtils.merge(params, {type:LoaderTypes.BINARY}));
		}

		override public function get content() : * {
			return Bitmap(super.content).bitmapData;
		}
	}
}
