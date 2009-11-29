package com.br.as3ufw.asset.tasks.impl {
	import com.br.as3ufw.asset.enum.LoaderTypes;
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.asset.tasks.URLLoaderTask;

	/**
	 * @author Richard.Jewson
	 */
	public class XMLLoaderTask extends URLLoaderTask {
		public function XMLLoaderTask(id : String, url : *, assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, mergeParams(params, {type:LoaderTypes.TEXT}));
		}

		override public function get content() : * {
			return new XML(super.content);
		}

		public function toString() : String {
			return "ID=[" + id + "]";
		}
	}
}
