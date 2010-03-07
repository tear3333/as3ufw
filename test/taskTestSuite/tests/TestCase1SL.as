package taskTestSuite.tests {
	import com.br.as3ufw.task.manager.OrderedTaskManager;
	import taskTestSuite.support.TestTask;

	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.logging.appenders.TraceAppender;
	import com.br.as3ufw.task.manager.ConcurrentTaskManager;

	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class TestCase1SL extends Sprite {

		public var orderedMgr:OrderedTaskManager;
		public var expectedResults : Array;

		public function TestCase1SL() {
			var traceAppender:TraceAppender = new TraceAppender();
			Log.addApender(traceAppender);

			orderedMgr = new OrderedTaskManager();
			
			orderedMgr.addTask( new TestTask("1", 200) );
			orderedMgr.addTask( new TestTask("2", 200) );
			orderedMgr.addTask( new TestTask("3", 200) );
			
			expectedResults = ["S1","C1","S2","C2","S3","C3"];
			orderedMgr.start();
		}

	}
}
