package as3ufw.ui.layout.components {
	import as3ufw.ui.layout.LayoutItemProxy;
	import as3ufw.ui.layout.LayoutManager;

	import org.bytearray.display.ScaleBitmapSprite;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class Canvas extends Sprite {

		public static const NONE : String = 'none';
		public static const VERTICAL : String = 'vertical';
		public static const HORIZONTAL : String = 'horizontal';
		public static const ALL : String = 'all';

		private var _background : Sprite;
		private var _mask : Shape;

		private var _layoutManager : LayoutManager;

		private var _canvasWidth : Number;
		private var _canvasHeight : Number;
		private var _scrollPolicy : String;
		private var _useMask : Boolean;
		private var _backgroundColor : uint;
		private var _backgroundAlpha : Number;
		private var _backgroundImage : ScaleBitmapSprite;

		public var padding : Frame;

		public function Canvas( canvasWidth : Number, canvasHeight : Number, scrollPolicy : String = NONE, maskCanvas : Boolean = true ) {
			
			_canvasWidth = canvasWidth;
			_canvasHeight = canvasHeight;
			_scrollPolicy = scrollPolicy;
			_useMask = maskCanvas;
			
			init();
		}

		private function init() : void {
			
			_backgroundColor = 0x000000;
			_backgroundAlpha = 0.1;
			_backgroundImage = null;
			
			_layoutManager = new LayoutManager(this);
			_background = new Sprite();
			_mask = new Shape();
			
			refresh();
			
			super.addChild(_background);

			useMask = _useMask;
		}

		virtual protected function drawBackground() : void {
			with (_background.graphics) {
				beginFill(_backgroundColor);
				drawRect(0, 0, _canvasWidth, _canvasHeight);
				graphics.endFill();
				lineStyle(2,0);
				drawRect(0, 0, _canvasWidth, _canvasHeight);
			}
		}

		private function drawMask() : void {
			with (_mask.graphics) {
				clear();
				beginFill(0xFFFFFF, 0.5);
				drawRect(0, 0, _canvasWidth, _canvasHeight);
				endFill();							
			}
		}

		public function refresh() : void {
			_background.graphics.clear();
			_background.alpha = _backgroundAlpha;
			if (_backgroundImage == null) {
				drawBackground();
			} else {
				_backgroundImage.width = _canvasWidth;
				_backgroundImage.height = _canvasHeight;
			}
			
			_layoutManager.refresh();
			
			if (_useMask) drawMask();		
		}

		
		public function addManagedChild(child : DisplayObject) : LayoutItemProxy {
			addChild(child);
			return _layoutManager.add(child);
		}

		public function addManagedChildAt(child : DisplayObject, index : int) : LayoutItemProxy {
			addChildAt(child, index);
			return _layoutManager.add(child);
		}

		public function removeManagedChild(child : DisplayObject) : void {
			removeChild(child);
			_layoutManager.remove(child);
		}

		public function removeManagedChildAt(index : int) : void {
			_layoutManager.remove(removeChildAt(index));
		}

		/*
		 * Getters & Setters
		 */
		public function get canvasWidth() : Number {
			return _canvasWidth;
		}

		public function set canvasWidth(canvasWidth : Number) : void {
			_canvasWidth = canvasWidth;
			refresh();
		}

		public function get canvasHeight() : Number {
			return _canvasHeight;
		}

		public function set canvasHeight(canvasHeight : Number) : void {
			_canvasHeight = canvasHeight;
			refresh();
		}

		public function get scrollPolicy() : String {
			return _scrollPolicy;
		}

		public function set scrollPolicy(scrollPolicy : String) : void {
			_scrollPolicy = scrollPolicy;
			refresh();
		}

		public function get useMask() : Boolean {
			return _useMask;
		}

		public function set useMask(useMask : Boolean) : void {
			_useMask = useMask;
			if (_useMask) {
				if (_mask.parent==null) addChild(_mask);
				mask = _mask;
			} else {
				if (_mask.parent!=null) removeChild(_mask);
				mask = null;
			}
		}

		public function get backgroundColor() : uint {
			return _backgroundColor;
		}

		public function set backgroundColor(backgroundColor : uint) : void {
			_backgroundColor = backgroundColor;
			refresh();
		}

		public function get backgroundAlpha() : Number {
			return _backgroundAlpha;
		}

		public function set backgroundAlpha(backgroundAlpha : Number) : void {
			_backgroundAlpha = backgroundAlpha;
			refresh();
		}

		public function get backgroundImage() : ScaleBitmapSprite {
			return _backgroundImage;
		}

		public function set backgroundImage(backgroundImage : ScaleBitmapSprite) : void {
			if (backgroundImage == null && _backgroundImage != null) {
				_background.removeChild(_backgroundImage);
			}
			_backgroundImage = backgroundImage;
			if (_backgroundImage) {
				_background.addChild(_backgroundImage);
			}
			refresh();
		}
	}
}
