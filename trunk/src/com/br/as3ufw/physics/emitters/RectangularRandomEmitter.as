package com.br.as3ufw.physics.emitters {
	import com.br.as3ufw.utils.Random;
	import com.br.as3ufw.geom.Vector2D;
	import com.br.as3ufw.physics.Particle;
	import com.br.as3ufw.physics.emitters.Emitter;

	import flash.geom.Rectangle;

	/**
	 * @author Richard.Jewson
	 */
	public class RectangularRandomEmitter extends Emitter {
		private var _rectangle : Rectangle;
		
		public function RectangularRandomEmitter( rectangle : Rectangle ) {
			this._rectangle = rectangle;
		}

		override public function emit(params:Object) : void {
			var p:Particle = Particle.GetParticle(new Vector2D(Random.integer(_rectangle.left, _rectangle.right),Random.integer(_rectangle.top, _rectangle.bottom)));
			p.ttl = Random.integer(500, 2000);
			engine.addParticle(p);
		}
	}
}
