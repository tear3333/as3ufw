package as3ufw.physics {
	import flash.display.Graphics;

	/**
	 * @author richard.jewson
	 */
	public class RelativeParticleGroup {

		public var p1 : Particle;
		public var p2 : Particle;
		public var realtiveParticles : Vector.<RelativeParticle>;

		public function RelativeParticleGroup(p1 : Particle, p2 : Particle) {
			this.p2 = p2;
			this.p1 = p1;
			realtiveParticles = new Vector.<RelativeParticle>();
		}

		public function attachParticle(p : RelativeParticle) : void {
			realtiveParticles.push(p);
			p.group = this;
		}
		
		public function resolve() : void {
			for each (var p : RelativeParticle in realtiveParticles) {
				p.updatePosition();
			}
		}
		
		public function render(g : Graphics, colour : uint = 0x000000) : void {
			for each (var p : RelativeParticle in realtiveParticles) {
				p.render(g,colour);
			}
		}		
		
	}
}
