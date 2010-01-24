package com.br.as3ufw.physics.emitters {
	import com.br.as3ufw.physics.ParticleEngine;

	/**
	 * @author Richard.Jewson
	 */
	public class Emitter {

		private var _engine : ParticleEngine;
		
		public function Emitter() {
		}

		virtual public function emit(params:Object) : void {
		}
		
		public function set engine(engine : ParticleEngine) : void {
			_engine = engine;
		}
		
		public function get engine() : ParticleEngine {
			return _engine;
		}
	}
}
