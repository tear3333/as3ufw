package com.br.as3ufw.physics.forces {
	import com.br.as3ufw.geom.Vector2D;
	import com.br.as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class InitialPositionAttractor extends AbstractForce implements IForceGenerator {
		private var strength : Number;

		public function InitialPositionAttractor(strength : Number) {
			this.strength = strength;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var forceVector : Vector2D = targetParticle.initPos.minus(targetParticle.pos);
			forceVector.normalize();
			forceVector.multEquals(strength);
			targetParticle.addForce(forceVector);
		}
	}
}
