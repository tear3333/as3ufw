package com.br.as3ufw.task {

	/**
	 * @author Richard.Jewson
	 */
	public interface ITaskRunnable {

		function onStart() : void;

		function onComplete() : void;

		function set executor(executor : ITaskExecutor) : void;
	}
}