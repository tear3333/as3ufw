package com.br.as3ufw.asset.tasks.impl {
	import com.br.as3ufw.asset.enum.LoaderTypes;
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.asset.tasks.URLLoaderTask;
	import com.br.as3ufw.utils.ObjectUtils;

	/**
	 * @author Richard.Jewson
	 */
	public class XMLLoaderTask extends URLLoaderTask {
		public function XMLLoaderTask(id : String, url : *, assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, ObjectUtils.merge(params, {type:LoaderTypes.TEXT}));
		}

		public function toString() : String {
			return "ID=[" + id + "]";
		}
	}
}
