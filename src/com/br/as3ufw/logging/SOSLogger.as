package com.br.as3ufw.logging {
	import org.as3commons.logging.LogLevel;
	import org.as3commons.logging.ILogger;

	/**
	 * @author Richard.Jewson
	 */

	public class SOSLogger implements ILogger {

		private var _name : String;
		private var _log : Function;

		public function SOSLogger(log : Function,name : String) {
			this._name = name;
			this._log = log;
		}

		public function debug(message : String, ...params : *) : void {
			_log(LogLevel.DEBUG, _name, message, params);
		}

		public function get debugEnabled():Boolean {
			return true;
		}

		public function info(message : String, ...params : *) : void {
			_log(LogLevel.INFO, _name, message, params);
		}		

		public function get infoEnabled():Boolean {
			return true;
		}

		public function warn(message : String, ...params : *) : void {
			_log(LogLevel.WARN, _name, message, params);
		}

		public function get warnEnabled():Boolean {
			return true;
		}

		public function error(message : String, ...params : *) : void {
			_log(LogLevel.ERROR, _name, message, params);
		}

		public function get errorEnabled():Boolean {
			return true;
		}

		public function fatal(message : String, ...params : *) : void {
			_log(LogLevel.FATAL, _name, message, params);
		}		

		public function get fatalEnabled():Boolean {
			return true;
		}

		public function get name() : String {
			return _name;
		}
	}
}
