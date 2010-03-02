package com.br.as3ufw.task.test.tasks {
	import com.br.as3ufw.logging.ILogger;
	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.task.ITaskExecutor;
	import com.br.as3ufw.task.ITaskRunnable;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Richard.Jewson
	 */
	public class TestTask implements ITaskRunnable {
		
		private var _exec:ITaskExecutor;
		
		private var _dummyTimer : Timer;
		private var _id : String;

		public function TestTask(id:String) {
			this._id = id;
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
			_exec.resultSet[_id] = "...done";
		}
		
		public function set executor(executor : ITaskExecutor) : void {
			this._exec = executor;
		}
		
		public function toString() : String {
			return "ID=[" + _id + "]";
		}
		
		private var _log : ILogger = Log.getClassLogger(TestTask);
	}
}