package com.br.as3ufw.utils {

	/**
	 * @author Richard.Jewson
	 */
	public class DisplayUtils {

		public static function getAlpha( colour : uint ) : Number {
			return ( ( colour & 0xFF000000 ) >>> 24 ) / 255;
		}

		public function interpolateColors( fromColour : uint, toColour : uint, ratio : Number ) : uint {
			var inv : Number = 1 - ratio;
			var red : uint 		= Math.round(( ( fromColour >>> 16 ) & 255 ) * ratio + ( ( toColour >>> 16 ) & 255 ) * inv);
			var green : uint 	= Math.round(( ( fromColour >>> 8 ) & 255 ) * ratio + ( ( toColour >>> 8 ) & 255 ) * inv);
			var blue : uint 	= Math.round(( ( fromColour ) & 255 ) * ratio + ( ( toColour ) & 255 ) * inv);
			var alpha : uint 	= Math.round(( ( fromColour >>> 24 ) & 255 ) * ratio + ( ( toColour >>> 24 ) & 255 ) * inv);
			return ( alpha << 24 ) | ( red << 16 ) | ( green << 8 ) | blue;
		}
	}
}
