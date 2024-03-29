package as3ufw.physics.emitters {
	import as3ufw.utils.ObjectUtils;
	import as3ufw.physics.Particle;
	import as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class PointEmitter extends AbstractEmitter {

		public var position : Vector2D;
		public var angle : Number;
		public var velocity : Number;
		
		public function PointEmitter() {
			super();
			angle = 0;
		}

		override public function emit(params:Object = null) : Particle {
			var p:Particle = Particle.GetParticle(position.clone());
			var v:Vector2D = new Vector2D(0,-velocity);
			v.angle = angle;
			p.velocity = v;
			ObjectUtils.set(p, params);
			group.addParticle(p);
			return p;
		}
		
	}
}
