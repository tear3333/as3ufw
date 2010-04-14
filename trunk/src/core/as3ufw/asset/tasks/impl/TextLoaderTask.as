package as3ufw.asset.tasks.impl {
	import as3ufw.asset.enum.LoaderTypes;
	import as3ufw.asset.manager.AssetSet;
	import as3ufw.asset.tasks.URLLoaderTask;
	import as3ufw.utils.ObjectUtils;

	/**
	 * @author Richard.Jewson
	 */
	public class TextLoaderTask extends URLLoaderTask {
		public function TextLoaderTask(id : String, url : *,assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, ObjectUtils.merge(params, {type:LoaderTypes.TEXT}));
		}
	}
}
