package as3ufw.physics {
	import as3ufw.physics.forces.IForceGenerator;

	import flash.utils.getTimer;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleEngine {

		public var groups : Vector.<ParticleGroup>;
		public var forceGenerator : Vector.<IForceGenerator>;

		public function ParticleEngine() {
			forceGenerator = new Vector.<IForceGenerator>();
			groups = new Vector.<ParticleGroup>();
		}

		public function update() : void {
			for each (var group : ParticleGroup in groups) {
				group.update(forceGenerator);
			}
		}

		public function addGroup(g : ParticleGroup) : void {
			groups.push(g);
		}

		public function removeGroup(g : ParticleGroup) : void {
			//_springs.push(s);
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			forceGenerator.push(f);
		}
	}
}
