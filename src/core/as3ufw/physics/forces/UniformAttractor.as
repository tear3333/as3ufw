package as3ufw.physics.forces {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class UniformAttractor extends AbstractForce implements IForceGenerator {

		private var forcePosition : Vector2D;
		private var strength : Number;

		public function UniformAttractor(forcePosition : Vector2D,strength : Number) {
			this.strength = strength;
			this.forcePosition = forcePosition;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var forceVector : Vector2D = forcePosition.minus(targetParticle.pos);
			forceVector.normalize();
			forceVector.multEquals(strength);
			targetParticle.addForce(forceVector);
		}
	}
}
