package as3ufw.physics.forces {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class InitialPositionAttractor extends AbstractForce implements IForceGenerator {
		private var force : Function;
		private var position : Vector2D;
		private var strength : Number;
		private var range : Number;
		private var rangeSqr : Number;
		private var threshold : Number;

		public function InitialPositionAttractor(force : Function, strength : Number, range : Number = -1, threshold : Number = 5) {
			this.force = force;
			this.strength = strength;
			this.range = range;
			this.rangeSqr = range*range;
			this.threshold = threshold;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var difference : Vector2D = new Vector2D(targetParticle.initPos.x - targetParticle.pos.x, targetParticle.initPos.y - targetParticle.pos.y);
			// position.minus(targetParticle.pos);
			var distanceSqr:Number = difference.x * difference.x + difference.y * difference.y;
			if (distanceSqr==0) return;
			if (distanceSqr<threshold) return;
			if ((range>=0)&&(distanceSqr > rangeSqr)) return;
			targetParticle.addForce(force(difference, strength));
		}
	}
}
