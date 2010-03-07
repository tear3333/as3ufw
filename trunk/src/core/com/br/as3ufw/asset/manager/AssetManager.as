package com.br.as3ufw.asset.manager {
	//import org.as3commons.logging.ILogger;
	//import org.as3commons.logging.LoggerFactory;

	import flash.utils.Dictionary;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetManager {
		private static var assetSets : Dictionary = new Dictionary();

		public static function AssetSetFactory(id : String) : AssetSet {
			var assetSet : AssetSet = new AssetSet(id);
			addAssetSet(assetSet);
			return assetSet;
		}

		public static function getAssetSet(assetSetKey : String) : AssetSet {
			return assetSets[assetSetKey];
		}

		public static function addAssetSet(assetSet : AssetSet) : void {
			assetSets[assetSet.id] = assetSet;
		}

		
		public static function mergeSets(mergeIntoKey : String,mergeContentsKey : String) : void {
			var mergeIntoSet : Dictionary = assetSets[mergeIntoKey];
			var mergeContentSet : Dictionary = assetSets[mergeContentsKey];
			for (var itemKey:* in mergeContentSet) {
				var itemValue : * = mergeContentSet[itemKey];
				mergeIntoSet[itemKey] = itemValue;
			}
		}

		//private static var _log : ILogger = LoggerFactory.getClassLogger(AssetManager);
	}
}




