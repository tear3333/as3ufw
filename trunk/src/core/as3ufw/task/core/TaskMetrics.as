package as3ufw.task.core {

	/**
	 * @author Richard.Jewson
	 */
	public class TaskMetrics {
		
		public var totalCount : int;
		public var completeCount : int;
		public var knownSizeCount : int;
		
		public var totalSize : Number;
		public var completeSize : Number;

		public function TaskMetrics() {
			reset();
		}

		public function reset() : void {
			totalCount = 1;
			completeCount = knownSizeCount = 0;
			totalSize = completeSize = 0;
		}

		public function add( metrics:TaskMetrics ) : void {
			totalCount += metrics.totalCount;
			completeCount += metrics.completeCount;
			knownSizeCount += metrics.knownSizeCount;
			totalSize += metrics.totalSize;
			completeSize += metrics.completeSize;
		}
		
		public function get pcentSizeComplete():Number {
			return completeSize/totalSize;
		}

		public function get pcentCountComplete():Number {
			return completeCount/totalCount;
		}
		
		public function toString() : String {
			return completeCount + "/" + totalCount + "(" + knownSizeCount + ") = " + Math.round(pcentCountComplete*100) + "% Complete:" + completeSize + "/" + totalSize +  " = " + Math.round(pcentSizeComplete*100) + "%" ;
		}
	}
}
