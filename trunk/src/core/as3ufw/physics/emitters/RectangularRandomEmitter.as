package as3ufw.physics.emitters {
	import as3ufw.physics.ParticleGroup;
	import as3ufw.utils.ObjectUtils;
	import as3ufw.utils.Random;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.emitters.AbstractEmitter;

	import flash.geom.Rectangle;

	/**
	 * @author Richard.Jewson
	 */
	public class RectangularRandomEmitter extends AbstractEmitter {
		private var _rectangle : Rectangle;
		
		public function RectangularRandomEmitter( group:ParticleGroup, rectangle : Rectangle ) {
			this.group = group;
			this._rectangle = rectangle;
		}

		override public function emit(params:Object = null) : Particle {
			var p:Particle = Particle.GetParticle(new Vector2D(Random.integer(_rectangle.left, _rectangle.right),Random.integer(_rectangle.top, _rectangle.bottom)));
			group.addParticle(p);
			ObjectUtils.set(p, params);
			return p;
		}
	}
}
