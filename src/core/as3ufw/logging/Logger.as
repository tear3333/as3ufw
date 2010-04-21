package as3ufw.logging {
	import as3ufw.ns.as3ufw_internal;

	/**
	 * @author Richard.Jewson
	 */
	public class Logger implements ILogger {

		use namespace as3ufw_internal;

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
