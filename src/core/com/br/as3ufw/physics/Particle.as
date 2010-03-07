 package com.br.as3ufw.physics {
	import flash.utils.getTimer;

	import com.br.as3ufw.geom.Vector2D;

	import flash.display.Graphics;

	/**
	 * The basic physics entity in the engine.
	 * Holds position, mass and force information.
	 * @author Richard.Jewson
	 */
	public class Particle {
		public var pos : Vector2D;
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
		public var active : Boolean;

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
			this.oldPos = new Vector2D();
			this.initPos = new Vector2D();
			this.forces = new Vector2D();
			this.temp = new Vector2D();
			reset(pos);
		}

		public function reset(pos : Vector2D):void {
			this.pos.copy(pos);
			this.oldPos.copy(pos);
			this.initPos.copy(pos);
			this.forces.setTo(0, 0);
			this.mass = mass;
			this.prev = this.next = null;
			mass = 1;
			birth = getTimer();
			ttl = 0;
			active = false;
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
			if (ttl && now-birth > ttl ) return false;
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
			pos.x += ((velocity.x + forces.x*deltaT) * damping);
			pos.y += ((velocity.y + forces.y*deltaT) * damping);
			
			//Optimization  			
			//oldPos.copy(temp);
			oldPos.x = temp.x;
			oldPos.y = temp.y;
			
			//Optimization 
			//forces.setTo(0, 0);
			forces.x = forces.y = 0;
			
			return true;
		}
		
		virtual public function render(g:Graphics,colour:uint,size:Number):void {
			g.lineStyle(1,colour);
			g.drawRect(pos.x-size, pos.y-size, size*2, size*2);	
		}
		
		public function get velocity() : Vector2D {
			return pos.minus(oldPos);
		}

		public function set velocity(v : Vector2D) : void {
			oldPos = pos.minus(v);
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

		private static var _particlePool:Particle;
		private static var _maxPoolCount:int;
		
		public static function GetParticle(pos : Vector2D):Particle {
			if (_particlePool) {
				trace("from pool");
				var p:Particle = _particlePool;
				_particlePool = p.next;
				p.reset(pos);
				return p;
			}
			trace(++_maxPoolCount);
			return new Particle(pos);
		}
		
		public static function removeParticle(head:Particle, p : Particle) : Particle {
			var next:Particle = p.next;
			if (p == head) {                                                
				head = p.next;
			} else {
				p.prev.next = p.next;
			}
			if (p.next == null) {
				
			} else {
				p.next.prev = p.prev;
			}
			Particle.RecycleParticle(p);
			return next;
		}		
		
		public static function RecycleParticle(p:Particle):void {
			if (_particlePool) {
				_particlePool.prev = p;
			}
			p.next = _particlePool;
			p.prev = null;
			_particlePool = p;
		}
	}
}
