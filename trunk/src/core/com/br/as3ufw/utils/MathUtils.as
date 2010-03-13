package com.br.as3ufw.utils {

	/**
	 * @author Richard.Jewson
	 */
	public class MathUtils {
		
		public static function degress2rad(degrees:Number):Number {
			return degrees * (Math.PI/180);
		}

		public static function rad2degrees(rad:Number):Number {
			return rad * (180/Math.PI);
		}
		
	}
}
