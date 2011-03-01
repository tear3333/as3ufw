package as3ufw.physics.forces {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	/**
	 * @author richard.jewson
	 */
	public class Gravity extends AbstractForce {
		public function Gravity() {
		}

		override public function applyForce(targetParticles : Particle) : void {
			if (!active) return;
			var particle : Particle = targetParticles;
			while (particle) {
				
				var nextParticle:Particle = particle.next;
				while (nextParticle) {
					
					var delta:Vector2D = particle.pos.minus(nextParticle.pos);
					var dSqrd:Number = delta.magnitudeSqr;
					var f:Number = (particle.mass * nextParticle.mass) / dSqrd;
					particle.addMasslessForce(delta.mult(-f));
					nextParticle.addMasslessForce(delta.mult(f));
					
					nextParticle = nextParticle.next;				
				}
				
				particle = particle.next;
			}
		}
	}
}
