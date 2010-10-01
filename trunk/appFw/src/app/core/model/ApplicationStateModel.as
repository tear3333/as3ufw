package app.core.model {
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Richard.Jewson
	 */
	public class ApplicationStateModel extends Actor {

		public static const STATE_PRELOADING : String = "statePreloading";
		public static const STATE_READY : String = "stateReady";

		private var _state : String = STATE_PRELOADING;

		public function ApplicationStateModel() {
		}

		public function getState() : String {
			return _state;
		}
	}
}
