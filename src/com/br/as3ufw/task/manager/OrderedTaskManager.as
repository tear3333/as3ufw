package com.br.as3ufw.task.manager {
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;

	/**
	 * @author Richard.Jewson
	 */
	public class OrderedTaskManager extends ConcurrentTaskManager {

		public function OrderedTaskManager() {
			super(1);
		}
		
		private var _log : ILogger = LoggerFactory.getClassLogger(OrderedTaskManager);
	}
		
}