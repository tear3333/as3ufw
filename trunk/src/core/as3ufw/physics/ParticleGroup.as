package as3ufw.physics {
	import as3ufw.physics.constraints.IConstraint;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.constraints.Spring;
	import as3ufw.physics.emitters.IEmitter;
	import as3ufw.physics.forces.IForceGenerator;
	import as3ufw.physics.renderers.IRenderer;
	import flash.display.Graphics;
	import flash.utils.getTimer;




	/**
	 * @author Richard.Jewson
	 */
	public class ParticleGroup {

		public var particles : Particle;
		public var controlParticles : Vector.<Particle>;
		public var constraints : Vector.<IConstraint>;
		public var emitters : Vector.<IEmitter>;
		public var renderers : Vector.<IRenderer>;
		public var forceGenerators : Vector.<IForceGenerator>;

		public var pos:Vector2D;
		
		public var globalForce:Vector2D;

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
			constraints = new Vector.<IConstraint>();
			emitters = new Vector.<IEmitter>();
			renderers = new Vector.<IRenderer>();
			forceGenerators = new Vector.<IForceGenerator>();
			pos = new Vector2D();
			globalForce = new Vector2D();
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
			if (p.prev == null)
				particles = p.next;
			else
				p.prev.next = p.next;
			if (p.next != null)
				p.next.prev = p.prev;
			
//			if (p == particles) {                                                
//				particles = p.next;
//				particles.prev = null;
//			} else {
//				p.prev.next = p.next;
//				if (p.next) p.next.prev = p.prev;
//			}
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

		public function addConstraint(c : IConstraint) : void {
			constraints.push(c);
		}

		public function removeConstraint(c : IConstraint) : void {
			var i : int = constraints.indexOf(c);
			if (i>-1) {
				constraints.splice(i, 1);
			}
		}

		public function addEmitter(e : IEmitter) : void {
			e.group = this;
			emitters.push(e);
		}

		public function removeEmitter(e : IEmitter) : void {
			var i : int = emitters.indexOf(e);
			if (i>-1) {
				emitters.splice(i, 1);
			}
		}

		public function addRenderer(r : IRenderer) : void {
			renderers.push(r);
		}

		public function removeRenderer(r : IRenderer) : void {
			var i : int = renderers.indexOf(r);
			if (i>-1) {
				renderers.splice(i, 1);
			}
		}

		public function addForceGenerator(f : IForceGenerator) : void {
			forceGenerators.push(f);
		}

		public function removeForceGenerator(f : IForceGenerator) : void {
			var i : int = forceGenerators.indexOf(f);
			if (i>-1) {
				forceGenerators.splice(i, 1);
			}
		}

		public function update( engineForceGenerators:Vector.<IForceGenerator> ) : void {
			var now : uint = getTimer();
	
			var fgen : IForceGenerator;
			for each (fgen in engineForceGenerators) {
				fgen.applyForce(particles);
			}
			for each (fgen in forceGenerators) {
				fgen.applyForce(particles);
			}
			var particle : Particle = particles;
			while (particle) {
				if (!particle.update(now, damping, globalForce)) {
					var nextParticle:Particle = particle.next;
					removeParticle(particle);
					particle = nextParticle;
				} else {
					particle = particle.next;
				}
			}
			for (var i : int = 0; i < iterations; i++) {
				var iterationPercent:Number = i/iterations;
				for each (var constraint : IConstraint in constraints) {
					constraint.resolve(iterationPercent);
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

	}
}
