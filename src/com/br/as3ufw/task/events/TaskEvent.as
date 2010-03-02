package com.br.as3ufw.task.events {
	import com.br.as3ufw.task.ITaskRunnable;
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

		private var _task:ITaskRunnable;

		public function TaskEvent(type : String,task:ITaskRunnable) {
			super(type);
			this.task = task;
		}
		
		public function get task() : ITaskRunnable {
			return _task;
		}
		
		public function set task(task : ITaskRunnable) : void {
			_task = task;
		}	
	}
}
