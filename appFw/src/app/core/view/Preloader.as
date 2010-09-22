package app.core.view {
	import app.core.events.InitialDataServiceEvent;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	public class Preloader extends MovieClip {
		private var m_application : DisplayObject;

		
		public function Preloader() {
			initialize();
		}

		private function initialize() : void {
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ENTER_FRAME, self_enterFrame);
		}

		private function self_enterFrame(event : Event) : void {
			if(framesLoaded == totalFrames) {
				removeEventListener(Event.ENTER_FRAME, self_enterFrame);
				nextFrame();
				startApplication();
			}
		}

		private function startApplication() : void {
			var appClass : Class = Class(getDefinitionByName('app.App'));
			m_application = new appClass();
			addChildAt(m_application, 0);
			m_application.addEventListener(InitialDataServiceEvent.DATA_LOADED, initialData_complete);
			log('Change app name here!');
			log('The preloader won\'t be hidden until the DATA_LOADED event takes at least one frame to be fired');
		}

		private function initialData_complete(event : InitialDataServiceEvent) : void {
			log('i Initial data loaded. Hide the preloader!');
		}
	}
}