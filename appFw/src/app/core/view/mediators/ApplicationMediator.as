package app.core.view.mediators {
	import app.core.view.ApplicationView;

	import org.robotlegs.mvcs.Mediator;

	public class ApplicationMediator extends Mediator {

		[Inject] 
		public var applicationView : ApplicationView;

		
		public function ApplicationMediator() {
			super();
		}

		override public function onRegister() : void {
			log('Implement application mediator');
			applicationView.initialize();
		}
	}
}