package com.br.as3ufw.physics.emitters {
	import com.br.as3ufw.physics.Particle;
	import com.br.as3ufw.geom.Vector2D;

	/**
	 * @author Richard.Jewson
	 */
	public class PointEmitter extends Emitter {

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
			group.addParticle(p);
			return p;
		}
		
	}
}
