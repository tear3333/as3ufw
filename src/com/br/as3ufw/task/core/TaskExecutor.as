package com.br.as3ufw.task.core {
	import com.br.as3ufw.logging.ILogger;
	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.task.ITaskCancelable;
	import com.br.as3ufw.task.ITaskExecutor;
	import com.br.as3ufw.task.ITaskPausable;
	import com.br.as3ufw.task.ITaskRunnable;
	import com.br.as3ufw.task.enum.TaskState;
	import com.br.as3ufw.task.events.TaskEvent;

	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/** 
	 * @author Richard.Jewson
	 */
	public class TaskExecutor extends EventDispatcher implements ITaskExecutor {

		private var _task : ITaskRunnable;

		private var _state : String;
		private var _totalRunningTime : int;
		private var _runningTimeCounter : int;
		private var _timer : Timer;
		private var _pcentComplete : Number;
		private var _priority : Number;

		protected var _taskPipeline : TaskPipeline;
		private var _isCancelable : Boolean;
		private var _isPausable : Boolean;

		private var _id : int;
		private static var _nextId : int = 0;

		public function TaskExecutor( _task : ITaskRunnable ) {
			this._task = _task;
			this._task.executor = this;
			this._isCancelable = _task is ITaskCancelable;
			this._isPausable = _task is ITaskPausable;
			this._priority = 10;
			_state = TaskState.INACTIVE;
			_id = _nextId++;
		}

		public function start( taskPipeline : TaskPipeline = null ) : Boolean {
			if (_state != TaskState.INACTIVE) {
				return false;
			}
			_state = TaskState.ACTIVE;
			_pcentComplete = Number.NaN;
			this._taskPipeline = taskPipeline == null ? new TaskPipeline() : taskPipeline;
			startTimer();
			_task.onStart();
			dispatchEvent(new TaskEvent(TaskEvent.START, this));
			return true;
		}

		public function complete() : Boolean {
			if (_state != TaskState.ACTIVE) {
				return false;
			}
			_state = TaskState.FINISHED;			
			stopTimer();
			_task.onComplete();
			dispatchEvent(new TaskEvent(TaskEvent.COMPLETE, this));
			return true;
		}

		public function error(errorMsg : String) : void {
		}

		public function update(pcentComplete : Number) : void {
		}

		public function destroy() : void {
			if (_task) _task.executor = null;
		}		

		public function pause() : Boolean {
			return false;
		}

		public function resume() : Boolean {
			return false;
		}

		public function cancel() : Boolean {
			if (!isCancelable)
				return false;
			ITaskCancelable(_task).onCancel();
			return true;
		}

		virtual public function exec(fn : Function, execCtx : Boolean, args : Array) : void {
			execCtx ? fn.apply(this, args) : fn.apply(_task, args);
		}

		public function get id() : int {
			return _id;
		}

		public function get state() : String {
			return _state;
		}

		public function get task() : ITaskRunnable {
			return _task;
		}

		public function get runningTime() : int {
			return _totalRunningTime;
		}

		private function startTimer() : void {
			stopTimer();
			_totalRunningTime = 0;
			_runningTimeCounter = getTimer();
			if (isCancelable && ITaskCancelable(_task).timeOut > 0) {
				_timer = new Timer(ITaskCancelable(_task).timeOut, 1);
				_timer.addEventListener(TimerEvent.TIMER, onTimeOutEvent);
				_timer.start();
			}
		}

		private function stopTimer() : void {
			_totalRunningTime += getTimer() - _runningTimeCounter;
			if (_timer) {
				_timer.removeEventListener(TimerEvent.TIMER, onTimeOutEvent);
				_timer.reset();
				_timer = null;
			}
		}

		private function onTimeOutEvent(e : TimerEvent) : void {
			_state = TaskState.FINISHED;
			stopTimer();
			ITaskCancelable(_task).onTimeOut();
			dispatchEvent(new TaskEvent(TaskEvent.ERROR, this));
			//_log.warn(this + " timed out after " + totalRunningTime + "ms (timeout=" + _timeOut + ")");
		}

		public function get taskPipeline() : TaskPipeline {
			return _taskPipeline;
		}		

		virtual public function get isCancelable() : Boolean {
			return _isCancelable;
		}

		virtual public function get isPausable() : Boolean {
			return _isPausable;
		}

		public function get priority() : Number {
			return _priority;
		}
		
		public function set priority(priority : Number) : void {
			_priority = priority;
			dispatchEvent(new TaskEvent(TaskEvent.PRIORITIZE, this));
		}

		override public function toString() : String {
			return super.toString();
		}

		private var _log : ILogger = Log.getClassLogger(TaskExecutor);

	}
}
