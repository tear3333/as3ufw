package as3ufw.asset {
	import as3ufw.lifecycle.IDestroyable;
	import as3ufw.task.ITaskCancelable;
	import as3ufw.task.ITaskRunnable;

	/**
	 * @author Richard.Jewson
	 */
	public interface IAssetLoader extends ITaskRunnable, ITaskCancelable, IDestroyable {

		function get content() : * ;

	}
}
