package org.rje.graphics.vector.brushes {

	/**
	 * @author Richard.Jewson
	 */
	public class BrushParams {
		public var weight : Number;
		public var width : Number;
		public var colour : uint;

		public static var standardParams:BrushParams;
		public static var lightParams:BrushParams;
		public static var heavyParams:BrushParams;

		{
		standardParams 	= new BrushParams(0.05, 1, 0x000000);
		lightParams 	= new BrushParams(0.01, 1, 0x000000);
		heavyParams		= new BrushParams(0.10, 1, 0x000000);
		}


		public function BrushParams( weight:Number = 0.05 , 
									 width:Number = 1 , 
									 colour:uint = 0x000000 ) {
			this.weight = weight;
			this.width = width;
			this.colour = colour;
		}

		public function clone() : BrushParams {
			return new BrushParams(weight, width, colour);
		}
	}
}
