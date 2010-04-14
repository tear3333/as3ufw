package taskTestSuite.support {
	import as3ufw.task.ITaskCancelable;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.task.ITaskExecutor;
	import as3ufw.task.ITaskRunnable;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Richard.Jewson
	 */
	public class TestTask implements ITaskRunnable, ITaskCancelable {

		private var _exec : ITaskExecutor;

		private var _dummyTimer : Timer;
		private var _id : String;
		private var _time : int;

		public function TestTask(id : String, time:int) {
			this._id = id;
			this._time = time;
			_dummyTimer = new Timer(_time, 1);
			_dummyTimer.addEventListener(TimerEvent.TIMER, onTimer,false,0,true);
		}
		
		public function onTimer(e:Event) : void {
			_exec.complete();		
		}

		public function onStart() : void {
			_dummyTimer.start();
			_log.info(this + " starting...");
			storeResult("S");		
		}

		public function onComplete() : void {
			_log.info(this + " complete ( " + _exec.runningTime + " ms)");
			storeResult("C");
		}

		
		public function onCancel() : void {
			_dummyTimer.stop();
			_log.info(this + " canceled...");
			storeResult("CX");
		}
		
		public function onTimeOut() : void {
			_log.info(this + " timed out...");
			storeResult("TO");
		}
		
		public function get timeOut() : int {
			return 0;
		}

		public function set executor(executor : ITaskExecutor) : void {
			this._exec = executor;
		}

		private function storeResult(prefix:String):void {
			if (!_exec.taskPipeline.resultSet.hasOwnProperty("testResultList")) {
				_exec.taskPipeline.resultSet["testResultList"] = [];
			}
			_exec.taskPipeline.resultSet["testResultList"].push(prefix+_exec.id);			
		}

		public function toString() : String {
			return "ID=[" + _id + "]";
		}

		private var _log : ILogger = Log.getClassLogger(TestTask);

	}
}
