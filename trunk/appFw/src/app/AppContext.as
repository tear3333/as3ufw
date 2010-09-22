package app {
	import app.core.controller.startup.ConfigCommand;
	import app.core.controller.startup.PrepControllerCommand;
	import app.core.controller.startup.PrepModelCommand;
	import app.core.controller.startup.PrepServicesCommand;
	import app.core.controller.startup.PrepViewCommand;
	import app.core.controller.startup.StartupCommand;
	import app.events.InitialDataServiceEvent;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	public class AppContext extends Context {
		public function AppContext(
			contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void {
			//app configuration, as close to the application entry as possible
			commandMap.mapEvent(ContextEvent.STARTUP, ConfigCommand, ContextEvent, true);

			commandMap.mapEvent(ContextEvent.STARTUP, PrepModelCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, PrepControllerCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, PrepServicesCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, PrepViewCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);

			eventDispatcher.addEventListener(InitialDataServiceEvent.DATA_LOADED, initialData_loaded);
			
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}

		
		/**
		 * Used to inform the preloader about successful data load
		 * @param event
		 */
		private function initialData_loaded(event : InitialDataServiceEvent) : void {
			eventDispatcher.removeEventListener(InitialDataServiceEvent.DATA_LOADED, initialData_loaded);
			contextView.dispatchEvent(event);
		}
	}
}