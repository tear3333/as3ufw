package as3ufw.physics {
	import flash.display.Graphics;
	import as3ufw.geom.Vector2D;

	/**
	 * @author richard.jewson
	 */
	public class SpringRelativeParticle extends Particle {
		
		public var pcentLengthOffset : Number;
		public var lateralOffset : Number;
		private var parent : Spring;

		public function SpringRelativeParticle(parent : Spring, pcentLengthOffset : Number, lateralOffset : Number) {
			super(new Vector2D());
			this.parent = parent;
			this.pcentLengthOffset = pcentLengthOffset;
			this.lateralOffset = lateralOffset;
			fixed = true;
			mass = Number.POSITIVE_INFINITY;
		}
		
		public function updatePosition():void {
			var lenOffset:Vector2D = parent.p1.pos.interp(pcentLengthOffset,parent.p2.pos);
			var latOffset:Vector2D = lenOffset.rightHandNormal().normalize().mult(lateralOffset);
			setStaticPosition(lenOffset.plus(latOffset));
		}

	}
}
