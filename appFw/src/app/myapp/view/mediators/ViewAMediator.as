package app.myapp.view.mediators {
	import app.myapp.view.ViewA;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Richard.Jewson
	 */
	public class ViewAMediator extends Mediator {
		
		[Inject] 
		public var viewA : ViewA;		
		
		public function ViewAMediator() {
		}
		
		override public function onRegister() : void {
			log("Implement View mediator");
			viewA.initialize();
		}
		
	}
}
