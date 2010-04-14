package as3ufw.task.events {
	import as3ufw.task.ITaskExecutor;
	import as3ufw.task.core.TaskExecutor;
	import as3ufw.task.ITaskRunnable;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class TaskEvent extends Event {
		public static const START : String = "start";
		public static const COMPLETE : String = "complete";
		public static const PAUSE : String = "pause";
		public static const RESUME : String = "resume";
		public static const CANCEL : String = "cancel";
		public static const ERROR : String = "error";
		public static const PRIORITIZE : String = "prioritize";		

		private var _taskExecutor:ITaskExecutor;

		public function TaskEvent(type : String,taskExecutor:ITaskExecutor) {
			super(type);
			this.task = task;
		}
		
		public function get task() : ITaskExecutor {
			return _taskExecutor;
		}
		
		public function set task(task : ITaskExecutor) : void {
			_taskExecutor = task;
		}	
	}
}
