package {
	import com.br.as3ufw.logging.Log;
	
	public function log(message : *,... rest) : void {
	
		var e : Error = new Error();	
		var st : String = e.getStackTrace();
		
		if (st != null) {
			st = st.substring(st.indexOf('at') + 2);
			var i : int = st.indexOf('at') + 3;
			var j : int = st.indexOf('()', i);
			st = st.substring(i, j);
			st = st.replace("::", ".");
			Log.log(Log.NONE, st, message, rest);
		} else {
			Log.log(Log.NONE, null, message, rest);
		}
		
	}
}

