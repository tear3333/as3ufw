package org.rje.graphics.vector.brushes {
	import flash.display.LineScaleMode;
	import flash.display.Graphics;
	import flash.display.CapsStyle;

	/**
	 * @author Richard.Jewson
	 */
	public class BrushParams {
		
		public var alpha : Number;
		public var width : Number;
		public var colour : uint;
		public var fill : Boolean;
		public var fillColour : uint;
		public var hinting : Boolean;
		public var caps : String;
		public var extendedParams:Object;

		public static var standardParams:BrushParams;
		public static var lightParams:BrushParams;
		public static var heavyParams:BrushParams;

		{
		standardParams 	= new BrushParams(0.05, 1, 0x000000);
		lightParams 	= new BrushParams(0.01, 1, 0x000000);
		heavyParams		= new BrushParams(0.10, 1, 0x000000);
		}


		public function BrushParams( alpha:Number = 0.05 , 
									 width:Number = 1 , 
									 colour:uint = 0x000000 ) {
			this.alpha = alpha;
			this.width = width;
			this.colour = colour;
			this.fill = false;
			this.hinting = true;
			this.caps = CapsStyle.NONE;
			this.extendedParams = {};
		}

		public function startDrawingMode(g:Graphics, canFill:Boolean = true) : void {
			g.lineStyle(width, colour, alpha,hinting,LineScaleMode.NONE,caps);
			if (canFill&&fill) 
				g.beginFill(fillColour);
		}

		public function endDrawingMode(g:Graphics) : void {
			if (fill) 
				g.endFill();
		}

		public function clone() : BrushParams {
			return new BrushParams(alpha, width, colour);
		}
	}
}
