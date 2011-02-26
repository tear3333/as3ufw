package as3ufw.physics.forces {
	import as3ufw.utils.Random;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class RandomForce extends AbstractForce implements IForceGenerator {
		private var strength : Number;

		public function RandomForce(strength : Number) {
			this.strength = strength;
		}

		override public function applyForce(targetParticles : Particle) : void {
			if (!active) return;
			var particle : Particle = targetParticles;
			while (particle) {
				particle.addForce(new Vector2D(Random.float(-1*strength, 1*strength),Random.float(-1*strength, 1*strength)));
				particle = particle.next;
			}
		}
	}
}
