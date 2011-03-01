package as3ufw.physics.fluid {
	import as3ufw.physics.forces.MinimumDistanceForce;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;
	import as3ufw.physics.forces.IForceGenerator;

	/**
	 * @author richard.jewson
	 */
	public class FluidParticleGroup extends ParticleGroup {
		// protected var m_factor : Number;
		protected var m_kernelSize : Number;
		protected var m_kernelSizeSq : Number;
		protected var m_kernelSize3 : Number;
		protected var m_skpoly6_factor : Number;
		protected var m_skspiky_factor : Number;
		protected var m_skviscosity_factor : Number;
		private var rev : Number = 1;
		private var correctV : Boolean = false;
		private var minDistForce : MinimumDistanceForce;

		public function FluidParticleGroup() {
			super();
			setup(32);
		}

		private function setup(ks : Number) : void {
			// m_factor = 1;
			m_kernelSize = ks;
			m_kernelSizeSq = ks * ks;
			m_kernelSize3 = ks * ks * ks;

			var kernelRad9 : Number = Math.pow(m_kernelSize, 9.0);
			m_skpoly6_factor = (315.0 / (64.0 * Math.PI * kernelRad9));

			var kernelRad6 : Number = Math.pow(m_kernelSize, 6.0);
			m_skspiky_factor = (15.0 / (Math.PI * kernelRad6));
			
			m_skviscosity_factor = (15.0 / (2.0 * Math.PI * m_kernelSize3));
			
			minDistForce = new MinimumDistanceForce(0.05,10);
		}

		private function CalculatePressureAndDensities() : void {
			var distX : Number;
			var distY : Number;
			var particle : Particle = particles;
			while (particle) {
				particle.density = 0.0;
				var nIdx : Particle = particles.next;
				while (nIdx) {
					distX = particle.pos.x - nIdx.pos.x;
					distY = particle.pos.y - nIdx.pos.y;
					// Vector2.Sub(ref particle.Position, ref particles[nIdx].Position, out dist);
					// particle.Density += particle.Mass * this.SKGeneral.Calculate(ref dist);

					var len : Number = distX * distX + distY * distY;
					len += 0.000000000001;
					if (len < m_kernelSizeSq) {
						var diffSq : Number = m_kernelSizeSq - len;
						particle.density += particle.mass * (m_skpoly6_factor * diffSq * diffSq * diffSq);
					}
					nIdx = nIdx.next;
				}
				particle.pressure = Constants.GAS_K * (particle.density - Constants.DENSITY_OFFSET);
				particle = particle.next;
			}
		}

		private function CalculateForces() : void {
			var distX : Number;
			var distY : Number;
			var f : Vector2D = new Vector2D();
			var particle : Particle = particles;
			while (particle) {
				var particle2 : Particle = particle.next;
				while (particle2) {
					if (particle2.density > 0.00000001) {
						//rev = particle.blob == particle2.blob ? 10 : -10;
						distX = particle.pos.x - particle2.pos.x;
						distY = particle.pos.y - particle2.pos.y;


//	                    scalar   = particles[nIdx].Mass * (particles[i].Pressure + particles[nIdx].Pressure) / (2.0f * particles[nIdx].Density);
//	                    f        = this.SKPressure.CalculateGradient(ref dist);
//	                    Vector2.Mult(ref f, scalar, out f);
//	                    particles[i].Force      -= f;
//	                    particles[nIdx].Force   += f;
						var scalar : Number = particle2.mass * (particle.pressure + particle2.pressure) / (2.0 * particle2.density);
						var len : Number = distX * distX + distY * distY;
						len += 0.000000000001;
						if (len < m_kernelSizeSq) {
							f.x = f.y = 0;
							var sqtlen : Number = Math.sqrt(len);
							var ff : Number = -m_skspiky_factor * 3.0 * (m_kernelSize - sqtlen) * (m_kernelSize - sqtlen) / sqtlen;
							f.x = distX * ff;
							f.y = distY * ff;
							f.x *= scalar;
							f.y *= scalar;
							//reverse this?
							particle.forces.x -= f.x*rev;
							particle.forces.y -= f.y*rev;
							particle2.forces.x += f.x*rev;
							particle2.forces.y += f.y*rev;
						}
						
						
//						scalar   = particles[nIdx].Mass * this.SKViscosity.CalculateLaplacian(ref dist) * this.Viscosity * 1 / particles[nIdx].Density;
//                    	f        = particles[nIdx].Velocity - particles[i].Velocity;
//                    	Vector2.Mult(ref f, scalar, out f);
//                    	particles[i].Force      += f;
//                    	particles[nIdx].Force   -= f;
						if (len < m_kernelSizeSq) {
							sqtlen = Math.sqrt(len);
         					var v:Number =  m_skviscosity_factor * (6.0 / m_kernelSize3) * (m_kernelSize - len);
							scalar = particle2.mass * v * Constants.VISCOSITY * 1 / particle2.density;
							f = particle.velocity.minus(particle2.velocity);
							f.multEquals(scalar);
							particle.forces.x += f.x*rev;
							particle.forces.y += f.y*rev;
							particle2.forces.x -= f.x*rev;
							particle2.forces.y -= f.y*rev;
						}
					}
					particle2 = particle2.next;
				}
				particle = particle.next;
			}
			// Vector2 f, dist;
			// float scalar;
			// for (int i = 0; i < particles.Count; i++)
			// {
			//            //  Add global force to every particle
			// particles[i].Force += globalForce;
			//
		// foreach (var nIdx in grid.GetNeighbourIndex(particles[i]))
		// {
		//               //  Prevent double tests
		// if (nIdx < i)
		// {
		// if (particles[nIdx].Density > Constants.FLOAT_EPSILON)
		// {
		// Vector2.Sub(ref particles[i].Position, ref particles[nIdx].Position, out dist);
		//
		//                     //  pressure
		//                     //  f = particles[nIdx].Mass * ((particles[i].Pressure + particles[nIdx].Pressure) / (2.0f * particles[nIdx].Density)) * WSpikyGrad(ref dist);
		// scalar   = particles[nIdx].Mass * (particles[i].Pressure + particles[nIdx].Pressure) / (2.0f * particles[nIdx].Density);
		// f        = this.SKPressure.CalculateGradient(ref dist);
		// Vector2.Mult(ref f, scalar, out f);
		// particles[i].Force      -= f;
		// particles[nIdx].Force   += f;
		//
		//                     //  viscosity
		//                     //  f = particles[nIdx].Mass * ((particles[nIdx].Velocity - particles[i].Velocity) / particles[nIdx].Density) * WViscosityLap(ref dist) * Constants.VISC0SITY;
		// scalar   = particles[nIdx].Mass * this.SKViscosity.CalculateLaplacian(ref dist) * this.Viscosity * 1 / particles[nIdx].Density;
		// f        = particles[nIdx].Velocity - particles[i].Velocity;
		// Vector2.Mult(ref f, scalar, out f);
		// particles[i].Force      += f;
		// particles[nIdx].Force   -= f;
		// }
		// }
		// }
		// }
		}

		private function CheckParticleDistance() : void {
			//var minDist : Number = 0.5 * m_kernelSize;
			//var minDistSq : Number = minDist * minDist;
			var distX : Number;
			var distY : Number;
			var distSqrd : Number;
			var particle : Particle = particles;
			while (particle) {
				var particle2 : Particle = particle.next;
				while (particle2) {
					
					distX = particle.pos.x - particle2.pos.x;
					distY = particle.pos.y - particle2.pos.y;
					distSqrd = distX * distX + distY * distY;
					var minDist:Number = (particle.radius + particle2.radius) * 0.5;
					var minDistSq : Number = minDist * minDist;
					if (distSqrd < minDistSq) {
//					if (distSqrd < (dQ*dQ)) {
						if (distSqrd > 0.0000001) {
							var distLen : Number = Math.sqrt(distSqrd);
							distX *= 0.4 * ((distLen - minDist) / distLen);
							distY *= 0.4 * ((distLen - minDist) / distLen);

							particle2.pos.x += distX;
							particle2.pos.y += distY;
							if (correctV) {
								particle2.prevPos.x += distX;
								particle2.prevPos.y += distY;
							}
							particle.pos.x -= distX;
							particle.pos.y -= distY;
							if (correctV) {
								particle.prevPos.x -= distX;
								particle.prevPos.y -= distY;
							}
							
						} else {
							var diff:Number = 0.5 * minDist;
							particle2.pos.y += diff;
							//particle2.prevPos.y += diff;
							particle.pos.y -= diff;
							//particle.prevPos.y -= diff;
						}
					}
					particle2 = particle2.next;
				}
				particle = particle.next;
				
			}
			// float minDist = 0.5f * CellSpace;
			// float minDistSq = minDist * minDist;
			// Vector2 dist;
			// for (int i = 0; i < particles.Count; i++)
			// {
			// foreach (var nIdx in grid.GetNeighbourIndex(particles[i]))
			// {
			// Vector2.Sub(ref particles[nIdx].Position, ref particles[i].Position, out dist);
			// float distLenSq = dist.LengthSquared;
			// if (distLenSq < minDistSq)
			// {
			// if (distLenSq > Constants.FLOAT_EPSILON)
			// {
			// float distLen = (float)Math.Sqrt((double)distLenSq);
			// Vector2.Mult(ref dist, 0.5f * (distLen - minDist) / distLen, out dist);
			// Vector2.Sub(ref particles[nIdx].Position, ref dist, out particles[nIdx].Position);
			// Vector2.Sub(ref particles[nIdx].PositionOld, ref dist, out particles[nIdx].PositionOld);
			// Vector2.Add(ref particles[i].Position, ref dist, out particles[i].Position);
			// Vector2.Add(ref particles[i].PositionOld, ref dist, out particles[i].PositionOld);
			// }
			// else
			// {
			// float diff = 0.5f * minDist;
			// particles[nIdx].Position.Y       -= diff;
			// particles[nIdx].PositionOld.Y    -= diff;
			// particles[i].Position.Y          += diff;
			// particles[i].PositionOld.Y       += diff;
			// }
			// }
			// }
			// }
		}

		override public function update(engineForceGenerators : Vector.<IForceGenerator>) : void {
			CalculatePressureAndDensities();
			CalculateForces();
			super.update(engineForceGenerators);
			//CheckParticleDistance();
			minDistForce.applyForce(particles);
		}
	}
}
