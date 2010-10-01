package as3ufw.physics {
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class Spring {

		private var p1 : Particle;
		private var p2 : Particle;
		private var stiffness : Number;
		private var _restLength : Number;

		public function Spring(p1 : Particle,p2 : Particle,stiffness : Number = 0.5) {
			this.stiffness = stiffness;
			this.p2 = p2;
			this.p1 = p1;
			_restLength = length;
		}

		public function resolve() : Boolean {
            
            if ((!p1 || !p1.active || !p2 || !p2.active) ) return false;
            
			var deltaLength : Number = length + 0.00001;                    
			var diff : Number = (deltaLength - _restLength) / (deltaLength * (p1.invMass + p2.invMass));
			var delta : Vector2D = p1.pos.minus(p2.pos);
			var dmds : Vector2D = delta.mult(diff * stiffness);
                
			if (!p1.fixed) p1.pos.minusEquals(dmds.mult(p1.invMass));
			if (!p2.fixed) p2.pos.plusEquals(dmds.mult(p2.invMass));
			
			return true;
		}      

		public function get length() : Number {
			return p1.pos.distance(p2.pos);
		}

		public function set length(len : Number) : void {
			_restLength = len;
		}
	}
}
