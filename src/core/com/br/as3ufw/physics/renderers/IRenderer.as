package com.br.as3ufw.physics.renderers {
	import com.br.as3ufw.physics.ParticleGroup;

	/**
	 * @author Richard.Jewson
	 */
	public interface IRenderer {
		function render( g:ParticleGroup ):void;
	}
}
