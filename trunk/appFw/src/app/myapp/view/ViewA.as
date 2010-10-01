package app.myapp.view {
	import app.core.view.components.BaseView;

	/**
	 * @author Richard.Jewson
	 */
	public class ViewA extends BaseView {
		
		override public function initialize() : void {
			
			with (graphics) {
				beginFill(0x00FF00);
				drawRect(200, 100, 100, 100);
			}
			
		}		
		
	}
}
