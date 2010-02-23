package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.emitters.Emitter;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleGroup {
		
		public var particles : Particle;
		public var springs : Array;
		public var emitters : Array;
		
		private var _id:int;
		private static var _nextid:int = 0;

		public function ParticleGroup() {
			_id = _nextid++;
			particles = null;
			springs = [];
			emitters = [];
		}
		
		public function addParticle(p : Particle) : void {
			p.next = particles;
			if (particles) particles.prev = p;
			particles = p;
		}
		
		public function removeParticle(p:Particle) : void {
			Particle.removeParticle(particles, p);
		}

		public function addSpring(s : Spring) : void {
			springs.push(s);
		}

		public function removeSpring(s : Spring) : void {
			//_springs.push(s);
		}
		
		public function addEmitter(e : Emitter) : void {
			e.group = this;
			emitters.push(e);
		}
		
	}
}
