package as3ufw.logging {
	import as3ufw.logging.appenders.TraceAppender;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class LogTest extends Sprite {
		public function LogTest() {
			var traceAppender:TraceAppender = new TraceAppender();
			traceAppender.logLevel = Log.DEBUG | Log.INFO;
			//traceAppender.useDate = false;
			Log.addApender(traceAppender);
			
			var log:ILogger = Log.getClassLogger(LogTest);
			
			log.debug("debug");
			log.error("error");
			log.fatal("fatal");
			log.info("info");
			log.warn("warn");
			
			log("this is a trace...");
		}
	}
}
