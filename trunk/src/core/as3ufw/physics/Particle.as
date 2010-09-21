 package as3ufw.physics {
	import flash.utils.getTimer;

	import as3ufw.geom.Vector2D;

	import flash.display.Graphics;

	/**
	 * The basic physics entity in the engine.
	 * Holds position, mass and force information.
	 * @author Richard.Jewson
	 */
	public class Particle {
		public var pos : Vector2D;
		public var prevPos : Vector2D;
		public var oldPos : Vector2D;

		public var initPos : Vector2D;

		public var fixed : Boolean;

		private var forces : Vector2D;
		
		private var _mass : Number;
		private var _invMass : Number;
		private var _deltaT : Number;
		
		private var temp : Vector2D;

		public var mask:uint;
		public var prev:Particle;
		public var next:Particle;
		public var birth : uint;
		public var ttl : uint;
		public var colour : uint;
		public var decay : Number;
		public var active : Boolean;
		public var params : Object;

		/*
		 * Constructs the particle
		 * 
		 * @param pos 	The inital position of the particle
		 * @param mass 	The mass of the particle.  
		 * 				Must not be <=0 (if it is it will be set to a very low number)
		 * 				To make the particle imovable, set to Math.POSITIVE_INFINITY
		 */
		public function Particle(pos : Vector2D) {
			this.pos = new Vector2D();
			prevPos = new Vector2D();
			oldPos = new Vector2D();
			initPos = new Vector2D();
			forces = new Vector2D();
			temp = new Vector2D();
			reset(pos);
		}

		public function reset(pos : Vector2D):void {
			this.pos.copy(pos);
			prevPos.copy(pos);
			oldPos.copy(pos);
			initPos.copy(pos);
			forces.setTo(0, 0);
			prev = next = null;
			mass = 1;
			birth = getTimer();
			ttl = 0;
			colour = 0x000000;
			decay = 1;
			active = true;
			//params = {}
			mask = 0;
			_deltaT = 0.0625;			
		}

		public function addForce(f : Vector2D) : void {
			forces.plusEquals(f.mult(_invMass));
		}

		public function addMasslessForce(f : Vector2D) : void {
			forces.plusEquals(f);
		}
		
		public function update(now:uint, damping : Number = 1) : Boolean {
			if (ttl>0 && now-birth > ttl ) return false;
			if (fixed) return true;
			//Optimization
			//forces.multEquals(_invMass);
			forces.x *= _invMass;
			forces.y *= _invMass;
			
			//Optimization
			//temp.copy(pos); 
			temp.x = pos.x;
			temp.y = pos.y;
			
			//Optimization                    
			//var vel : Vector2D = velocity.plus(forces.multEquals(deltaT));
			//pos.plusEquals(vel.multEquals(damping));
			pos.x += ( ( ( pos.x - prevPos.x ) + forces.x * deltaT ) * damping * decay );
			pos.y += ( ( ( pos.y - prevPos.y ) + forces.y * deltaT ) * damping * decay );
			
			//Optimization  			
			//oldPos.copy(prevPos);
			oldPos.x = prevPos.x;
			oldPos.y = prevPos.y;

			//Optimization  			
			//prevPos.copy(temp);
			prevPos.x = temp.x;
			prevPos.y = temp.y;
			
			//Optimization 
			//forces.setTo(0, 0);
			forces.x = forces.y = 0;
			
			return true;
		}
		
		public function get velocity() : Vector2D {
			return pos.minus(prevPos);
		}

		public function set velocity(v : Vector2D) : void {
			prevPos = pos.minus(v);
		}
		
		public function set mass(m:Number) : void {
			if (mass<=0) mass = 0.0000001;
			_mass = m;
			_invMass = 1/m;
		}

		public function get mass():Number {
			return _mass;
		}
		
		public function get invMass():Number {
			return _invMass;
		}		
		
		public function get deltaT() : Number {
			return _deltaT;
		}
		
		public function set deltaT(deltaT : Number) : void {
			_deltaT = deltaT;
		}

		public function setStaticPosition(position:Vector2D) : void {
			pos.x = prevPos.x = oldPos.x = position.x;
			pos.y = prevPos.y = oldPos.y = position.y;
		}

		private static var _particlePool:Particle;
		private static var _maxPoolCount:int;
		
		public static function GetParticle(pos : Vector2D):Particle {
			if (_particlePool) {
				//trace("from pool");
				var p:Particle = _particlePool;
				_particlePool = p.next;
				p.reset(pos);
				return p;
			}
			//trace(++_maxPoolCount);
			return new Particle(pos);
		}
		
		public static function RecycleParticle(p:Particle):void {
			if (_particlePool) {
				_particlePool.prev = p;
			}
			p.next = _particlePool;
			p.prev = null;
			p.active = false;
			_particlePool = p;
		}
	}
}
