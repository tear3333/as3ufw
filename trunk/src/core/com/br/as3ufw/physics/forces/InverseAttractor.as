package com.br.as3ufw.physics.forces {
	import com.br.as3ufw.geom.Vector2D;
	import com.br.as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class InverseAttractor extends AbstractForce implements IForceGenerator {
		private var forcePosition : Vector2D;
		private var multiplier : Number;

		public function InverseAttractor(forcePosition : Vector2D,multiplier : Number) {
			this.multiplier = multiplier;
			this.forcePosition = forcePosition;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var forceVector : Vector2D = forcePosition.minus(targetParticle.pos);
			var len : Number = forceVector.magnitude;
			forceVector.multEquals(multiplier * (1 / len));
			targetParticle.addForce(forceVector);
		}
	}
}
