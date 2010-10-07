package as3ufw.logging.appenders {
	import as3ufw.logging.Log;
	import as3ufw.logging.IAppender;
	import as3ufw.logging.appenders.AbstractAppender;

	/**
	 * @author Richard.Jewson
	 */
	public class TraceAppender extends AbstractAppender implements IAppender {
		public function TraceAppender() {
			super();
		}

		override public function write(level : int, className : String, text : String, params : Array) : void {
			
			var msg:String = "";
				
			if (Log.useDate) msg += (new Date()).toString();
				
			if (Log.useLevel&&level) msg += Log.levelToString(level) + " - ";
			
			if (Log.useClass) msg += "[" + className + "] - ";
				
			msg += text ;//MessageUtil.toString(message, params);
			
			msg += basicParamsOuput(params);
			
			trace(msg);
			
		}
	}
}
