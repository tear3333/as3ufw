package as3ufw.logging {
	import as3ufw.ns.as3ufw_internal;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Richard.Jewson
	 */
	public class Log {
		
		use namespace as3ufw_internal;

		public static const DEBUG : int = 1;
		public static const DEBUG_STR : String = "DEBUG";

		public static const INFO : int = 2;
		public static const INFO_STR : String = "INFO";

		public static const WARN : int = 4;
		public static const WARN_STR : String = "WARN";

		public static const ERROR : int = 8;
		public static const ERROR_STR : String = "ERROR";

		public static const FATAL : int = 16;
		public static const FATAL_STR : String = "FATAL";

		public static const ALL : int = DEBUG | INFO | WARN | ERROR | FATAL;

		public static const NONE : int = 0;		
		public static const NONE_STR : String = "NONE";

		public static const UNKNOWN : int = -1;		
		public static const UNKNOWN_STR : String = "UNKNOWN";

		private static var appenders : Array;
		private static var classFilters : Array;

		public static var enabled : Boolean;
		
		public static var logLevel:int;
		
		public static var useTime:Boolean;
		public static var useDate:Boolean;
		public static var useLevel:Boolean;
		public static var useClass:Boolean;

		{
			appenders = new Array();
			classFilters = new Array();
			
			enabled = true;
			
			logLevel = Log.ALL;
			
			useTime  = false;
			useDate  = false;
			useLevel = true;
			useClass = true;
		}

		as3ufw_internal static function append(level : int, className : String, message : String, params : Array ) : void {
			for each (var appender : IAppender in appenders) {
				appender.write(level, className, String(message), params);
			}
		}

		public static function log(level : int, className : String, text : String, params : Array ) : void {
			if (!canLog(level,className)) return;

			append(level, className, text, params);
		}

		public static function logWithParseLevel(level : int, className : String, text : String, params : Array ) : void {
			if (!canLog(level,className)) return;
			
			var logLevel : * = /^\[(debug|info|warn|error|fatal)\]/i.exec(text);
			
			if (logLevel && logLevel is Array && logLevel.length > 1) {
				level = stringToLevel( logLevel[1] );
				text = text.substring(logLevel[0].length);
			}
			
			append(level, className, text, params);
		}		

		private static function canLog(level : int, className:String):Boolean {
			if (!enabled) return false;
			if (!Log.match(level, logLevel)) return false;
			if (isFiltered(className)) return false;
			return true;
		}

		public static function getClassLogger(clazz : Class) : ILogger {
			var name : String = getQualifiedClassName(clazz);
			name = name.replace("::", ".");
			return new Logger(name);
		}

		public static function match(level : int, toLevel : int) : Boolean {
			return (level & toLevel) == level;
		}

		public static function addApender(apender : IAppender) : void {
			appenders.push(apender);
		}

		public static function addClassFilters(...filters) : void {
			for each (var filter : * in filters) {
				classFilters.push(filter);
			}
		}

		public static function clearClassFilters() : void {
			classFilters = new Array();
		}
		
		public static function isFiltered( className:String ):Boolean {
			if (classFilters.length == 0) return false;
			for each (var filter : * in classFilters) {
				if (className.search(filter) > -1) return false;
			}
			return true;
		}

		public static function levelToString(level : int) : String {
			switch (level) {
				case Log.DEBUG:
					return Log.DEBUG_STR;
				
				case Log.INFO:
					return Log.INFO_STR;
				
				case Log.WARN:
					return Log.WARN_STR;
				
				case Log.ERROR:
					return Log.ERROR_STR;
				
				case Log.FATAL:
					return Log.FATAL_STR;
				
				case Log.NONE:
					return Log.NONE_STR;
			}
			return Log.UNKNOWN_STR;
		}	

		public static function stringToLevel(str : String) : int {
			if (str) {
				switch (str.toUpperCase() ) {
						
					case Log.DEBUG_STR:
						return Log.DEBUG;
						
					case Log.INFO_STR:
						return Log.INFO;
						
					case Log.WARN_STR:
						return Log.WARN;
						
					case Log.ERROR_STR:
						return Log.ERROR;
						
					case Log.FATAL_STR:
						return Log.FATAL;
							
					case Log.NONE_STR:
						return Log.NONE;	
				}				
			}
			return Log.UNKNOWN;
		}
		
	}
}
