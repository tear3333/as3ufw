package com.br.as3ufw.asset.manager {
	import flash.text.StyleSheet;
	import flash.display.MovieClip;

	import com.br.as3ufw.asset.IAssetSet;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	/**
	 * @author Richard.Jewson
	 */
	public class AssetSet implements IAssetSet {

		private var _id : String;
		private var _set : Dictionary;

		public function AssetSet(id : String) {
			this._id = id;
			_set = new Dictionary();
		}

		public function get id() : String {
			return _id;
		}

		public function addAsset(key : String,value : *) : void {
			_set[key] = value;
		}

		public function getAsset(key : String) : * {
			return _set[key];
		}

		public function keyExists(key : String) : Boolean {
			return getAsset(key) as Boolean;
		}

		public function getObject(key : String) : * {
			return getAsset(key) as Boolean;
		}

		public function getArray(key : String) : Array {
			return getAsset(key) as Array;
		}

		public function getString(key : String) : String {
			return getAsset(key) as String;
		}

		public function getBool(key : String) : Boolean {
			return getAsset(key) as Boolean;
		}

		public function getInt(key : String) : int {
			return getAsset(key) as int;
		}

		public function getFloat(key : String) : Number {
			return getAsset(key) as Number;
		}

		public function getBitmapData(key : String) : BitmapData {
			return getAsset(key) as BitmapData;
		}

		public function getBitmap(key : String) : Bitmap {
			return getAsset(key) as Bitmap;
		}

		public function getXML(key : String) : XML {
			return getAsset(key) as XML;
		}
		
		public function getSWF(key : String) : MovieClip{
			return getAsset(key) as MovieClip;
		}
		
		public function getCSS(key : String) : StyleSheet{
			return getAsset(key) as StyleSheet;
		}
		
		public function toString() : String {
			var str : String = "AssetSet:" + _id + "\n";
			for (var itemKey:* in _set) {
				str += "[" + itemKey + "]=" + _set[itemKey] + "\n";
			}
			return str;
		}
	}
}
