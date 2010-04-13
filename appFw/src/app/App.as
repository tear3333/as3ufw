package app {
	import com.br.as3ufw.logging.Log;
	import com.br.as3ufw.logging.appenders.TraceAppender;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	[Frame(factoryClass="app.view.Preloader")]
	public class App extends Sprite {
		
		private var m_context : AppContext;
		
		public function App() {

			var traceAppender : TraceAppender = new TraceAppender();
			traceAppender.useClass = false;
			Log.addApender(traceAppender);

			if (stage) {
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}

			m_context = new AppContext(this);
		}
	}
}