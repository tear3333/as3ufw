package as3ufw.physics.constraints {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class Spring implements IConstraint {

		internal var p1 : Particle;
		internal var p2 : Particle;
		public var stiffness : Number;
		protected var restLength : Number;

		public function Spring(p1 : Particle,p2 : Particle,stiffness : Number = 0.5) {
			this.p1 = p1;
			this.p2 = p2;
			this.stiffness = stiffness;
			restLength = length;
		}

		public function resolve(iterationPercent:Number) : Boolean {
            
            if ((!p1 || !p1.active || !p2 || !p2.active) ) return false;
            
			//var deltaLength : Number = length + 0.00001;                    
            var dX:Number = p1.pos.x - p2.pos.x;
            var dY:Number = p1.pos.y - p2.pos.y;
			var deltaLength : Number = Math.sqrt(dX * dX + dY * dY) + 0.00001;

			var diff : Number = (deltaLength - restLength) / (deltaLength * (p1.invMass + p2.invMass));
			//var delta : Vector2D = p1.pos.minus(p2.pos);
			//var dmds : Vector2D = delta.mult(diff * stiffness);
			var factor:Number = diff * stiffness;
			//dX,dY is now dmds
			dX *= factor;
			dY *= factor;
                
			//if (!p1.fixed) p1.pos.minusEquals(dmds.mult(p1.invMass));
			if (!p1.fixed) {
				p1.pos.x -= dX * p1.invMass;
				p1.pos.y -= dY * p1.invMass;
			}
			//if (!p2.fixed) p2.pos.plusEquals(dmds.mult(p2.invMass));
			if (!p2.fixed) {
				p2.pos.x += dX * p2.invMass;
				p2.pos.y += dY * p2.invMass;				
			}
			return true;
		}      

		public function get length() : Number {
			return p1.pos.distance(p2.pos);
		}

		public function set length(len : Number) : void {
			restLength = len;
		}

		public function render(g : Graphics, colour : uint = 0x000000) : void {
			g.lineStyle(1, colour);
			g.moveTo(p1.pos.x, p1.pos.y);
			g.lineTo(p2.pos.x,p2.pos.y);
		}
		
	}
}
