package app.controller.startup{	import app.events.InitialDataServiceEvent;	import org.robotlegs.mvcs.Command;	public class ApplyInitialDataCommand extends Command	{		[Inject] public var event : InitialDataServiceEvent;				public function ApplyInitialDataCommand()		{		}		override public function execute() : void		{			log('Setup initial data service');		}	}}