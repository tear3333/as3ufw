package as3ufw.logging {
	public interface ILogger {
		
		function debug(message:*, ... params):void;
		function info(message:*, ... params):void;
		function warn(message:*, ... params):void;
		function error(message:*, ... params):void;
		function fatal(message:*, ... params):void;
	
	}
}