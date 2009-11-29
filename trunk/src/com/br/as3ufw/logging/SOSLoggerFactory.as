package com.br.as3ufw.logging {
	import org.as3commons.logging.LogLevel;
	import org.as3commons.logging.util.MessageUtil;

	import com.br.as3ufw.utils.ObjectUtils;

	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.ILoggerFactory;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;

	/**
	 * @author Richard.Jewson
	 */
	public class SOSLoggerFactory implements ILoggerFactory {

		private var socket : XMLSocket;
		private var active : Boolean;
		private var buffer : Array;
		private var _server : String;
		private var _port : int;
		//private var _expandParamsFunc : Function;

		public function SOSLoggerFactory(server:String = "localhost", port:int = 4444) {
			//_expandParamsFunc = (expandParamsFunc==null)?ObjectUtils.toString:expandParamsFunc;
			_port = port;
			_server = server;
			active = false;
			init();
		}
		
		private function init() : void {
			buffer = [];
			socket = new XMLSocket();
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			try {
				socket.connect(_server, _port);
			} catch (error:SecurityError) {
				trace("SOSLogger cannot connect:"+error.toString());
			}
		}
		
		public function getLogger(name : String) : ILogger {
			return new SOSLogger(log,name);
		}
		
		private function onSecurityError(event : SecurityErrorEvent) : void {
			trace("SOSLogger security error:"+event.toString());
		}

		private function onConnect(event : Event) : void {
			active = true;
			var len:int = buffer.length;
			for (var i : int = 0; i < len; i++) {
				socket.send(buffer[i]);
			}
			buffer.length = 0;
		}
		
		private function onError(event : IOErrorEvent) : void {
			socket.close();
			socket = null;
			active = false;
		}
		
		private function log(level:int, name:String, message : String, params : Array) : void {
			
			var msg:String = "";
				
			// add datetime
			//msg += (new Date()).toString() + " " + LogLevel.toString(level) + " - " + name + " - ";
				
			// add name and params
			msg += MessageUtil.toString(message, params);
			
			var i:int = msg.indexOf("\n");
			if (i>0) {
				msg = "!SOS<showFoldMessage  key=\"" + level + "\"><title><![CDATA[" + name + ": " + msg.substr(0,i) + "]]></title><message><![CDATA["+msg.substr(i,msg.length)+"]]></message></showFoldMessage>\n";
			} else {
				msg = "!SOS<showMessage key=\"" + level + "\"><![CDATA[" + name + ": " + msg + "]]></showMessage>\n";
			}
			
			if (active) {
				socket.send(msg);
			} else {
				buffer.push(msg);
			}
		}	
		
	}
}
