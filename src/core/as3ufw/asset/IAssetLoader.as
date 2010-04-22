package as3ufw.asset {
	import as3ufw.task.ITaskCancelable;
	import as3ufw.task.ITaskRunnable;

	/**
	 * @author Richard.Jewson
	 */
	public interface IAssetLoader extends ITaskRunnable, ITaskCancelable {
		function cleanup() : void;

		function get content() : * ;
	}
}
