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

		public function debug(message : *, ...params) : void {
			Log.append(Log.DEBUG, className, message, params);
		}

		public function info(message : *, ...params) : void {
			Log.append(Log.INFO, className, message,params);
		}

		public function warn(message : *, ...params) : void {
			Log.append(Log.WARN, className, message, params);
		}

		public function error(message : *, ...params) : void {
			Log.append(Log.ERROR, className, message, params);
		}

		public function fatal(message : *, ...params) : void {
			Log.append(Log.FATAL, className, message, params);
		}
	}
}
