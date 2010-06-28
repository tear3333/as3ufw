package as3ufw.asset {
	import flash.events.IEventDispatcher;
	import as3ufw.lifecycle.IDestroyable;
	import as3ufw.task.ITaskCancelable;
	import as3ufw.task.ITaskRunnable;

	/**
	 * @author Richard.Jewson
	 */
	public interface IAssetLoader extends ITaskRunnable, ITaskCancelable, IDestroyable, IEventDispatcher {

		function get content() : * ;

	}
}
