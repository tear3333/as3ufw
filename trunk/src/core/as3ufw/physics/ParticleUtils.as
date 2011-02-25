package as3ufw.physics {
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleUtils {
		
		public static function createSpringCircle(group : ParticleGroup, centerParticle : Particle, count : int, radius : Number) : void {
			var first : Particle;
			var last : Particle;

			for (var i : int = 0;i < count;i++) {
				var pos : Vector2D = new Vector2D(radius, 0);

				pos.angle = ( -2 * Math.PI * i) / (count);
				pos.plusEquals(centerParticle.pos);
				var p : Particle = Particle.GetParticle(pos);
				group.addParticle(p);
				if (i == 0) first = p;

				var spring : Spring = new Spring(centerParticle, p, 0.01);
				group.addSpring(spring);

				if (last) {
					group.addSpring(new Spring(last, p, 0.4));
				}

				last = p;
			}
			group.addSpring(new Spring(last, first, 0.4));
		}
	}
}
