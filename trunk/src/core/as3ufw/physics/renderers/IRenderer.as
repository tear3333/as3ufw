package as3ufw.physics.renderers {
	import as3ufw.physics.ParticleGroup;

	/**
	 * @author Richard.Jewson
	 */
	public interface IRenderer {
		function render( g:ParticleGroup ):void;
	}
}
