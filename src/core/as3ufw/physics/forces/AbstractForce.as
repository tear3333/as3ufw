package com.br.as3ufw.physics.forces {
	import com.br.as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractForce implements IForceGenerator {

		private var _active : Boolean = true;

		virtual public function applyForce(targetParticle : Particle) : void {
		}

		public function get active() : Boolean {
			return _active;
		}

		public function set active(a : Boolean) : void {
			_active = a;
		}
	}
}
