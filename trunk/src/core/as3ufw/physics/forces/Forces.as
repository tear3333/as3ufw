package as3ufw.physics.forces {
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class Forces {
		
		public static function Uniform(diff : Vector2D, strength : Number) : Vector2D {
			return diff.normalize().multEquals(strength);
		}

		public static function Relative(diff : Vector2D, strength : Number) : Vector2D {
			return diff.multEquals(strength/diff.magnitude);
		}

		public static function Inverse(diff : Vector2D, strength : Number) : Vector2D {
			return diff.multEquals(strength * (1 / diff.magnitude));
		}
		
		public static function Inverse2(diff : Vector2D, strength : Number) : Vector2D {
			return diff.multEquals(strength * diff.magnitude);
		}			
		
		
	}
}
