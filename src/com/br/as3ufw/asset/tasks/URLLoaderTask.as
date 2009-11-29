package com.br.as3ufw.asset.tasks {
	import com.br.as3ufw.asset.manager.AssetSet;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Richard.Jewson
	 */
	public class URLLoaderTask extends AbstractAssetLoaderTask {

		private var _urlloader : URLLoader;

		public function URLLoaderTask(id : String, url : *, assetSet : AssetSet,  params:Object) {
			super(id, url, assetSet, params );
		}

		override protected function onCompleteHandler(event : Event) : void {
			_content = event.target.data;
			super.onCompleteHandler(event);
		}

		override public function onStart() : void {
			_urlloader = new URLLoader();
			_urlloader.dataFormat = type;
			_urlloader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler, false, 0, true);
			_urlloader.addEventListener(Event.COMPLETE, onCompleteHandler, false, 0, true);
			_urlloader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
			_urlloader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler, false, 0, true);
			_urlloader.addEventListener(Event.OPEN, onStartedHandler, false, 0, true);
			_urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler, false, 0, true);		
			
			try {
				_urlloader.load(url);
			} catch( e : SecurityError) {
				_exec.error(e.message);
			}			
		}

		override public function onCancel() : void {
			try {
				_urlloader.close();
			} catch (e : Error) {
			}
			super.onCancel();
		}

		override public function cleanup() : void {
			if (!_urlloader)
				return;
			_urlloader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			_urlloader.removeEventListener(Event.COMPLETE, onCompleteHandler);
			_urlloader.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			_urlloader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler);
			_urlloader.removeEventListener(Event.OPEN, onStartedHandler);
			_urlloader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);		
			_urlloader = null;
		}
	}
}
