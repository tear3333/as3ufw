package as3ufw.ui.layout {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * @author Richard.Jewson
	 */
	public class LayoutManager {

		private var _referenceDOC : DisplayObjectContainer;

		private var _layoutItemProxies : Array;
		
		public function LayoutManager( referenceDOC:DisplayObjectContainer ) {
			_referenceDOC = referenceDOC;
			_layoutItemProxies = [];
		}

		public function add(item:DisplayObject) : LayoutItemProxy {
			var layoutItemProxy : LayoutItemProxy = new LayoutItemProxy( item );
			layoutItemProxy.referenceItem = _referenceDOC;
			_layoutItemProxies.push(layoutItemProxy);
			return layoutItemProxy;
		}

		public function remove(child : DisplayObject) : void {
		}

		public function refresh() : void {
			for each (var layoutItemProxy : LayoutItemProxy in _layoutItemProxies) 
				layoutItemProxy.update();
		}

	}
}
