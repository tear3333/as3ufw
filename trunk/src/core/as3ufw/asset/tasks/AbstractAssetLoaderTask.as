package as3ufw.asset.tasks {
	import as3ufw.utils.ObjectUtils;
	import as3ufw.asset.IAssetLoader;
	import as3ufw.asset.enum.LoaderTypes;
	import as3ufw.asset.manager.AssetSet;
	import as3ufw.logging.ILogger;
	import as3ufw.logging.Log;
	import as3ufw.task.ITaskCancelable;
	import as3ufw.task.ITaskExecutor;
	import as3ufw.task.ITaskRunnable;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * @author Richard.Jewson
	 */
	public class AbstractAssetLoaderTask implements IAssetLoader, ITaskRunnable, ITaskCancelable {

		protected var _content : *;

		private var _url : URLRequest;
		private var _type : String;
		private var _id : String;

		protected var _exec : ITaskExecutor;

		private var _assetSet : AssetSet;

		protected var defaultParams : Object = {
			timeout:0, type:LoaderTypes.BINARY, bufferTime:10, forceReload:true
		};

		protected var params : Object;

		public function AbstractAssetLoaderTask(id : String, url : *, assetSet : AssetSet, params : Object ) {
			super();
			this._id = id;
			if (url is String) {
				this._url = new URLRequest(String(url));
			} else if (url is URLRequest) {
				this._url = URLRequest(url);
			} else {
				throw new Error("URL must be a String or URLRequst");
			}
			
			this._assetSet = assetSet;
			this._type = type;
			this.params = ObjectUtils.merge(defaultParams, params);
			if(this.params["forceReload"]) {
				if (!_url.data) {
					_url.data = new URLVariables();
				}
				_url.data["nonce"] = new Date().getTime();
			}
		}

		/*
		 * ITaskRunnable
		 */
		public function onAdded() : void {
			if(params["totalBytes"]) {
				_exec.totalSize = params["totalBytes"];
			}
		}

		public function onStart() : void {
		}

		public function onComplete() : void {
			if (_assetSet)
				_assetSet.addAsset(this._id, content);
		}

		public function set executor(executor : ITaskExecutor) : void {
			this._exec = executor;
		}

		/*
		 * ITaskCancelable
		 */
		virtual public function onCancel() : void {
		}

		virtual public function onTimeOut() : void {
		}

		virtual public function get timeOut() : int {
			return params["timeout"];
		}

		
		virtual protected function onStartedHandler(event : Event) : void {
		}

		virtual protected function onProgressHandler(event : ProgressEvent) : void {
			_exec.totalSize = event.bytesTotal;
			_exec.update(event.bytesLoaded);
		}

		virtual protected function onCompleteHandler(event : Event) : void {
			_exec.complete();
		}

		virtual protected function onHttpStatusHandler(event : HTTPStatusEvent) : void {
		}

		virtual protected  function onErrorHandler(event : IOErrorEvent) : void {
			_exec.error(event.text);
		}

		virtual protected function onSecurityErrorHandler(event : SecurityErrorEvent) : void {
			_exec.error(event.text);
		}

		virtual public function cleanup() : void {
		}

		virtual public function get content() : * {
			return _content;
		}

		protected function get url() : URLRequest {
			return _url;
		}

		protected function get type() : String {
			return _type;
		}

		
		public function get id() : String {
			return _id;
		}

		public function set id(id : String) : void {
			_id = id;
		}

		private var _log : ILogger = Log.getClassLogger(AbstractAssetLoaderTask);
		
	}
}
