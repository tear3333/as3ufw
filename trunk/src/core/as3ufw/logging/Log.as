package as3ufw.logging {
	import as3ufw.ns.as3ufw_internal;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Richard.Jewson
	 */
	public class Log {
		
		use namespace as3ufw_internal;

		public static const DEBUG : int = 1;

		public static const INFO : int = 2;

		public static const WARN : int = 4;

		public static const ERROR : int = 8;

		public static const FATAL : int = 16;

		public static const ALL : int = DEBUG | INFO | WARN | ERROR | FATAL;

		public static const NONE : int = 0;		

		public static const UNKNOWN : int = -1;		

		private static var appenders : Array;

		{
		appenders = new Array();
		}

		public static function addApender(apender : IAppender) : void {
			appenders.push(apender);
		}

		as3ufw_internal static function append(level : int, className : String, message : String, params : Array ) : void {
			for each (var appender : IAppender in appenders) {
				appender.write(level, className, String(message), params);
			}
		}

		public static function log(level : int, className : String, text : String, params : Array ) : void {
			append(level, className, text, params);
		}

		public static function logWithParseLevel(level : int, className : String, text : String, params : Array ) : void {
			
			var logLevel : * = /^\[(debug|info|warn|error|fatal)\]/i.exec(text);
			
			if (logLevel && logLevel is Array && logLevel.length > 1) {
				level = stringToLevel( logLevel[1] );
				text = text.substring(logLevel[0].length);
			}
			
			append(level, className, text, params);
		}		

		public static function getClassLogger(clazz : Class) : ILogger {
			var name : String = getQualifiedClassName(clazz);
			name = name.replace("::", ".");
			return new Logger(name);
		}

		public static function match(level : int, toLevel : int) : Boolean {
			return (level & toLevel) == level;
		}

		public static function levelToString(level : int) : String {
			switch (level) {
				case Log.DEBUG:
					return "DEBUG";
				
				case Log.INFO:
					return "INFO";
				
				case Log.WARN:
					return "WARN";
				
				case Log.ERROR:
					return "ERROR";
				
				case Log.FATAL:
					return "FATAL";
				
				case Log.NONE:
					return "";
			}
			return "???";
		}	

		public static function stringToLevel(str : String) : int {
			if (str) {
				switch (str.toUpperCase() ) {
						
					case "DEBUG":
						return Log.DEBUG;
						
					case "INFO":
						return Log.INFO;
						
					case "WARN":
						return Log.WARN;
						
					case "ERROR":
						return Log.ERROR;
						
					case "FATAL":
						return Log.FATAL;
							
					case "NONE":
						return Log.NONE;	
				}				
			}
			return Log.UNKNOWN;
		}		
	}
}
