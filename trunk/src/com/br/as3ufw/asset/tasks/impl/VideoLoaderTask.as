package com.br.as3ufw.asset.tasks.impl {
	import com.br.as3ufw.asset.enum.LoaderTypes;
	import com.br.as3ufw.asset.manager.AssetSet;
	import com.br.as3ufw.asset.tasks.AbstractAssetLoaderTask;
	import com.br.as3ufw.logging.ILogger;
	import com.br.as3ufw.logging.Log;

	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	/**
	 * @author Richard.Jewson
	 */
	public class VideoLoaderTask extends AbstractAssetLoaderTask {

		private var _netConnection : NetConnection;
		private var _netStream : NetStream;
		private var _metaData : *;
		private var _timer : Timer;

		public function VideoLoaderTask(id : String, url : *, assetSet : AssetSet, params : Object = null) {
			super(id, url, assetSet, mergeParams(params, {type:LoaderTypes.BINARY}));
		}

		override public function onStart() : void {
			_netConnection = new NetConnection();
			_netConnection.connect(null);
			_netStream = new NetStream(_netConnection);
			_netStream.bufferTime = params.bufferTime;
			_netStream.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus, false, 0, true);
			_netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError, false, 0, true);
			var client : Object = { onCuePoint : function(...args):void {
			}, onMetaData : function(evt : *) : void {
				_metaData = evt;
				_log.debug("meta", _metaData);
			}, onPlayStatus : function(...args):void {
			}
			};
			_netStream.client = client;
			try {
				_netStream.play(url.url);
				//_netStream.pause();
			}catch( e : SecurityError) {
			}
			_log.info(this + " starting...");
		}

		private function onAsyncError(event : AsyncErrorEvent) : void {
		}

		private function onNetStatus(event : NetStatusEvent) : void {
			if (event.info.code == "NetStream.Buffer.Full") {
				_netStream.pause();
				_exec.complete();
			}
			_log.warn("Event:", event);
		}

		override public function onComplete() : void {
			super.onComplete();
			//_log.info(this + " complete (" + totalRunningTime + " ms)");
		}

		override public function cleanup() : void {
			if (!_netStream)
				return;
			_netStream.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			_netStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_netStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
		}

		override public function get content() : * {
			return {stream:_netStream, metadata:_metaData};
		}

		private var _log : ILogger = Log.getClassLogger(VideoLoaderTask);
	}
}
