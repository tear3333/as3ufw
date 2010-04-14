package as3ufw.ui {

	/**
	 * @author Richard.Jewson
	 */
	public class Border {
		public var top : Number;
		public var bottom : Number;
		public var left : Number;
		public var right : Number;

		public function Border(top : Number = 0, right : Number = 0, bottom : Number = 0, left : Number = 0) {
			this.top = top;
			this.right = right;
			this.bottom = bottom;
			this.left = left;
		}
	}
}
