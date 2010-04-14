package as3ufw.task.manager {
	import as3ufw.task.ITaskExecutor;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.task.ITaskRunnable;
	import as3ufw.task.core.TaskExecutor;
	import as3ufw.task.core.TaskManagerExecutor;
	import as3ufw.task.enum.TaskState;

	/**
	 * @author Richard.Jewson
	 */
	public class ConcurrentTaskManager extends TaskManagerExecutor {

		private var _concurrency : int;
		private var _runningCount : int;
		
		public function ConcurrentTaskManager(concurrency:int = 10) {
			this._concurrency = concurrency;
			_runningCount = 0;
		}

		override public function onStart() : void {
			startConcurrentTasks();
		}

		override public function onSubTaskComplete(task : ITaskExecutor) : void {
			_runningCount--;
			if (startConcurrentTasks()) complete();
		}
		
		private function startConcurrentTasks() : Boolean {
			//First, sort all the tasks
			//TODO This could be optimized
//			executors.sort(sortByPriority);
			
			var finished:Boolean = true;
			for each (var executor:TaskExecutor in executors) {
				if (!canStartTasks) return false;
				if (executor.start(taskPipeline)) _runningCount++ ;
				finished = finished && (executor.state == TaskState.FINISHED);
				//_log.info("e[" + executor.id+ "]finshed="+finished);
			}
			return finished;
		}

		override protected function onAddTask(task : ITaskRunnable) : void {
			super.onAddTask(task);
			_log.info("Task ["+task+"] added.");
			//TODO sort this out
			if (state == TaskState.ACTIVE) {
			} else if (state == TaskState.PAUSED) {
			}
		}

		override public function onComplete() : void {
			//_log.info(this + " complete (" + totalRunningTime + " ms)");
		}
		
		private function get canStartTasks():Boolean {
			return !((_runningCount>0)&&(_runningCount==_concurrency));
		}
		
		private var _log : ILogger = Log.getClassLogger(ConcurrentTaskManager);
		
	}
}
