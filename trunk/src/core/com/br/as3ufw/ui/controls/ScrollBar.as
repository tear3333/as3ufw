package com.br.as3ufw.ui.controls {
	import flash.display.Graphics;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class ScrollBar extends Sprite {

		public var prev : DisplayObject;
		public var next : DisplayObject;
		public var track : DisplayObject;
		public var thumb : DisplayObject;
		
		protected var _barLength : Number;
		protected var _barWidth : Number;
		protected var _thumbLength : Number;
		
		protected var _controller : ScrollBarController;
		
		private var _orientation : String;

		public function ScrollBar(orientation:String) {
			_orientation = orientation;
			init();
		}

		virtual public function init() : void {
			_controller = new ScrollBarController(_orientation, this);
		}

		virtual public function redraw() : void {
		}
		
		virtual public function set barLength(barLength:Number):void {
			_barLength = barLength;
			redraw();
		}

		public function set barWidth(barWidth : Number) : void {
			_barWidth = barWidth;
			redraw();
		}
		
		public function set thumbLength(thumbLength : Number) : void {
			_thumbLength = thumbLength;
		}
		
		public function get useNextPrevButtons() : Boolean {
			return (next!=null&&prev!=null);
		}
	}
}
