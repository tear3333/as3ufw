package com.br.as3ufw.ui {

	import flash.display.DisplayObject;
	/**
	 * @author Richard.Jewson
	 */
	public class LayoutItemProxy {

		private var _displayItem : DisplayObject;
		
		//Horizontal positioning values
		private var _x:Number;
		private var _left:Number
		private var _right:Number;
		private var _horizontalCenter:Number;
		private var horizontalPosFunc:Function;
		//Horizontal size values
		private var _width:Number;
		private var _widthPercent:Number;
		private var horizontalSizeFunc:Function;
		
		//Vertical positioning values
		private var _y:Number;
		private var _top:Number;
		private var _bottom:Number;
		private var _verticalCenter:Number;
		private var verticalPosFunc:Function;

		//Vertical size values
		private var _height:Number;
		private var _heightPercent:Number;
		private var verticalSizeFunc:Function;	
		
		public function LayoutItemProxy( displayItem:DisplayObject ) {
			this._displayItem = displayItem;
		}
		
		public function update() : void {
			if (horizontalPosFunc!=null) horizontalPosFunc();
			if (verticalPosFunc!=null) verticalPosFunc();
			if (horizontalSizeFunc!=null) horizontalSizeFunc();
			if (verticalSizeFunc!=null) verticalSizeFunc();
		}

		public function get x() : Number {
			return _x;
		}
		
		public function set x(x : Number) : void {
			_x = x;
			horizontalPosFunc = function():void {};
		}
		
		public function get left() : Number {
			return _left;
		}
		
		public function set left(left : Number) : void {
			_left = left;
			horizontalPosFunc = function():void {};
		}
		
		public function get right() : Number {
			return _right;
		}
		
		public function set right(right : Number) : void {
			_right = right;
			horizontalPosFunc = function():void {};
		}
		
		public function get horizontalCenter() : Number {
			return _horizontalCenter;
		}
		
		public function set horizontalCenter(horizontalCenter : Number) : void {
			_horizontalCenter = horizontalCenter;
			horizontalPosFunc = function():void {};
		}
		
		public function get width() : Number {
			return _width;
		}
		
		public function set width(width : Number) : void {
			_width = width;
		}
		
		public function get widthPercent() : Number {
			return _widthPercent;
		}
		
		public function set widthPercent(widthPercent : Number) : void {
			_widthPercent = widthPercent;
		}
		
		public function get y() : Number {
			return _y;
		}
		
		public function set y(y : Number) : void {
			_y = y;
			verticalPosFunc = function():void {};
		}
		
		public function get top() : Number {
			return _top;
		}
		
		public function set top(top : Number) : void {
			_top = top;
			verticalPosFunc = function():void {};
		}
		
		public function get bottom() : Number {
			return _bottom;
		}
		
		public function set bottom(bottom : Number) : void {
			_bottom = bottom;
			verticalPosFunc = function():void {};
		}
		
		public function get verticalCenter() : Number {
			return _verticalCenter;
		}
		
		public function set verticalCenter(verticalCenter : Number) : void {
			_verticalCenter = verticalCenter;
			verticalPosFunc = function():void {};
		}
		
		public function get height() : Number {
			return _height;
		}
		
		public function set height(height : Number) : void {
			_height = height;
		}
		
		public function get heightPercent() : Number {
			return _heightPercent;
		}
		
		public function set heightPercent(heightPercent : Number) : void {
			_heightPercent = heightPercent;
		}
	}
}