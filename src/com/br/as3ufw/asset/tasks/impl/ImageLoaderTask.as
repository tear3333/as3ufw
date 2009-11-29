package com.br.as3ufw.asset.tasks.impl {
	import com.br.as3ufw.asset.enum.LoaderTypes;
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.asset.tasks.LoaderTask;

	import flash.display.Bitmap;

	/**
	 * @author Richard.Jewson
	 */
	public class ImageLoaderTask extends LoaderTask {
		public function ImageLoaderTask(id : String, url : *,assetSet : AssetSet = null, params : Object = null) {
			super(id, url, assetSet, mergeParams(params, {type:LoaderTypes.BINARY}));
		}

		override public function get content() : * {
			return Bitmap(super.content).bitmapData;
		}
	}
}
