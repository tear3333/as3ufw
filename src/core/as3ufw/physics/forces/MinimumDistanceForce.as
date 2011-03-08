package as3ufw.physics.forces {
	import as3ufw.physics.Particle;
	/**
	 * @author richard.jewson
	 */
	public class MinimumDistanceForce extends AbstractForce {
		private var distance : Number;
		private var stiffness : Number;

		public function MinimumDistanceForce(stiffness : Number = 0.4, distance : Number = 0) {
			this.stiffness = stiffness;
			this.distance = distance;
		}

		override public function applyForce(targetParticles : Particle) : void {
			if (!active) return;
			var distX : Number;
			var distY : Number;
			var distSqrd : Number;
			var particle : Particle = targetParticles;
			while (particle) {
				var particle2 : Particle = particle.next;
				while (particle2) {
					
					distX = particle.pos.x - particle2.pos.x;
					distY = particle.pos.y - particle2.pos.y;
					distSqrd = distX * distX + distY * distY;
					var minDist:Number = (particle.radius + particle2.radius + distance) * 0.5;
					var minDistSq : Number = minDist * minDist;
					if (distSqrd < minDistSq) {
						if (distSqrd > 0.0000001) {
							var distLen : Number = Math.sqrt(distSqrd);
							distX *= stiffness * ((distLen - minDist) / distLen);
							distY *= stiffness * ((distLen - minDist) / distLen);

							particle2.pos.x += distX * particle2.invMass;
							particle2.pos.y += distY * particle2.invMass;
//							if (correctV) {
//								particle2.prevPos.x += distX;
//								particle2.prevPos.y += distY;
//							}
							particle.pos.x -= distX * particle.invMass;
							particle.pos.y -= distY * particle.invMass;
							// if (correctV) {
							// particle.prevPos.x -= distX;
							// particle.prevPos.y -= distY;
							// }
							
						} else {
							var diff:Number = 0.5 * minDist;
							particle2.pos.y += diff;
							//particle2.prevPos.y += diff;
							particle.pos.y -= diff;
							//particle.prevPos.y -= diff;
						}
					}
					particle2 = particle2.next;
				}
				particle = particle.next;
				
			}
		}
	}
}
