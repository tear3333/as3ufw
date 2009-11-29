package com.br.as3ufw.task.core {
	import com.br.as3ufw.task.ITaskCancelable;
	import com.br.as3ufw.task.ITaskExecutor;
	import com.br.as3ufw.task.ITaskPausable;
	import com.br.as3ufw.task.ITaskRunnable;
	import com.br.as3ufw.task.enum.TaskState;
	import com.br.as3ufw.task.events.TaskEvent;

	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * @author Richard.Jewson
	 */
	public class TaskManagerExecutor extends TaskExecutor implements ITaskRunnable, ITaskCancelable, ITaskPausable {

		private var _executors : Array;

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
			//_isCancelable 	= _isCancelable && executor._isCancelable;
			//_isPausable 	= _isPausable   && executor._isPausable;

			executor.addEventListener(TaskEvent.COMPLETE, function(event : TaskEvent):void {
				onSubTaskComplete(event.task);
			});
			executor.addEventListener(TaskEvent.CANCEL, function(event : TaskEvent):void {
				onSubTaskCancel(event.task);
			});
			executor.addEventListener(TaskEvent.ERROR, function(event : TaskEvent):void {
				onSubTaskError(event.task);
			});
			
			onAddTask(task);
			return true;
		}

		virtual protected function onAddTask(task : ITaskRunnable) : void {
		}

		virtual public function removeTask(task : ITaskRunnable) : Boolean {
			return true;
		}

		virtual protected function onRemoveTask(task : ITaskRunnable) : void {
		}

		/**
		 * Subtask event handlers
		 */
		virtual public function onSubTaskComplete(task : ITaskRunnable) : void {
		}

		virtual public function onSubTaskCancel(task : ITaskRunnable) : void {
		}

		virtual public function onSubTaskError(task : ITaskRunnable) : void {
		}

		/*
		 * ITaskRunnable methods
		 */
		virtual public function onStart() : void {
		}

		virtual public function onComplete() : void {
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
			return false;
		}

		/*
		 * Getter/Setter stuff
		 */
		
		override public function get isCancelable() : Boolean {
			for each (var executor:TaskExecutor in executors) {
				if (!executor.isCancelable) return false;
			}
			return true;
		}
		
		override public function get isPausable() : Boolean {
			for each (var executor:TaskExecutor in executors) {
				if (!executor.isPausable) return false;
			}
			return true;
		}
		
		public function get executors() : Array {
			return _executors;
		}
		
		private var _log : ILogger = LoggerFactory.getClassLogger(TaskManagerExecutor);
		
	}
}
