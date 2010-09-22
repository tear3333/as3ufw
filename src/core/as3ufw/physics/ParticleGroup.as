package as3ufw.physics {
	import as3ufw.geom.Vector2D;

	import flash.utils.getTimer;

	import as3ufw.physics.emitters.IEmitter;
	import as3ufw.physics.forces.IForceGenerator;
	import as3ufw.physics.renderers.IRenderer;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleGroup {

		public var particles : Particle;
		public var controlParticles : Vector.<Particle>;
		public var springs : Vector.<Spring>;
		public var emitters : Vector.<IEmitter>;
		public var renderers : Vector.<IRenderer>;
		public var forceGenerators : Vector.<IForceGenerator>;

		public var pos:Vector2D;

		public var particleCount : int;

		public var doRender : Boolean;

		public var damping : Number;
		public var iterations : int;

		private var _id : int;
		private static var _nextid : int = 0;

		public function ParticleGroup() {
			_id = _nextid++;
			particles = null;
			controlParticles = new Vector.<Particle>();
			springs = new Vector.<Spring>();
			emitters = new Vector.<IEmitter>();
			renderers = new Vector.<IRenderer>();
			forceGenerators = new Vector.<IForceGenerator>();
			pos = new Vector2D();
			doRender = true;
			damping = 1;
			iterations = 1;
		}

		public function addParticle(p : Particle) : void {
			p.next = particles;
			if (particles) particles.prev = p;
			particles = p;
			particleCount++;
		}

		public function removeParticle(p : Particle) : void {
			if (p == particles) {                                                
				particles = p.next;
				particles.prev = null;
			} else {
				p.prev.next = p.next;
				if (p.next) p.next.prev = p.prev;
			}
			Particle.RecycleParticle(p);
			particleCount--;
		}

		public function addControlParticle(p : Particle) : void {
			controlParticles.push(p);
		}

		public function removeControlParticle(p : Particle) : void {
			var i : int = controlParticles.indexOf(p);
			if (i>-1) {
				controlParticles.splice(i, 1);
			}
		}

		public function addSpring(s : Spring) : void {
			springs.push(s);
		}

		public function removeSpring(s : Spring) : void {
			//TODO finish
		}

		public function addEmitter(e : IEmitter) : void {
			e.group = this;
			emitters.push(e);
		}

		public function removeEmitter(e : IEmitter) : void {
			//TODO finish
		}

		public function addRenderer(r : IRenderer) : void {
			renderers.push(r);
		}

		public function removeRenderer(r : IRenderer) : void {
			//TODO finish
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			forceGenerators.push(f);
		}

		public function removeForceGenerator(f : IForceGenerator) : void {
			//TODO finish
		}

		public function update( engineForceGenerators:Vector.<IForceGenerator> ) : void {
			var now : uint = getTimer();
	
			var particle : Particle = particles;
			while (particle) {
				var fgen : IForceGenerator;
				for each (fgen in engineForceGenerators) {
					fgen.applyForce(particle);
				}
				for each (fgen in forceGenerators) {
					fgen.applyForce(particle);
				}
				if (!particle.update(now, damping)) {
					var nextParticle:Particle = particle.next;
					removeParticle(particle);
					particle = nextParticle;
				} else {
					particle = particle.next;
				}
			}
			for (var i : int = 0; i < iterations; i++) {
				for each (var spring : Spring in springs) {
					spring.resolve();
				}
			}
			render();
		}

		public function skew(delta:Vector2D) : void {
			var particle : Particle = particles;
			while (particle) {
				particle.skew(delta);
				particle = particle.next;
			}
			for each ( particle in controlParticles) {
				particle.skew(delta);
			}
			pos.plusEquals(delta);
		}

		
		virtual public function render() : void {
			if (!doRender) return;
			for each (var renderer : IRenderer in renderers) {
				renderer.render(this);
			}
		}

//		public function renderPoints(graphics : Graphics,size : Number,colour : uint = 0, alpha : Number = 1) : void {
//			graphics.lineStyle(1, colour, alpha);
//			
//			var particle : Particle = particles;
//			while (particle) {
//				graphics.drawCircle(particle.pos.x, particle.pos.y, size);
//				particle = particle.next;
//			}
//		}
//
//		public function renderCurveLine(graphics : Graphics,width : Number,colour : uint = 0, alpha : Number = 1) : void {
//			if (!particles || particleCount < 3) return;
//
//			graphics.lineStyle(width, colour, alpha);
//			graphics.moveTo(particles.pos.x, particles.pos.y);
//
//			var particle : Particle = particles.next;
//			while (particle) {
//				if (particle.next.next) {
//					graphics.curveTo(particle.pos.x, particle.pos.y, (particle.pos.x + particle.next.pos.x) / 2, (particle.pos.y + particle.next.pos.y) / 2);
//				} else {
//					graphics.curveTo(particle.pos.x, particle.pos.y, particle.next.pos.x, particle.next.pos.y);
//					return;
//				}
//				particle = particle.next;
//			}			
//		}
	}
}
