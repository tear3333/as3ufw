package com.br.as3ufw.logging.appenders {
	import com.br.as3ufw.logging.IAppender;
	import com.br.as3ufw.logging.Log;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;

	/**
	 * @author Richard.Jewson
	 */
	public class ChainsawAppender extends AbstractAppender implements IAppender {

		private var socket : XMLSocket;
		private var active : Boolean;
		private var buffer : Array;
		private var _server : String;
		private var _port : int;		

		public function ChainsawAppender(server : String = "localhost", port : int = 4448) {
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
			} catch (error : SecurityError) {
				trace("ChainsawAppender cannot connect:" + error.toString());
			}
		}

		private function onConnect(event : Event) : void {
			active = true;
			var len : int = buffer.length;
			for (var i : int = 0;i < len;i++) {
				socket.send(buffer[i]);
			}
			buffer.length = 0;
		}

		private function onSecurityError(event : SecurityErrorEvent) : void {
			trace("ChainsawAppender security error:" + event.toString());
		}

		private function onError(event : IOErrorEvent) : void {
			socket.close();
			socket = null;
			active = false;
		}

		override public function write(level : int, className : String, text : String, params : Array) : Boolean {
			if (!super.write(level, className, text, params)) return false;
			
			var buf:String = "<log4j:event logger=\"";
			buf += className;
			buf += "\" timestamp=\"";
			buf += new Date().time;
			buf += "\" level=\"";
			buf += level;//LogEvent.getLevelString(event.level);
			buf += "\" thread=\"";
			buf += "url";//url
			buf += "\">\r\n";
			// message
			buf += "<log4j:message><![CDATA[";
			buf += text;
			buf += "]]></log4j:message>\r\n";
			// application property
			buf += "<log4j:properties><log4j:data name=\"application\" value=\"";
			buf += "as3";
			buf += "\" />\r\n</log4j:properties>\r\n";
			// close
			buf += "</log4j:event>\r\n\r\n";

			if (active) {
				socket.send(buf);
			} else {
				buffer.push(buf);
			}
			
			return true;
		}
	}
}