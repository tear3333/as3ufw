package as3ufw.physics.modifiers {
	import as3ufw.geom.Vector2D;
	/**
	 * @author richard.jewson
	 */
	public class LineRelativeModifier implements IModifier {

		private var pos1 : Vector2D;
		private var pos2 : Vector2D;

		private var vectors : Vector.<LineRelativeVectorProxy>;

		public function LineRelativeModifier(pos1 : Vector2D, pos2 : Vector2D) {
			this.pos1 = pos1;
			this.pos2 = pos2;
			vectors = new Vector.<LineRelativeVectorProxy>();
		}

		public function addVector(v:Vector2D, pcentLengthOffset : Number, lateralOffset : Number) : void {
			vectors.push(new LineRelativeVectorProxy(v, pcentLengthOffset, lateralOffset));
		}
		
		public function update() : void {
			for each (var vProxy : LineRelativeVectorProxy in vectors) {
				var lenOffset:Vector2D = pos1.interp(vProxy.pcentLengthOffset,pos2);
				var latOffset:Vector2D = lenOffset.rightHandNormal().normalize().mult(vProxy.lateralOffset);
				vProxy.v.copy(lenOffset.plus(latOffset));
			}
		}
	}
}
import as3ufw.geom.Vector2D;

class LineRelativeVectorProxy {
	
	public var v : Vector2D;
	public var pcentLengthOffset : Number;
	public var lateralOffset : Number;

	public function LineRelativeVectorProxy(v : Vector2D, pcentLengthOffset : Number, lateralOffset : Number) {
		this.v = v;
		this.pcentLengthOffset = pcentLengthOffset;
		this.lateralOffset = lateralOffset;
	}

}