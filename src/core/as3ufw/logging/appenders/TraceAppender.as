package com.br.as3ufw.logging.appenders {
	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.logging.IAppender;
	import com.br.as3ufw.logging.appenders.AbstractAppender;

	/**
	 * @author Richard.Jewson
	 */
	public class TraceAppender extends AbstractAppender implements IAppender {
		public function TraceAppender() {
			super();
		}

		override public function write(level : int, className : String, text : String, params : Array) : Boolean {
			if (!super.write(level, className, text, params)) return false;
			
			var msg:String = '';
				
			if (useDate) msg += (new Date()).toString();
				
			if (useLevel&&level) msg += Log.levelToString(level) + ' - ';
			
			if (useClass) msg += '[' + className + '] - ';
				
			msg += text ;//MessageUtil.toString(message, params);
				
			trace(msg);
			
			return true;
		}
	}
}
