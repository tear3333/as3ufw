package com.br.as3ufw.logging {
	import com.br.as3ufw.ns.br_internal;

	/**
	 * @author Richard.Jewson
	 */
	public class Logger implements ILogger {

		use namespace br_internal;

		private var className : String;

		public function Logger( className : String = null ) {
			this.className = className;
		}

		public function debug(message : String, ...params : *) : void {
			Log.append(Log.DEBUG, className, message, params);
		}

		public function info(message : String, ...params : *) : void {
			Log.append(Log.INFO, className, message, params);
		}

		public function warn(message : String, ...params : *) : void {
			Log.append(Log.WARN, className, message, params);
		}

		public function error(message : String, ...params : *) : void {
			Log.append(Log.ERROR, className, message, params);
		}

		public function fatal(message : String, ...params : *) : void {
			Log.append(Log.FATAL, className, message, params);
		}
	}
}
