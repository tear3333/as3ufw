package com.br.as3ufw.physics.forces {
	import com.br.as3ufw.geom.Vector2D;
	import com.br.as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class RelativeAttractor extends AbstractForce implements IForceGenerator {

		private var forcePosition : Vector2D;
		private var strength : Number;
		private var range : Number;

		public function RelativeAttractor(forcePosition : Vector2D,strength : Number, range:Number) {
			this.strength = strength;
			this.forcePosition = forcePosition;
			this.range = range;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var forceVector : Vector2D = forcePosition.minus(targetParticle.pos);
			var distance:Number = forceVector.magnitude;
			if (distance>range) return;
			//trace(strength/distance);
			forceVector.multEquals(strength/distance);
			targetParticle.addForce(forceVector);
		}
	}
}
