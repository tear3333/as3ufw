package as3ufw.logging.appenders {
	import as3ufw.logging.Log;
	import as3ufw.logging.IAppender;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractAppender implements IAppender {
		
		private var _logLevel:int;
		private var _parameterExpander:Function;
		protected var classFilters : Array;
		
		public var useTime:Boolean;
		public var useDate:Boolean;
		public var useLevel:Boolean;
		public var useClass:Boolean;

		public function AbstractAppender() {
			logLevel = Log.ALL;
			useTime  = false;
			useDate  = false;
			useLevel = true;
			useClass = true;
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
