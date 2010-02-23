package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.emitters.Emitter;
	import com.br.as3ufw.physics.forces.IForceGenerator;

	import flash.display.Graphics;
	import flash.utils.getTimer;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleEngine {

		private var _groups : Array;
		private var _forceGenerator : Array;

		private var _graphics : Graphics;
		public var damping : Number;

		public function ParticleEngine() {
			_forceGenerator = [];
			_groups = [];
			damping = 0;
		}

		public function update() : void {
			var now : uint = getTimer();
			for each (var group : ParticleGroup in _groups) {
		
				var particle : Particle = group.particles;
				while (particle) {
				
					for each (var fgen : IForceGenerator in _forceGenerator) {
						fgen.applyForce(particle);
					}
				
					if (!particle.update(now, damping)) {
						particle = Particle.removeParticle(group.particles, particle);            
						continue;
					}
					if (_graphics)
					particle.render(_graphics, 0x000000, 2);
					particle = particle.next;
				}
				for each (var spring : Spring in group.springs) {
					spring.resolve();
				}
			}
		}

		public function addGroup(g : ParticleGroup) : void {
			_groups.push(g);
		}

		public function removeGroup(g : ParticleGroup) : void {
			//_springs.push(s);
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			_forceGenerator.push(f);
		}

		public function set graphics(graphics : *) : void {
			_graphics = graphics;
		}
	}
}
