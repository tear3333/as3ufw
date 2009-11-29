package com.br.as3ufw.task.test.tasks {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.br.as3ufw.task.ITaskExecutor;
	import com.br.as3ufw.task.ITaskRunnable;

	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

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
		}
		
		public function set executor(executor : ITaskExecutor) : void {
			this._exec = executor;
		}
		
		public function toString() : String {
			return "ID=[" + _id + "]";
		}
		
		private var _log : ILogger = LoggerFactory.getClassLogger(TestTask);
	}
}
