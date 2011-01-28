package as3ufw.utils {
	/**
	 * @author Richard.Jewson
	 */
	public class DisplayUtils {
		public static function lighten(colour : uint, ratio : Number) : uint {
			var rgb : Object = getARGB(colour);
			return getHex(rgb.r + (255 - rgb.r) * ratio, rgb.g + (255 - rgb.g) * ratio, rgb.b + (255 - rgb.b) * ratio);
		}

		public static function darken(color : uint, ratio : Number) : uint {
			var rgb : Object = getARGB(color);
			return (getHex(rgb.r * (1 - ratio), rgb.g * (1 - ratio), rgb.b * (1 - ratio)));
		}

		public static function scaleColour(color : uint, percent : Number) : uint {
			var rgb : Object = getARGB(color);
			return (getHex(rgb.r * percent, rgb.g * percent, rgb.b * percent));
		}

		public static function getHex(r : uint, g : uint, b : uint, a : uint = 255) : uint {
			return (a << 24) | (r << 16) | (g << 8) | b;
		}
		
		public static function getARGB(color : uint) : Object {
			var c : Object = {};
			c.a = color >> 24 & 0xFF;
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}

		public static function getAlpha(colour : uint) : Number {
			return ( ( colour & 0xFF000000 ) >>> 24 ) / 255;
		}

		public static function interpolateColors(fromColour : uint, toColour : uint, ratio : Number) : uint {
			var inv : Number = 1 - ratio;
			var red : uint = Math.round(( ( fromColour >>> 16 ) & 255 ) * ratio + ( ( toColour >>> 16 ) & 255 ) * inv);
			var green : uint = Math.round(( ( fromColour >>> 8 ) & 255 ) * ratio + ( ( toColour >>> 8 ) & 255 ) * inv);
			var blue : uint = Math.round(( ( fromColour ) & 255 ) * ratio + ( ( toColour ) & 255 ) * inv);
			var alpha : uint = Math.round(( ( fromColour >>> 24 ) & 255 ) * ratio + ( ( toColour >>> 24 ) & 255 ) * inv);
			return ( alpha << 24 ) | ( red << 16 ) | ( green << 8 ) | blue;
		}
	}
}
