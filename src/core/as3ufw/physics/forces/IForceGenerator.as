package as3ufw.physics.forces {
	import as3ufw.physics.Particle;

	/**
	 * @author Richard.Jewson
	 */
	public interface IForceGenerator {
		function applyForce(targetParticles : Particle) : void;

		function set active(a : Boolean) : void;

		function get active() : Boolean;
	}
}
