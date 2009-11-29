package com.br.as3ufw.asset.manager {
	import flash.utils.Dictionary;
	/**
	 * @author Richard.Jewson
	 */
	public class AssetSet {

		private var _id : String;
		private var _set : Dictionary;

		public function AssetSet(id:String) {
			this._id = id;
			_set = new Dictionary();
		}

		public function get id() : String {
			return _id;
		}
		
		public function addAsset(key:String,value:*):void {
			_set[key] = value;
		}
		
		public function getAsset(key:String):* {
			return _set[key];
		}
		
		public function toString():String {
			var str:String = "AssetSet:" + _id + "\n";
			for (var itemKey:* in _set) {
				str += "["+itemKey+"]=" + _set[itemKey] + "\n";
			}
			return str;
		}
	}
}
