package taskTestSuite.tests {
	import org.flexunit.asserts.assertEquals;
	import com.br.as3ufw.utils.ObjectUtils;
	import com.br.as3ufw.logging.ILogger;
	import com.br.as3ufw.logging.Log;
	import taskTestSuite.support.TestTask;
	import com.br.as3ufw.task.events.TaskEvent;
	import com.br.as3ufw.task.manager.ConcurrentTaskManager;

	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	

	/**
	 * @author Richard.Jewson
	 */
	public class TestCase1 {

		private var concurrentMgr:ConcurrentTaskManager;
		private var expectedResults : Array;

		[Before]
		public function setUp():void {
			concurrentMgr = new ConcurrentTaskManager();
			
			concurrentMgr.addTask( new TestTask("1", 20) );
			//concurrentMgr.addTask( new TestTask("2", 20) );
			//concurrentMgr.addTask( new TestTask("3", 20) );
			
			expectedResults = ["S1","C1","S2","C2","S3","C3"];
		}

		[After]
		public function tearDown():void {
			concurrentMgr.cancel();
			concurrentMgr = null;
		}

		[Test(async, description="Simple sync run")]
		public function syncRun() : void {
			var asyncHandler:Function = Async.asyncHandler( this, handleComplete, 500, null, handleTimeout );
			concurrentMgr.addEventListener(TaskEvent.COMPLETE, asyncHandler, false, 0, true);
          	concurrentMgr.start();
		}
		
		protected function handleComplete( event:TaskEvent, passThroughData:Object ):void {
			compareResults(concurrentMgr.taskPipeline.resultSet["testResultList"],expectedResults);
		}
 
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");	
		}
		
		protected function compareResults(actual:Array, expected:Array):void {
			for (var i : int = 0; i < actual.length; i++) {
				if (i==expected.length) {
					Assert.fail( "Actual output was shorter than Expected");
				} else {
					var a:String = actual[i];
					var b:String = expected[i];
					log.info(a + "=" + b );
					
					if (a!==b)
						Assert.fail( "Actual output did not match Expected output item");
				}
			}
			Assert.assertEquals();
		}
	
		protected static var log:ILogger = Log.getClassLogger(TestCase1);
		
	}
}
