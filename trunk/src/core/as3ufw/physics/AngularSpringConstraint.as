package as3ufw.physics {
	/**
	 * @author richard.jewson
	 */
	public class AngularSpringConstraint extends Spring {
		internal var angleParticle : Particle;
		private var minAng : Number;
		private var maxAng : Number;

		private var p1invMass : Number;
		private var p2invMass : Number;
		private var sumInvMass : Number;
		private var mult1 : Number;
		private var mult2 : Number;

		public function AngularSpringConstraint(affectedParticle : Particle, centerRotationParticle : Particle, angleParticle : Particle, minAng : Number, maxAng : Number, stiffness : Number = 0.5) {
			super(affectedParticle, centerRotationParticle, stiffness);
			this.angleParticle = angleParticle;

			if (minAng == 10) {
				this.minAng = acRadian;
				this.maxAng = acRadian;
				trace(this.minAng);
			} else {
				this.minAng = minAng;
				this.maxAng = maxAng;
			}
			
			p1invMass = p1.invMass;
			p2invMass = p2.invMass;
			sumInvMass = p1invMass + p2invMass;
			mult1 = p1invMass / sumInvMass;
			mult2 = p2invMass / sumInvMass;
			
		}

		public function get acRadian() : Number {
			var ang12 : Number = Math.atan2(p2.pos.y - p1.pos.y, p2.pos.x - p1.pos.x);
			var ang23 : Number = Math.atan2(angleParticle.pos.y - p2.pos.y, angleParticle.pos.x - p2.pos.x);

			var angDiff : Number = ang12 - ang23;
			return angDiff;
		}

		override public function resolve() : Boolean {
			var PI2 : Number = Math.PI * 2;

			var ang12 : Number = Math.atan2(p2.pos.y - p1.pos.y, p2.pos.x - p1.pos.x);
			var ang23 : Number = Math.atan2(angleParticle.pos.y - p2.pos.y, angleParticle.pos.x - p2.pos.x);

			var angDiff : Number = ang12 - ang23;
			while (angDiff > Math.PI) angDiff -= PI2;
			while (angDiff < -Math.PI) angDiff += PI2;
			
			var angChange : Number = 0;

			var lowMid : Number = (maxAng - minAng) / 2;
			var highMid : Number = (maxAng + minAng) / 2;
			//var breakAng : Number = (maxBreakAng - minBreakAng) / 2;

			var newDiff : Number = highMid - angDiff;
			while (newDiff > Math.PI) newDiff -= PI2;
			while (newDiff < -Math.PI) newDiff += PI2;

			if (newDiff > lowMid) {
				angChange = newDiff - lowMid;
			} else if (newDiff < -lowMid) {
				angChange = newDiff + lowMid;
			}

			var finalAng : Number = angChange * this.stiffness + ang12;
			var displaceX : Number = p1.pos.x + (p2.pos.x - p1.pos.x) * mult1;
			var displaceY : Number = p1.pos.y + (p2.pos.y - p1.pos.y) * mult1;

			p1.pos.x = displaceX + Math.cos(finalAng + Math.PI) * restLength * mult1;
			p1.pos.y = displaceY + Math.sin(finalAng + Math.PI) * restLength * mult1;
			//p2.pos.x = displaceX + Math.cos(finalAng) * restLength * mult2;
			//p2.pos.y = displaceY + Math.sin(finalAng) * restLength * mult2;
			
			return true;
		}
	}
}
