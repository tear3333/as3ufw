package as3ufw.task.manager {
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;

	/**
	 * @author Richard.Jewson
	 */
	public class OrderedTaskManager extends ConcurrentTaskManager {

		public function OrderedTaskManager() {
			super(1);
		}

		private var _log : ILogger = Log.getClassLogger(OrderedTaskManager);
	}
}