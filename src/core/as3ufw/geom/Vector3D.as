package as3ufw.geom {

	/**
	 * @author Richard.Jewson
	 */
	public class Vector3D {
		public var x : Number;
		public var y : Number;
		public var z : Number;

		public function Vector3D(x : Number,y : Number,z : Number) {
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public function clone() : Vector3D {
			return new Vector3D(this.x, this.y, this.z);
		}

		public function setTo(x : Number, y : Number,z : Number) : void {
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public function copy(v : Vector3D) : void {
			x = v.x;
			y = v.y;
			z = v.z;
		}

		public function plus(v : Vector3D) : Vector3D {
			return new Vector3D(x + v.x, y + v.y, z + v.z);    
		}

		public function plusEquals(v : Vector3D) : Vector3D {
			x += v.x;
			y += v.y;
			z += v.z;
			return this;
		}

		public function minus(v : Vector3D) : Vector3D {
			return new Vector3D(x - v.x, y - v.y, z - v.z);    
		}

		public function minusEquals(v : Vector3D) : Vector3D {
			x -= v.x;
			y -= v.y;
			z -= v.z;
			return this;
		}

		public function mult(s : Number) : Vector3D {
			return new Vector3D(x * s, y * s, z * s);
		}

		public function multEquals(s : Number) : Vector3D {
			x *= s;
			y *= s;
			z *= s;
			return this;
		}

		public function times(v : Vector3D) : Vector3D {
			return new Vector3D(x * v.x, y * v.y, z * v.z);
		}

		public function timesEquals(v : Vector3D) : Vector3D {
			x *= v.x;
			y *= v.y;
			z *= v.z;
			return this;
		}

		public function get magnitude() : Number {
			return Math.sqrt(x * x + y * y + z * z);
		}

		public function get magnitudeSqr() : Number {
			return (x * x + y * y + z * z);
		}

		public function distance(v : Vector3D) : Number {
			var delta : Vector3D = this.minus(v);
			return delta.magnitude;
		}

		public function distanceSqr(v : Vector3D) : Number {
			var delta : Vector3D = this.minus(v);
			return delta.magnitudeSqr;
		}

		public function normalize() : Vector3D {
			var m : Number = magnitude;
			if (m == 0) m = 0.0001;
			return mult(1 / m);
		}

		public function dot(v : Vector3D) : Number {
			return x * v.x + y * v.y + z * v.z;
		}

		public function cross(v : Vector3D) : Vector3D {
			return new Vector3D((y * v.z) - (v.y * z), (z * v.x) - (v.z * x), (x * v.y) - (v.x * y));
		}

		public function toString() : String {
			return (x + ":" + y + ":" + z);
		}
	}
}
