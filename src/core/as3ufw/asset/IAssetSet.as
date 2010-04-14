package com.br.as3ufw.asset {
	import flash.text.StyleSheet;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author Richard.Jewson
	 */
	public interface IAssetSet {
		function keyExists(key : String) : Boolean;

		function getObject(key : String) : *;

		function getArray(key : String) : Array;

		function getString(key : String) : String;

		function getBool(key : String) : Boolean;

		function getInt(key : String) : int;

		function getFloat(key : String) : Number;

		function getBitmapData(key : String) : BitmapData;

		function getBitmap(key : String) : Bitmap;
		
		function getXML(key : String) : XML;		

		function getSWF(key : String) : MovieClip;
		
		function getCSS(key : String) : StyleSheet;
			
	}
}
