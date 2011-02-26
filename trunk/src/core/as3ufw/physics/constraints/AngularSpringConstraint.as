package as3ufw.physics.constraints {
	import as3ufw.physics.Particle;
	/**
	 * @author richard.jewson
	 */
	public class AngularSpringConstraint extends Spring {
		
		public static var PI2 : Number = Math.PI * 2;
		
		internal var angleParticle : Particle;
		private var minAng : Number;
		private var maxAng : Number;
		private var deltaFactorMultiplier : Number;

		public function AngularSpringConstraint(affectedParticle : Particle, centerRotationParticle : Particle, angleParticle : Particle, minAng : Number, maxAng : Number, stiffness : Number, deltaFactorMultiplier : Number = -1) {
			super(affectedParticle, centerRotationParticle, stiffness);
			this.angleParticle = angleParticle;
			this.deltaFactorMultiplier = deltaFactorMultiplier;

			if (minAng == 10) {
				this.minAng = acRadian;
				this.maxAng = acRadian;
			} else {
				this.minAng = minAng;
				this.maxAng = maxAng;
			}
			
		}

		public function get acRadian() : Number {
			var ang12 : Number = Math.atan2(p2.pos.y - p1.pos.y, p2.pos.x - p1.pos.x);
			var ang23 : Number = Math.atan2(angleParticle.pos.y - p2.pos.y, angleParticle.pos.x - p2.pos.x);

			var angDiff : Number = ang12 - ang23;
			return angDiff;
		}

		override public function resolve(iterationPercent:Number) : Boolean {
			
			var ang12 : Number = Math.atan2(p2.pos.y - p1.pos.y, p2.pos.x - p1.pos.x);
			var ang23 : Number = Math.atan2(angleParticle.pos.y - p2.pos.y, angleParticle.pos.x - p2.pos.x);

			var angDiff : Number = ang12 - ang23;
			while (angDiff > Math.PI) angDiff -= PI2;
			while (angDiff < -Math.PI) angDiff += PI2;
			
			var delta:Number = 1;
			if (deltaFactorMultiplier!=-1) {
				delta = (angDiff<0) ? -angDiff : angDiff;
				delta -= Math.PI;
				delta = (delta<0) ?  -delta * deltaFactorMultiplier : delta * deltaFactorMultiplier;
			 	//Math.abs((Math.abs(angDiff)-Math.PI))*10;
			}
			//trace( Math.abs((Math.abs(angDiff)-Math.PI))*100 );
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

			var sumInvMass:Number = p1.invMass + p2.invMass;
			var mult1:Number = p1.invMass / sumInvMass;
			var mult2:Number = p2.invMass / sumInvMass;

			var finalAng : Number = angChange * (this.stiffness*delta) + ang12;
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
