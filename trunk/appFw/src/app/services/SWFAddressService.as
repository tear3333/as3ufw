package app.services{	import app.events.URIEvent;	import com.asual.swfaddress.SWFAddress;	import com.asual.swfaddress.SWFAddressEvent;	import flash.external.ExternalInterface;	import flash.net.URLRequest;	import flash.net.navigateToURL;	import org.robotlegs.mvcs.Actor;	public class SWFAddressService extends Actor	{		/*******************************************************************************************		*								public methods											   *		*******************************************************************************************/		public function SWFAddressService()		{			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onAddressChange);		}		public function requestURI(uri : String) : void		{			if (uri.indexOf('http://') == 0)			{				navigateToURL(new URLRequest(uri), '_blank');				return;			}			if (ExternalInterface.available) 			{				SWFAddress.setValue(uri);			} 			else 			{				setTargetURI(uri);			}		}		public function setTitle(title : String) : void		{			SWFAddress.setTitle(title);		}						/*******************************************************************************************		*								protected/ private methods								   *		*******************************************************************************************/		private function onAddressChange(e : SWFAddressEvent) : void 		{			setTargetURI(e.value);		}		private function setTargetURI(uri : String) : void 		{			if (uri.charAt(0) != '/')			{				uri = '/' + uri;			}			dispatch(new URIEvent(URIEvent.URI_CHANGED, uri));		}	}}