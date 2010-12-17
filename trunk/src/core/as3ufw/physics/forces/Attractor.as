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
			//var difference:Vector2D = new Vector2D(position.x - targetParticle.pos.x,position.y - targetParticle.pos.y);//position.minus(targetParticle.pos);
			var differenceX:Number = position.x - targetParticle.pos.x;
			var differenceY:Number = position.y - targetParticle.pos.y;
			if ((range>=0)&&( (differenceX * differenceX + differenceY * differenceY) > rangeSqr) ) return;
			targetParticle.addForce(force(new Vector2D(differenceX,differenceY), strength));
		}
	}
}
