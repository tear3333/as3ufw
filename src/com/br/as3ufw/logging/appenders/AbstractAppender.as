package com.br.as3ufw.logging.appenders {
	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.logging.IAppender;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractAppender implements IAppender {
		
		private var _logLevel:int;
		private var _parameterExpander:Function;
		public var useDate:Boolean;
		protected var classFilters : Array;
		
		public function AbstractAppender() {
			logLevel = Log.ALL;
			useDate = true;
		}

		virtual public function addClassFilter(filter : String) : void {
		}
		
		virtual public function clearClassFilters() : void {
			classFilters = [];
		}
		
		protected function isFiltered( className:String ):Boolean {
			return false;
		}
		
		virtual public function write(level : int, className : String, text : String, params : Array) : Boolean {
			if (!Log.match(level, _logLevel)) return false;
			if (isFiltered(className)) return false;
			return true;
		}
		
		virtual public function set logLevel(level : int) : void {
			this._logLevel = level;
		}
		
		virtual public function set parameterExpander(f : Function) : void {
			this._parameterExpander = f;
		}
	}
}
