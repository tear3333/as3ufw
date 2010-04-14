package com.br.as3ufw.physics.emitters {
	import com.br.as3ufw.physics.Particle;
	import com.br.as3ufw.physics.ParticleGroup;

	/**
	 * @author Richard.Jewson
	 */
	public interface IEmitter {
		function emit(params : Object = null) : Particle;

		function update() : void;

		function set group(group : ParticleGroup) : void;

		function get group() : ParticleGroup;
	}
}
