package as3ufw.physics {
	import flash.display.Graphics;

	/**
	 * @author richard.jewson
	 */
	public class SegmentedSpring extends Spring {
		
		private var realtiveParticles : Vector.<SpringRelativeParticle>;

		public function SegmentedSpring(p1 : Particle, p2 : Particle, stiffness : Number = 0.5) {
			super(p1, p2, stiffness);
			realtiveParticles = new Vector.<SpringRelativeParticle>();
		}

		public function attachParticle(p : SpringRelativeParticle) : void {
			realtiveParticles.push(p);
		}
		
		override public function resolve() : Boolean {
			return super.resolve();
			for each (var p : SpringRelativeParticle in realtiveParticles) {
				p.updatePosition();
			}
		}
		
		override public function render(g : Graphics, colour : uint = 0x000000) : void {
			super.render(g,colour);
			for each (var p : SpringRelativeParticle in realtiveParticles) {
				p.render(g,colour);
			}
		}		
		
	}
}
