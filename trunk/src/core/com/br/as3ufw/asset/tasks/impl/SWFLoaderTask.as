package com.br.as3ufw.asset.tasks.impl {
	import com.br.as3ufw.asset.enum.LoaderTypes;
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.asset.tasks.LoaderTask;
	import com.br.as3ufw.utils.ObjectUtils;

	/**
	 * @author Richard.Jewson
	 */
	public class SWFLoaderTask extends LoaderTask {
		public function SWFLoaderTask(id : String, url : *,assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, ObjectUtils.merge(params, {type:LoaderTypes.BINARY}));
		}
	}
}