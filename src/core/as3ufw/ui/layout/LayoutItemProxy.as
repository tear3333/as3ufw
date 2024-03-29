package as3ufw.ui.layout {
	import as3ufw.ui.layout.components.Canvas;
	import as3ufw.ui.layout.components.Frame;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Richard.Jewson
	 */
	public class LayoutItemProxy {

		private var _displayItem : DisplayObject;
		private var _referenceItem : DisplayObjectContainer;

		//Horizontal positioning values
		private var _x : Number;
		private var _left : Number
		private var _right : Number;
		private var _horizontalCenter : Number;
		private var _horizontalPosFunc : Function;

		//Horizontal size values
		private var _width : Number;
		private var _widthPercent : Number;
		private var _horizontalSizeFunc : Function;

		//Vertical positioning values
		private var _y : Number;
		private var _top : Number;
		private var _bottom : Number;
		private var _verticalCenter : Number;
		private var _verticalPosFunc : Function;

		//Vertical size values
		private var _height : Number;
		private var _heightPercent : Number;
		private var _verticalSizeFunc : Function;	

		public var margin : Frame;

		public function LayoutItemProxy( displayItem : DisplayObject ) {
			this._displayItem = displayItem;
			left = 0;
			top = 0;
			margin = new Frame();
		}

		public function update() : void {
			if (_horizontalSizeFunc != null) _horizontalSizeFunc.call(this);
			if (_verticalSizeFunc != null) _verticalSizeFunc.call(this);
			if (_horizontalPosFunc != null) _horizontalPosFunc.call(this);
			if (_verticalPosFunc != null) _verticalPosFunc.call(this);
		}

		public function get x() : Number {
			return _x;
		}

		public function set x(x : Number) : void {
			_x = x;
			_horizontalPosFunc = function():void {
				_displayItem.x = x + margin.left;
			};
		}

		public function get left() : Number {
			return _left;
		}

		public function set left(left : Number) : void {
			_left = left;
			_horizontalPosFunc = function():void {
				_displayItem.x = _left + margin.left;
			};
		}

		public function get right() : Number {
			return _right;
		}

		public function set right(right : Number) : void {
			_right = right;
			_horizontalPosFunc = function():void {
				_displayItem.x = (_referenceItem.width - _displayItem.width - (_right + margin.right) );
			};
		}

		public function get horizontalCenter() : Number {
			return _horizontalCenter;
		}

		public function set horizontalCenter(horizontalCenter : Number) : void {
			_horizontalCenter = horizontalCenter;
			_horizontalPosFunc = function():void {
				_displayItem.x = (_referenceItem.width / 2 - _displayItem.width / 2 + horizontalCenter);
			};
		}

		public function get width() : Number {
			return _width;
		}

		public function set width(width : Number) : void {
			_width = width;
			_horizontalSizeFunc = function():void {
				if (_displayItem is Canvas) {
					(_displayItem as Canvas).canvasWidth = _width;
				} else {
					_displayItem.width = _width;
				}
			};
		}

		public function get widthPercent() : Number {
			return _widthPercent;
		}

		public function set widthPercent(widthPercent : Number) : void {
			_widthPercent = widthPercent;
			_horizontalSizeFunc = function():void {
				var actualWidth : Number;
				if (_referenceItem is Canvas) {
					actualWidth = (_referenceItem as Canvas).canvasWidth;
				} else {
					actualWidth = _referenceItem.width;
				}
				
				actualWidth = actualWidth - margin.left - margin.right; 
				
				if (_displayItem is Canvas) {
					(_displayItem as Canvas).canvasWidth = _widthPercent * actualWidth;
				} else {
					_displayItem.width = _widthPercent * actualWidth;
				}
			};
		}

		public function get y() : Number {
			return _y;
		}

		public function set y(y : Number) : void {
			_y = y;
			_verticalPosFunc = function():void {
				_displayItem.y = y + margin.top;
			};
		}
		
		public function get top() : Number {
			return _top;
		}

		public function set top(top : Number) : void {
			_top = top;
			_verticalPosFunc = function():void {
				_displayItem.y = top + margin.top;
			};
		}

		public function get bottom() : Number {
			return _bottom;
		}

		public function set bottom(bottom : Number) : void {
			_bottom = bottom;
			_verticalPosFunc = function():void {
				_displayItem.y = (_referenceItem.height - _displayItem.height - (_bottom + margin.bottom) );
			};
		}

		public function get verticalCenter() : Number {
			return _verticalCenter;
		}

		public function set verticalCenter(verticalCenter : Number) : void {
			_verticalCenter = verticalCenter;
			_verticalPosFunc = function():void {
			};
		}

		public function get height() : Number {
			return _height;
		}

		public function set height(height : Number) : void {
			_height = height;
			_verticalSizeFunc = function():void {
				if (_displayItem is Canvas) {
					(_displayItem as Canvas).canvasHeight = _height;
				} else {
					_displayItem.height = _height;
				}
			};
		}

		public function get heightPercent() : Number {
			return _heightPercent;
		}

		public function set heightPercent(heightPercent : Number) : void {
			_heightPercent = heightPercent;
			_verticalSizeFunc = function():void {
				var actualHeight : Number;
				if (_referenceItem is Canvas) {
					actualHeight = (_referenceItem as Canvas).canvasHeight;
				} else {
					actualHeight = _referenceItem.height;
				}
				
				actualHeight = actualHeight - margin.top - margin.bottom; 
				
				if (_displayItem is Canvas) {
					(_displayItem as Canvas).canvasHeight = _heightPercent * actualHeight;
				} else {
					_displayItem.height = _heightPercent * actualHeight;
				}
			};
		}

		public function get referenceItem() : DisplayObjectContainer {
			return _referenceItem;
		}

		public function set referenceItem(referenceItem : DisplayObjectContainer) : void {
			_referenceItem = referenceItem;
		}
	}
}
