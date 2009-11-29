package com.br.as3ufw.task.test.tasks {
	import com.br.as3ufw.task.ITaskCancelable;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.logging.ILogger;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.br.as3ufw.task.ITaskExecutor;
	import com.br.as3ufw.task.ITaskRunnable;
	/**
	 * @author Richard.Jewson
	 */
	public class CancelableTestTask implements ITaskRunnable, ITaskCancelable {
		
		private var _exec:ITaskExecutor;
		
		private var _dummyTimer : Timer;
		private var _id : String;
		private var _timeout : int;

		public function CancelableTestTask(id:String, timeout:int = 0) {
			this._id = id;
			_timeout = timeout;
		}

		public function onStart() : void {
			_dummyTimer = new Timer(500 + Math.random() * 3000, 1);
			_dummyTimer.addEventListener(TimerEvent.TIMER, function(e : Event):void {
				_exec.complete();
			});
			_dummyTimer.start();
			_log.info(this + " starting...");			
		}
		
		public function onComplete() : void {
			_log.info(this + " complete ( "+_exec.runningTime+" ms)");
		}
		
		public function set executor(executor : ITaskExecutor) : void {
			this._exec = executor;
		}
		
		/*
		 * ITaskCancelable
		 */
		
		public function onCancel() : void {
			_log.info(this + " canceled.");
		}
		
		public function onTimeOut() : void {
			_log.info(this + " timed out...");
			_exec.cancel();
		}
		
		public function get timeOut() : int {
			return _timeout;
		}
		
		public function toString() : String {
			return "ID=[" + _id + "]";
		}
		
		private var _log : ILogger = LoggerFactory.getClassLogger(CancelableTestTask);
	
	}
}