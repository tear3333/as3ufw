package com.br.as3ufw.logging.appenders {
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.XMLSocket;

	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.logging.IAppender;

	/**
	 * @author Richard.Jewson
	 */
	public class SOSAppender extends AbstractAppender implements IAppender {
		
		private var socket : XMLSocket;
		private var active : Boolean;
		private var buffer : Array;
		private var _server : String;
		private var _port : int;		
		
		public function SOSAppender(server:String = "localhost", port:int = 4444) {
			super();
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

		private function onConnect(event : Event) : void {
			active = true;
			var len:int = buffer.length;
			for (var i : int = 0; i < len; i++) {
				socket.send(buffer[i]);
			}
			buffer.length = 0;
		}

		private function onSecurityError(event : SecurityErrorEvent) : void {
			trace("SOSLogger security error:"+event.toString());
		}
		
		private function onError(event : IOErrorEvent) : void {
			socket.close();
			socket = null;
			active = false;
		}

		override public function write(level : int, className : String, text : String, params : Array) : Boolean {
			if (!super.write(level, className, text, params)) return false;
			
			var msg:String = "";
			
			var i:int = msg.indexOf("\n");
			if (i>0) {
				//msg = "!SOS<showFoldMessage  key=\"" + level + "\"><title><![CDATA[" + name + ": " + msg.substr(0,i) + "]]></title><message><![CDATA["+msg.substr(i,msg.length)+"]]></message></showFoldMessage>\n";
			} else {
				//msg = "!SOS<showMessage key=\"" + level + "\"><![CDATA[" + name + ": " + msg + "]]></showMessage>\n";
			}
				
			if (useDate) msg += (new Date()).toString() + " ";
				
			if (level) msg += Log.levelToString(level) + " - ";
			
			if (className) msg += className + " - ";
				
			msg += text ;//MessageUtil.toString(message, params);
				
			if (active) {
				socket.send(msg);
			} else {
				buffer.push(msg);
			}
			
			return true;
		}
	}
}