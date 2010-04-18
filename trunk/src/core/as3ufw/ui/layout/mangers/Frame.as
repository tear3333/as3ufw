package as3ufw.ui.layout.mangers {

	/**
	 * @author Richard.Jewson
	 */
	public class Frame {
		public var top : Number;
		public var bottom : Number;
		public var left : Number;
		public var right : Number;

		public function Frame(top : Number = 0, right : Number = 0, bottom : Number = 0, left : Number = 0) {
			this.top = top;
			this.right = right;
			this.bottom = bottom;
			this.left = left;
		}
		
		public function set width(width:Number):void {
			top = bottom = left = right = width;
		}
	}
}
