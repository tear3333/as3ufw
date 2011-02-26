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

		override public function applyForce(targetParticles : Particle) : void {
			if (!active) return;
			var particle : Particle = targetParticles;
			while (particle) {
				var difference : Vector2D = new Vector2D(particle.initPos.x - particle.pos.x, particle.initPos.y - particle.pos.y);
				// position.minus(targetParticle.pos);
				var distanceSqr:Number = difference.x * difference.x + difference.y * difference.y;
				if (!( (distanceSqr==0) && (distanceSqr<threshold) && ((range>=0)&&(distanceSqr > rangeSqr)) ) ) {
					particle.addForce(force(difference, strength));
				}
				particle = particle.next;
			}
		}
	}
}
