package app.core.model.vo {

	/**
	 * @author Richard.Jewson
	 */
	public class ViewConfigVO {
		
		public var id : String;
		public var viewClass : Class;
		public var uri : String;
		public var params : Object;

		public function ViewConfigVO(id:String,viewClass:Class,uri:String,params:Object) {
			this.id = id;
			this.viewClass = viewClass;
			this.uri = uri;
			this.params = params;
		}
	}
}
