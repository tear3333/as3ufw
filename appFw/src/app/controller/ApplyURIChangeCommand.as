package app.controller{	import app.events.URIEvent;	import org.robotlegs.mvcs.Command;	public class ApplyURIChangeCommand extends Command	{		/*******************************************************************************************		*								public properties										   *		*******************************************************************************************/		[Inject] public var event : URIEvent;				/*******************************************************************************************		*								public methods											   *		*******************************************************************************************/		override public function execute() : void		{			log('i URI changed to: ' + event.uri);		}	}}