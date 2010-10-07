package app.core.controller.startup {	import as3ufw.logging.appenders.SOSAppender;	import as3ufw.logging.Log;	import as3ufw.logging.appenders.TraceAppender;	import org.robotlegs.mvcs.Command;	import flash.display.Stage;	/**	 * This is where the application should be configured.	 */	public class ConfigCommand extends Command {		public function ConfigCommand() {		}		/**		 * Dont do anything before this function executes, its where everything (including logging)		 * is setup		 */		override public function execute() : void {			Log.useClass = true;			Log.addClassFilters( /^app.core.view/ , /controller/ );			Log.addApender(new TraceAppender());			Log.addApender(new SOSAppender());			log("Configure the application");			log("[debug]Another way of logging...",0,this,1,2);						//creating this mapping here isn't ideal, but it's needed by the SWFAddressService, 			//so we can't create it in the PrepViewCommand			injector.mapValue(Stage, contextView.stage);		}	}}