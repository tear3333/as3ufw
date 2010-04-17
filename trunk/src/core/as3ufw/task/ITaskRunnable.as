package as3ufw.task {

	/**
	 * @author Richard.Jewson
	 */
	public interface ITaskRunnable {

		function onAdded() : void;

		function onStart() : void;

		function onComplete() : void;

		function set executor(executor : ITaskExecutor) : void;
	}
}
