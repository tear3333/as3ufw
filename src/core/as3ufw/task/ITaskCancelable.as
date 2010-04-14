package as3ufw.task {

	/**
	 * @author Richard.Jewson
	 */
	public interface ITaskCancelable {
		
		function onCancel() : void;

		function onTimeOut() : void;

		function get timeOut() : int;
	}
}
