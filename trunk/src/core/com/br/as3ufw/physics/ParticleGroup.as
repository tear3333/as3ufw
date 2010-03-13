package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.emitters.IEmitter;
	import com.br.as3ufw.physics.forces.IForceGenerator;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleGroup {

		public var particles : Particle;
		public var springs : Array;
		public var emitters : Array;
		public var forceGenerators : Array;

		public var particleCount : int;

		public var doRender : Boolean;

		private var _id : int;
		private static var _nextid : int = 0;

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
			particleCount++;
		}

		public function removeParticle(p : Particle) : void {
			Particle.removeParticle(particles, p);
			particleCount--;
		}

		public function addSpring(s : Spring) : void {
			springs.push(s);
		}

		public function removeSpring(s : Spring) : void {
			//_springs.push(s);
		}

		public function addEmitter(e : IEmitter) : void {
			e.group = this;
			emitters.push(e);
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			forceGenerators.push(f);
		}

		virtual public function render() : void {
		}

		public function renderPoints(graphics : Graphics,size : Number,colour : uint = 0, alpha : Number = 1) : void {
			graphics.lineStyle(1, colour, alpha);
			
			var particle : Particle = particles;
			while (particle) {
				graphics.drawCircle(particle.pos.x, particle.pos.y, size);
				particle = particle.next;
			}
		}

		public function renderCurveLine(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) : void {
			if (!particles || particleCount < 3) return;

			graphics.lineStyle(width, colour, alpha);
			graphics.moveTo(particles.pos.x, particles.pos.y);

			var particle : Particle = particles.next;
			while (particle) {
				if (particle.next.next) {
					graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + particle.next.pos.x) / 2, (particle.pos.y + particle.next.pos.y) / 2);
				} else {
					graphics.curveTo(particle.pos.x, particle.pos.y, particle.next.pos.x, particle.next.pos.y);
					return;
				}
				particle = particle.next;
			}			
		}
	}
}
