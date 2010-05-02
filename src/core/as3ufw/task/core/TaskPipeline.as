package as3ufw.task.core {

	/**
	 * @author Richard.Jewson
	 */
	public class TaskPipeline {
		
		public var resultSet:Object;
		
		public var newtasks:Array;
		
		public var completeCount:int;
		
		public function TaskPipeline() {
			resultSet = {};
			newtasks = [];
		}

		public function clearNewTasks() : void {
			newtasks = [];
		}
	}
}