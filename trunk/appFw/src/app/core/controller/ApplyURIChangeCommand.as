package app.core.controller {	import app.events.URIEvent;	import org.robotlegs.mvcs.Command;	public class ApplyURIChangeCommand extends Command {		[Inject] 		public var event : URIEvent;		override public function execute() : void {			log('URI changed to: ' + event.uri);		}	}}