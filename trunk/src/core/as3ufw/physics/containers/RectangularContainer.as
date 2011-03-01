package as3ufw.physics.containers {
	import as3ufw.physics.Particle;
	import flash.geom.Rectangle;
	/**
	 * @author richard.jewson
	 */
	public class RectangularContainer {
		
		private var rect : Rectangle;
		private var l : Number;
		private var r : Number;
		private var t : Number;
		private var b : Number;
		private var threshold : Number;
		private var e : Number = 0.001;

		public function RectangularContainer(rect : Rectangle, threshold : Number) {
			this.rect = rect;
			this.threshold = threshold;
			l = rect.left-threshold;
			r = rect.right+threshold;
			t = rect.top-threshold;
			b = rect.bottom+threshold;
		}

		
		public function resolve(particles:Particle) : void {
			var p:Particle = particles;
			while (p) {
				if (p.pos.x<l) p.pos.x = l+e;
				if (p.pos.x>r) p.pos.x = r-e;
				if (p.pos.y<t) p.pos.y = t+e;
				if (p.pos.y>b) p.pos.y = b-e;
				p = p.next;
			}
		}
	}
}
