package as3ufw.utils {
	/**
	 * @author richard.jewson
	 */
	public class Proxy {
		
		public static function defer(scope:Object, method:Function, ... args):Function {
			
			return function():Object {
				return method.apply(scope,args);
			};
			
		}
		
	}
}
