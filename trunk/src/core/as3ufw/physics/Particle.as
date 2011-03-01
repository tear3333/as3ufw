package as3ufw.physics {
	import as3ufw.utils.Random;
	import as3ufw.physics.fluid.Constants;
	import as3ufw.geom.Vector2D;

	import flash.display.Graphics;
	import flash.utils.getTimer;

	/**
	 * The basic physics entity in the engine.
	 * Holds position, mass and force information.
	 * @author Richard.Jewson
	 */
	public class Particle {
		public const pos : Vector2D = new Vector2D();
		public const prevPos : Vector2D = new Vector2D();
		public const oldPos : Vector2D = new Vector2D();
		public const initPos : Vector2D = new Vector2D();
		public var fixed : Boolean;
		public var forces : Vector2D;
		public var mass : Number;
		public var invMass : Number;
		private var _deltaT : Number;
		private var temp : Vector2D;
		public var mask : uint;
		public var prev : Particle;
		public var next : Particle;
		public var birth : uint;
		public var ttl : uint;
		public var count : uint;
		public var colour : uint;
		public var decay : Number;
		public var active : Boolean;
		public var draw : Boolean;
		public var params : Object;
		public var userData : Object;

		public var density : Number;
		public var pressure : Number;
		public var radius : Number;
		
		public var blob : int = Random.boolean() ? -1 : 1;

		/*
		 * Constructs the particle
		 * 
		 * @param pos 	The inital position of the particle
		 * @param mass 	The mass of the particle.  
		 * 				Must not be <=0 (if it is it will be set to a very low number)
		 * 				To make the particle imovable, set to Math.POSITIVE_INFINITY
		 */
		public function Particle(pos : Vector2D) {
			// this.pos = new Vector2D();
			// prevPos = new Vector2D();
			// oldPos = new Vector2D();
			// initPos = new Vector2D();
			forces = new Vector2D();
			temp = new Vector2D();
			userData = {};
			reset(pos);
		}

		public function reset(pos : Vector2D) : void {
			this.pos.copy(pos);
			prevPos.copy(pos);
			oldPos.copy(pos);
			initPos.copy(pos);
			fixed = false;
			forces.setTo(0, 0);
			prev = next = null;
			setMass(1);
			count = 0;
			birth = getTimer();
			ttl = 0;
			colour = 0x000000;
			decay = 1;
			active = true;
			draw = true;
			params = {};
			mask = 0;
			density = Constants.DENSITY_OFFSET;
			pressure = 0;
			radius = 1;
			_deltaT = 0.0625;
		}

		public function addForce(f : Vector2D) : void {
			// forces.plusEquals(f.mult(invMass));
			forces.x += f.x * invMass;
			forces.y += f.y * invMass;
		}

		public function addMasslessForce(f : Vector2D) : void {
			// forces.plusEquals(f);
			forces.x += f.x;
			forces.y += f.y;
		}

		public function update(now : uint, damping : Number, globalForce:Vector2D ) : Boolean {
			if (ttl > 0 && now - birth > ttl ) return false;
			if (fixed) return true;
			// Optimization
			// forces.multEquals(_invMass);
			
			forces.x += globalForce.x;
			forces.y += globalForce.y;
			
			forces.x *= invMass;
			forces.y *= invMass;

			// Optimization
			// temp.copy(pos);
			temp.x = pos.x;
			temp.y = pos.y;

			// Optimization
			// var vel : Vector2D = velocity.plus(forces.multEquals(deltaT));
			// pos.plusEquals(vel.multEquals(damping));
			pos.x += ( ( ( pos.x - prevPos.x ) + forces.x * _deltaT ) * damping * decay );
			pos.y += ( ( ( pos.y - prevPos.y ) + forces.y * _deltaT ) * damping * decay );

			// Optimization
			// oldPos.copy(prevPos);
			oldPos.x = prevPos.x;
			oldPos.y = prevPos.y;

			// Optimization
			// prevPos.copy(temp);
			prevPos.x = temp.x;
			prevPos.y = temp.y;

			// Optimization
			// forces.setTo(0, 0);
			forces.x = forces.y = 0;
			count++;

			return true;
		}

		public function get velocity() : Vector2D {
			return pos.minus(prevPos);
		}

		public function set velocity(v : Vector2D) : void {
			prevPos.copy(pos.minus(v));
		}

		public function setMass(m : Number) : void {
			if (m <= 0) m = 0.0000001;
			mass = m;
			invMass = 1 / m;
		}

		public function get deltaT() : Number {
			return _deltaT;
		}

		public function set deltaT(deltaT : Number) : void {
			_deltaT = deltaT;
		}

		public function setStaticPosition(position : Vector2D) : void {
			pos.x = prevPos.x = position.x;
			pos.y = prevPos.y = position.y;
		}

		public function skew(delta : Vector2D) : void {
			pos.plusEquals(delta);
			prevPos.plusEquals(delta);
			oldPos.plusEquals(delta);
			initPos.plusEquals(delta);
		}

		private static var _particlePool : Particle;
		private static var _maxPoolCount : int;

		public static function GetParticle(pos : Vector2D) : Particle {
			if (_particlePool) {
				// trace("from pool");
				var p : Particle = _particlePool;
				_particlePool = p.next;
				p.reset(pos);
				return p;
			}
			// trace(++_maxPoolCount);
			return new Particle(pos);
		}

		public static function RecycleParticle(p : Particle) : void {
			if (_particlePool) {
				_particlePool.prev = p;
			}
			p.next = _particlePool;
			p.prev = null;
			p.active = false;
			_particlePool = p;
		}

		public function GetHashCode() : int {
			return (pos.x * Constants.PRIME_1) ^ (pos.y * Constants.PRIME_2);
		}

		public function render(g : Graphics, colour : uint = 0x000000) : void {
			g.lineStyle(1, colour);
			g.drawRect(pos.x - 1, pos.y - 1, 2, 2);
		}
	}
}
