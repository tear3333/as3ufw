package as3ufw.logging.appenders {
	import as3ufw.logging.IAppender;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractAppender implements IAppender {

		private var _parameterExpander : Function;

		public function AbstractAppender() {
		}

		virtual public function write(level : int, className : String, text : String, params : Array) : void {
		}

		virtual public function set parameterExpander(f : Function) : void {
			this._parameterExpander = f;
		}

		protected function basicParamsOuput(params:Array) : String {
			var result:String = "";
			for each (var param : * in params) {
				result += "\n" + param;
			}
			return result;
		}
	}
}
