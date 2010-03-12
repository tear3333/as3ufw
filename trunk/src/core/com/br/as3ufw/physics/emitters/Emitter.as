package com.br.as3ufw.physics.emitters {
	import com.br.as3ufw.physics.Particle;
	import com.br.as3ufw.physics.ParticleEngine;
	import com.br.as3ufw.physics.ParticleGroup;

	/**
	 * @author Richard.Jewson
	 */
	public class Emitter {

		private var _group : ParticleGroup;

		public function Emitter() {
		}

		virtual public function emit(params:Object = null) : Particle {
			return null;
		}

		virtual public function update() : void {
		}

		public function set group(group : ParticleGroup) : void {
			_group = group;
		}

		public function get group() : ParticleGroup {
			return _group;
		}
	}
}
