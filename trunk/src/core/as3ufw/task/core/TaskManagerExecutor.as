package as3ufw.task.core {
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.task.ITaskCancelable;
	import as3ufw.task.ITaskExecutor;
	import as3ufw.task.ITaskPausable;
	import as3ufw.task.ITaskRunnable;
	import as3ufw.task.enum.TaskState;
	import as3ufw.task.events.TaskEvent;

	/**
	 * @author Richard.Jewson
	 */
	public class TaskManagerExecutor extends TaskExecutor implements ITaskRunnable, ITaskCancelable, ITaskPausable {

		private var _executors : Array;

		private var updateInterval:int;

		public function TaskManagerExecutor() {
			super(this);
			_executors = [];
		}

		virtual public function addTask(task : ITaskRunnable) : Boolean {
			if (state == TaskState.FINISHED) {
				//_log.warn("Cannot add task " + task + " to a finished manager.");
				return false;
			}
			var executor : TaskExecutor = new TaskExecutor(task);
			_executors.push(executor);

			executor.addEventListener(TaskEvent.COMPLETE,	taskComplete	,false,0,false);
			executor.addEventListener(TaskEvent.CANCEL,		taskCanceled	,false,0,false);
			executor.addEventListener(TaskEvent.ERROR,		taskError		,false,0,false);
			executor.addEventListener(TaskEvent.PRIORITIZE, taskPrioritize	,false,0,false);
			executor.addEventListener(TaskEvent.UPDATE, 	taskUpdated		,false,0,false);
			
			onAddTask(task);
			return true;
			
			function taskComplete(event : TaskEvent):void {
				onSubTaskComplete(event.taskExecutor);
			}
			function taskCanceled(event : TaskEvent):void {
				onSubTaskCancel(event.taskExecutor);
			}
			function taskError(event : TaskEvent):void {
				onSubTaskError(event.taskExecutor);
			}
			function taskPrioritize(event : TaskEvent):void {
				onSubTaskPrioritize(event.taskExecutor);
			}
			function taskUpdated(event : TaskEvent):void {
				onSubTaskUpdated(event.taskExecutor);
			}
		}

		virtual protected function onAddTask(task : ITaskRunnable) : void {
			task.onAdded();
		}

		virtual public function removeTask(task : ITaskRunnable) : Boolean {
			return true;
		}

		virtual protected function onRemoveTask(task : ITaskRunnable) : void {
		}

		/**
		 * Subtask event handlers
		 */
		virtual public function onSubTaskComplete(task : ITaskExecutor) : void {
			for each (var newtask : ITaskRunnable in task.taskPipeline.newtasks) {
				addTask(newtask);
			}
			dispatchEvent(new TaskEvent(TaskEvent.UPDATE, this));
		}

		virtual public function onSubTaskCancel(task : ITaskExecutor) : void {
		}

		virtual public function onSubTaskError(task : ITaskExecutor) : void {
		}

		virtual public function onSubTaskPrioritize(task : ITaskExecutor) : void {
		}

		virtual public function onSubTaskUpdated(task : ITaskExecutor) : void {
			dispatchEvent(new TaskEvent(TaskEvent.UPDATE, this));
		}

		/*
		 * ITaskRunnable methods
		 */
		virtual public function onAdded() : void {
		}

		virtual public function onStart() : void {
		}

		virtual public function onComplete() : void {
			dispatchEvent(new TaskEvent(TaskEvent.UPDATE, this));
		}

		//No need to implement, we already are an executor
		virtual public function set executor(executor : ITaskExecutor) : void {
		}

		/*
		 * ITaskCancelable methods
		 */
		virtual public function onCancel() : void {
		}

		virtual public function onTimeOut() : void {
		}

		virtual public function get timeOut() : int {
			return 0;
		}

		/*
		 * ITaskPausable methods
		 */
		virtual public function onPause() : void {
		}

		virtual public function onResume() : void {
		}
	
		override public function exec(fn : Function, execCtx:Boolean, args:Array) : void {
			for each (var executor:TaskExecutor in executors)
				executor.exec(fn, execCtx, args);
		}	
		
		/*
		 * Overriden stuff
		 */

		override public function cancel() : Boolean {
			if (!super.cancel())
				return false;
			//TODO implement
			for each (var executor:TaskExecutor in executors)
				executor.cancel();
			return false;
		}

		override public function update(pcentComplete : Number) : void {
			_log.error("You cannot call update on a Manager");
		}

		public function get executors() : Array {
			return _executors;
		}
		
		protected function sortByPriority(a : TaskExecutor, b : TaskExecutor) : Number {
			var diff : Number = a.priority - b.priority;
			if( diff > 0) {
				return 1;
			} else if(diff < 0) {
				return -1;
			}
    
			return 0;
		}

		override public function get metrics() : TaskMetrics {
			_metrics.reset();
			for each (var executor:TaskExecutor in executors)
				_metrics.add(executor.metrics);
			if (state == TaskState.FINISHED)
				_metrics.completeCount += 1;
			return _metrics;
		}

		
		override public function set totalSize(size : Number) : void {
			_log.error("You cannot set the totalSize on a Manager");
		}

		override public function set completeSize(size : Number) : void {
			_log.error("You cannot set the completeSize on a Manager");
		}

		private var _log : ILogger = Log.getClassLogger(TaskManagerExecutor);
		
	}
}
