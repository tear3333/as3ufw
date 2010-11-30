package as3ufw.physics {
	import flash.display.Graphics;
	import as3ufw.geom.Vector2D;

	/**
	 * @author richard.jewson
	 */
	public class RelativeParticle extends Particle {
		
		public var pcentLengthOffset : Number;
		public var lateralOffset : Number;
		public var group : RelativeParticleGroup;

		public function RelativeParticle(pcentLengthOffset : Number, lateralOffset : Number) {
			super(new Vector2D());
			this.pcentLengthOffset = pcentLengthOffset;
			this.lateralOffset = lateralOffset;
			fixed = true;
			mass = Number.POSITIVE_INFINITY;
		}
		
		public function updatePosition():void {
			if (!group) return;
			var lenOffset:Vector2D = group.p1.pos.interp(pcentLengthOffset,group.p2.pos);
			var latOffset:Vector2D = group.p1.pos.minus(group.p2.pos).normalize().leftHandNormal().mult(lateralOffset);
			setStaticPosition(lenOffset.plus(latOffset));
		}

	}
}
