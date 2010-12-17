package as3ufw.physics {
	import as3ufw.physics.forces.IForceGenerator;

	import flash.utils.getTimer;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleEngine {

		public var groups : Vector.<ParticleGroup>;
		public var forceGenerators : Vector.<IForceGenerator>;

		public function ParticleEngine() {
			forceGenerators = new Vector.<IForceGenerator>();
			groups = new Vector.<ParticleGroup>();
		}

		public function update() : void {
			for each (var group : ParticleGroup in groups) {
				group.update(forceGenerators);
			}
		}

		public function addGroup(g : ParticleGroup) : void {
			groups.push(g);
		}

		public function removeGroup(g : ParticleGroup) : void {
			var i : int = groups.indexOf(g);
			if (i>-1) {
				groups.splice(i, 1);
			}
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			forceGenerators.push(f);
		}

		public function removeForceGenerator(f : IForceGenerator) : void {
			var i : int = groups.indexOf(f);
			if (i>-1) {
				forceGenerators.splice(i, 1);
			}
		}
	}
}
