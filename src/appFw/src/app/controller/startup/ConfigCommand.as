package app.controller.startup{	import flash.display.Stage;	import org.robotlegs.mvcs.Command;	public class ConfigCommand extends Command	{		/*******************************************************************************************		*								public methods											   *		*******************************************************************************************/		public function ConfigCommand()		{		}		override public function execute() : void		{			zz_init(contextView.stage, '[Change to App name!]');						//creating this mapping here isn't ideal, but it's needed by the SWFAddressService, 			//so we can't create it in the PrepViewCommand			injector.mapValue(Stage, contextView.stage);		}	}}