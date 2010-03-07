package com.br.as3ufw.task {
	import com.br.as3ufw.task.core.TaskPipeline;

	/**
	 * @author Richard.Jewson
	 */
	public interface ITaskExecutor {

		function complete() : Boolean;
		
		function error(errorMsg : String) : void;

		function update(pcentComplete : Number) : void;

		function destroy() : void;
		
		function pause() : Boolean;

		function resume() : Boolean;

		function cancel() : Boolean;

		function get taskPipeline(): TaskPipeline;

		function exec( fn:Function , execCtx:Boolean, args:Array ):void;

		function get id() : int;

		function get isCancelable() : Boolean;
		
		function get isPausable() : Boolean;
		
		function get runningTime() : int;

		function get priority() : Number;

		function set priority(priority : Number) : void;

	}
}
