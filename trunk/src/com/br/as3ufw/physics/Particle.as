 package com.br.as3ufw.physics {
	import com.br.as3ufw.geom.Vector2D;
	import com.br.as3ufw.physics.forces.IForceGenerator;

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
		
		private var forceGenerators:Array;

		private var _mass : Number;
		private var _invMass : Number;
		private var _deltaT : Number;
		
		private var temp : Vector2D;

		/*
		 * Constructs the particle
		 * 
		 * @param pos 	The inital position of the particle
		 * @param mass 	The mass of the particle.  
		 * 				Must not be <=0 (if it is it will be set to a very low number)
		 * 				To make the particle imovable, set to Math.POSITIVE_INFINITY
		 */
		public function Particle(pos : Vector2D, mass : Number = 1) {
			this.pos = pos;
			this.oldPos = pos.clone();
			this.initPos = pos.clone();
			this.forces = new Vector2D();
			this.forceGenerators = [];
			this.temp = new Vector2D();
			this.mass = mass;
			
			_deltaT = 0.0625;

		}

		public function addForce(f : Vector2D) : void {
			forces.plusEquals(f.mult(_invMass));
		}

		public function addMasslessForce(f : Vector2D) : void {
			forces.plusEquals(f);
		}
		
		public function addForceGenerator(g : IForceGenerator) : void {
			forceGenerators.push(g);
		}
		
		public function clearForceGenerator() : void {
			forceGenerators.length = 0;
		}

		public function update(damping : Number = 1) : void {
			if (fixed) return;
			forces.multEquals(_invMass);
			for each (var fgen : IForceGenerator in forceGenerators) {
				fgen.applyForce(this);
			}
			temp.copy(pos);                        
			var vel : Vector2D = velocity.plus(forces.multEquals(deltaT));
			pos.plusEquals(vel.multEquals(damping));
			oldPos.copy(temp);
			forces.setTo(0, 0);
		}
		
		public function render(g:Graphics,colour:uint,size:Number):void {
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

	}
}
