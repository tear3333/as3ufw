package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.emitters.Emitter;
	import com.br.as3ufw.physics.forces.IForceGenerator;

	import flash.display.Graphics;
	import flash.utils.getTimer;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleEngine {

		private var _particles : Particle;
		private var _springs : Array;
		private var _emitters : Array;
		private var _forceGenerator : Array;

		private var _graphics : Graphics;
		public var damping : Number;

		public function ParticleEngine() {
			_particles = null;
			_springs = [];
			_emitters = [];
			_forceGenerator = [];
			damping = 0;
		}

		public function update() : void {
			var particle : Particle = _particles;
			var lastParticle : Particle;
			var now : uint = getTimer();
			while (particle) {
				
				for each (var fgen : IForceGenerator in _forceGenerator) {
					fgen.applyForce(particle);
				}
				
				if (!particle.update(now, damping)) {
					var thisParticle : Particle = particle;
					if (particle == _particles) {                                                
						particle = _particles = particle.next;
					} else if (particle.next == null) {                              
						particle = lastParticle.next = null;
					} else {                                                                                
						particle = lastParticle.next = particle.next;      
					}
                                                
					Particle.RecycleParticle(thisParticle);                 
					continue;
				}
				if (_graphics)
						particle.render(_graphics, 0x000000, 2);
				lastParticle = particle;
				particle = particle.next;
			}
			for each (var spring : Spring in _springs) {
				spring.resolve();
			}
		}

		public function addParticle(p : Particle) : void {
			p.next = _particles;
			if (_particles) _particles.prev = p;
			_particles = p;
		}

		public function addSpring(s : Spring) : void {
			_springs.push(s);
		}

		public function addEmitter(e : Emitter) : void {
			e.engine = this;
			_emitters.push(e);
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			_forceGenerator.push(f);
		}

		public function set graphics(graphics : *) : void {
			_graphics = graphics;
		}
	}
}
