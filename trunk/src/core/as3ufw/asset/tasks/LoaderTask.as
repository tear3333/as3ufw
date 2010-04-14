package as3ufw.asset.tasks {
	import as3ufw.asset.manager.AssetSet;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;

	/**
	 * @author Richard.Jewson
	 */
	public class LoaderTask extends AbstractAssetLoaderTask {

		private var _loader : Loader;

		public function LoaderTask(id : String,url : *, assetSet : AssetSet, params:Object) {
			super(id, url, assetSet, params);
		}
	
		override protected function onCompleteHandler(event : Event) : void {
			_content = _loader.content;
			super.onCompleteHandler(event);
		}

		override public function onStart() : void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, onStartedHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler, false, 0, true);		
			
			try {
				_loader.load(url);
			} catch( e : SecurityError) {
				_exec.error(e.message);
			}			
		}

		override public function onCancel() : void {
			try {
				if (_loader)
					_loader.close();
			} catch (e : Error) {
			}
			super.onCancel();
		}

		override public function cleanup() : void {
			if (!_loader)
				return;
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			_loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, onStartedHandler);
			_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);		
			_loader = null;
		}		
	}
}
