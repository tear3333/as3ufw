package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.forces.IForceGenerator;

	import flash.utils.getTimer;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleEngine {

		public var groups : Array;
		public var forceGenerator : Array;

		public var damping : Number;

		public function ParticleEngine() {
			forceGenerator = [];
			groups = [];
			damping = 1;
		}

		public function update() : void {
			var now : uint = getTimer();
			for each (var group : ParticleGroup in groups) {
		
				var particle : Particle = group.particles;
				while (particle) {
					var fgen : IForceGenerator;
					for each (fgen in forceGenerator) {
						fgen.applyForce(particle);
					}
					for each (fgen in group.forceGenerators) {
						fgen.applyForce(particle);
					}
					if (!particle.update(now, damping)) {
						particle = Particle.removeParticle(group.particles, particle);            
						continue;
					}
					
					particle = particle.next;
				}
				for each (var spring : Spring in group.springs) {
					spring.resolve();
				}
				if (group.doRender) group.render();
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
