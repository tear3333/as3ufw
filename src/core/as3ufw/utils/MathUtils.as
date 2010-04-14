package com.br.as3ufw.utils {

	/**
	 * @author Richard.Jewson
	 */
	public class MathUtils {
		
		private static const RADTODEG:Number = 180 / Math.PI;
        private static const DEGTORAD:Number = Math.PI / 180;
		
		
		public static function degress2rad(degrees:Number):Number {
			return degrees * DEGTORAD;
		}

		public static function rad2degrees(rad:Number):Number {
			return rad * RADTODEG;
		}
		
	}
}
