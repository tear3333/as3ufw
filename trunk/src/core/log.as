package {
	import com.br.as3ufw.logging.Log;
	public function log(message:*,... rest):void {
		Log.log(Log.NONE, message, rest);
	}
}

