package as3ufw.physics.emitters {
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleEngine;
	import as3ufw.physics.ParticleGroup;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractEmitter implements IEmitter {

		private var _group : ParticleGroup;

		public function AbstractEmitter() {
		}

		virtual public function emit(params:Object = null) : Particle {
			return null;
		}

		virtual public function update() : void {
		}

		virtual public function set group(group : ParticleGroup) : void {
			_group = group;
		}

		virtual public function get group() : ParticleGroup {
			return _group;
		}
	}
}
