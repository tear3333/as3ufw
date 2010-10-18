package as3ufw.physics.forces {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class InverseAttractor2 extends AbstractForce implements IForceGenerator {
		private var forcePosition : Vector2D;
		public var multiplier : Number;

		public function InverseAttractor2(forcePosition : Vector2D,multiplier : Number) {
			this.multiplier = multiplier;
			this.forcePosition = forcePosition;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var forceVector : Vector2D = forcePosition.minus(targetParticle.pos);
			var len : Number = forceVector.magnitude;
			forceVector.multEquals(multiplier * len);
			targetParticle.addForce(forceVector);
		}
	}
}
