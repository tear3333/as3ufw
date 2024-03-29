package as3ufw.asset.tasks.impl {
	import as3ufw.utils.ObjectUtils;
	import as3ufw.asset.enum.LoaderTypes;
	import as3ufw.asset.manager.AssetSet;
	import as3ufw.asset.tasks.URLLoaderTask;

	import flash.text.StyleSheet;

	/**
	 * @author Richard.Jewson
	 */
	public class CSSLoaderTask extends URLLoaderTask {
		public function CSSLoaderTask(id : String, url : *,assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, ObjectUtils.merge(params, {type:LoaderTypes.TEXT}));
		}

		override public function get content() : * {
			var sheet : StyleSheet = new StyleSheet();
			sheet.parseCSS(super.content);
			return sheet;
		}
	}
}
