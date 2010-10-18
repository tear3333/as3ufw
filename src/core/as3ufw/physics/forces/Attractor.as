package as3ufw.physics.forces {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class Attractor extends AbstractForce implements IForceGenerator {
		private var force : Function;
		private var position : Vector2D;
		private var strength : Number;
		private var range : Number;
		private var rangeSqr : Number;

		public function Attractor(force : Function, position : Vector2D, strength : Number, range : Number = -1) {
			this.force = force;
			this.strength = strength;
			this.position = position;
			this.range = range;
			this.rangeSqr = range*range;
		}

		override public function applyForce(targetParticle : Particle) : void {
			if (!active) return;
			var difference:Vector2D = new Vector2D(position.x - targetParticle.pos.x,position.y - targetParticle.pos.y);//position.minus(targetParticle.pos);
			if ((range>=0)&&(difference.x * difference.x + difference.y * difference.y > rangeSqr)) return;
			targetParticle.addForce(force(difference, strength));
		}
	}
}
