package com.br.as3ufw.physics.forces {
	import com.br.as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public interface IForceGenerator {
		function applyForce(targetParticle : Particle) : void;

		function set active(a : Boolean) : void;

		function get active() : Boolean;
	}
}
