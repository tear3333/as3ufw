package com.br.as3ufw.logging {
	public interface ILogger {
		
		function debug(message:String, ... params):void;
		function info(message:String, ... params):void;
		function warn(message:String, ... params):void;
		function error(message:String, ... params):void;
		function fatal(message:String, ... params):void;
	
	}
}