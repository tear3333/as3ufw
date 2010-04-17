package as3ufw.task.events {
	import as3ufw.task.ITaskExecutor;

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
		public static const UPDATE : String = "update";		

		private var _taskExecutor : ITaskExecutor;

		public function TaskEvent(type : String,taskExecutor : ITaskExecutor) {
			super(type);
			_taskExecutor = taskExecutor;
		}

		public function get taskExecutor() : ITaskExecutor {
			return _taskExecutor;
		}

		public function set taskExecutor(taskExecutor : ITaskExecutor) : void {
			_taskExecutor = taskExecutor;
		}	
		
		override public function clone() : Event {
			trace("clone");
			return new TaskEvent(type,_taskExecutor);
		}
	}
}
