package as3ufw.logging {

	/**
	 * @author Richard.Jewson
	 */
	public interface IAppender {
		
		function set logLevel(level:int):void;
		
		function addClassFilter(filter:String):void;
		
		function clearClassFilters():void;
		
		function set parameterExpander(f:Function):void;
		
		function write(level:int, className:String, text:String, params:Array):Boolean;
		
	}
}
