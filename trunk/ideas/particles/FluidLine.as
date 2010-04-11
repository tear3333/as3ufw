/**
 * Fluid \ Learning \ Processing 1.0
 * http://www.processing.org/learning/topics/fluid.html
 */
package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//import net.hires.debug.Stats;
	
	[SWF(backgroundColor=0x0, width=465, height=465, frameRate=60)]
	public class FluidLine extends Sprite {
		
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		private var shapes:Sprite;
		
		public function FluidLine() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var pmouseX:Number;
		private var pmouseY:Number;
		private var canvasWidth:int = 465;
		private var canvasHeight:int = 465;
		private var mousePressed:Boolean;
		private var resolution:int = 10;
		private var penSize:int = 40;
		private var numCols:int = canvasWidth / resolution;
		private var numRows:int = canvasHeight / resolution;
		private var numParticles:int = 5000;
		private var gridDatasVectors:Vector.<Vector.<GridData>> = new Vector.<Vector.<GridData>>();
		private var particles:Vector.<Particle> = new Vector.<Particle>(numParticles, true);
		private var pcount:int = 0;
		private var once:Boolean = false;
		
		private function init(e:Event = null):void {
			shapes				= new Sprite();
			//addChild(shapes);
			
			canvasWidth = stage.stageWidth;
			canvasHeight = stage.stageHeight;
			
			bitmapData		= new BitmapData(canvasWidth, canvasHeight, true, 0x000000);
			bitmap			= new Bitmap(bitmapData);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			for (var i:int = 0; i < numParticles; i++) {
				var p:Particle = new Particle(Math.random() * canvasWidth, Math.random() * canvasHeight);
				p.color			= Math.random() * 0xffffff;
				particles[i] = p;
			}
			
			for (var col:int = 0; col < numCols; ++col) { 
				gridDatasVectors[col] = new Vector.<GridData>(numRows, true);
				for (var row:int = 0; row < numRows; ++row) { 
					var gridData:GridData = new GridData(col * resolution, row * resolution, resolution);
					gridData.col = col;
					gridData.row = row;
					gridDatasVectors[col][row] = gridData;
				}
			}
			
			//éš£æŽ¥ã™ã‚‹ã‚°ãƒªãƒƒãƒ‰ã‚’ã‚»ãƒƒãƒˆã—ã¦ã„ãã€‚
			for (col = 0; col < numCols; ++col) { 
				for (row = 0; row < numRows; ++row) { 
					gridData = gridDatasVectors[col][row];
					if (row > 0) {
						var up:GridData = gridDatasVectors[col][row - 1];//ä¸Š
						gridData.up = up;
						up.low = gridData;//ä¸‹
					}
					
					if (col > 0) {
						var left:GridData = gridDatasVectors[col - 1][row];//å·¦
						gridData.left = left;
						left.right = gridData;//å³
					}
					
					if (row > 0 && col > 0) {
						var upperLeft:GridData = gridDatasVectors[col - 1][row - 1];
						gridData.upperLeft = upperLeft;
						upperLeft.lowerRight = gridData;
					}
					
					if (row > 0 && col < numCols - 1) {
						var upperRight:GridData = gridDatasVectors[col + 1][row - 1];
						gridData.upperRight = upperRight;
						upperRight.lowerLeft = gridData;
					}
				}
			}
			
			gridDatasVectors.fixed = true;
			
			addChild(bitmap);
			//addChild(shapes);
			
			addEventListener(Event.ENTER_FRAME, draw);
		}
		
		private function draw(e:Event):void {
			var mouseXvel:Number = mouseX - pmouseX;
			var mouseYvel:Number = mouseY - pmouseY;
			
			for each(var gridDatas:Vector.<GridData> in gridDatasVectors) {
				for each(var gridData:GridData in gridDatas) {
					if (mousePressed) {
						updateGridDataVelocity(gridData, mouseXvel, mouseYvel, penSize);
					}
					updatePressure(gridData);
					
				}
			}
			
			shapes.graphics.clear();
			shapes.graphics.lineStyle(1, 0xFFFFFF);
			updateParticle();
			
			for each(gridDatas in gridDatasVectors) {
				for each(gridData in gridDatas) {
					apdateVelocity(gridData);
				}
			}
			
			pmouseX = mouseX;
			pmouseY = mouseY;
			
			bitmapData.draw(shapes);
			
			var bf:BlurFilter			= new BlurFilter(3, 3, 1);
			bitmapData.applyFilter(bitmapData, new Rectangle(0, 0, canvasWidth, canvasHeight), new Point(0, 0), bf);
		}
		

		public function updateParticle():void {
			for each(var p:Particle in particles) {
				if (p.x >= 0 && p.x < canvasWidth && p.y >= 0 && p.y < canvasHeight) {
					var col:int = int(p.x / resolution);
					var row:int = int(p.y / resolution);
					
					if (col > numCols - 1) col = numCols - 1;
					if (row > numRows - 1) row = numRows - 1;
					
					var gridData:GridData = gridDatasVectors[col][row];
					
					var ax:Number = (p.x % resolution) / resolution;
					var ay:Number = (p.y % resolution) / resolution;
					p.xvel += (1 - ax) * gridData.xvel * 0.05;
					p.yvel += (1 - ay) * gridData.yvel * 0.05;
					
					p.xvel += ax * gridData.right.xvel * 0.05;
					p.yvel += ax * gridData.right.yvel * 0.05;
					
					p.xvel += ay * gridData.low.xvel * 0.05;
					p.yvel += ay * gridData.low.yvel * 0.05;
					
					p.x += p.xvel;
					p.y += p.yvel;
					
					var dx:Number = p.px - p.x;
					var dy:Number = p.py - p.y;
					var dist:Number = Math.sqrt(dx * dx + dy * dy);
					var limit:Number = Math.random() * 0.5;
					
					if (dist > limit) {
						shapes.graphics.moveTo(p.x, p.y);
						shapes.graphics.lineStyle(1, 0x999999);
						shapes.graphics.lineTo(p.px, p.py);
					}
					else {
						shapes.graphics.moveTo(p.x, p.y);
						shapes.graphics.lineStyle(1, 0);
						shapes.graphics.lineTo(p.x + limit, p.y + limit);
					}
					
					p.px = p.x;
					p.py = p.y;
				}
				else {
					p.x = p.px = Math.random() * canvasWidth;
					p.y = p.py = Math.random() * canvasHeight;
					p.xvel = 0;
					p.yvel = 0;
				}
				
				p.xvel *= 0.5;
				p.yvel *= 0.5;
			}
		}
		
		public function updateGridDataVelocity(gridData:GridData, mvelX:int, mvelY:int, penSize:Number):void {
			var dx:Number = gridData.x - mouseX;
			var dy:Number = gridData.y - mouseY;
			var dist:Number = Math.sqrt(dy * dy + dx * dx);
			
			if (dist < penSize) { 
				if (dist < 4) {
					dist = penSize;
				}
				
				//ãƒžã‚¦ã‚¹ã«è¿‘ã„ã»ã©åŠ›ãŒå¼·ããªã‚‹ã‚ˆã†ã«ã€‚
				var power:Number = penSize / dist;
				gridData.xvel += mvelX * power;
				gridData.yvel += mvelY * power;
			}
		}
		
		public function updatePressure(gridData:GridData):void {
			var pressureX:Number = (
				  gridData.upperLeft.xvel * 0.5 //å·¦ä¸Š
				+ gridData.left.xvel       //å·¦
				+ gridData.lowerLeft.xvel * 0.5 //å·¦ä¸‹
				- gridData.upperRight.xvel * 0.5 //å³ä¸Š
				- gridData.right.xvel       //å³
				- gridData.lowerRight.xvel * 0.5 //å³ä¸‹
			);
			
			var pressureY:Number = (
				  gridData.upperLeft.yvel * 0.5 //å·¦ä¸Š
				+ gridData.up.yvel       //ä¸Š
				+ gridData.upperRight.yvel * 0.5 //å³ä¸Š
				- gridData.lowerLeft.yvel * 0.5 //å·¦ä¸‹
				- gridData.low.yvel       //ä¸‹
				- gridData.lowerRight.yvel * 0.5 //å³ä¸‹
			);
			
			gridData.pressure = (pressureX + pressureY) * 0.25;
		}
		
		public function apdateVelocity(gridData:GridData):void {
			gridData.xvel += (
				  gridData.upperLeft.pressure * 0.5 //å·¦ä¸Š
				+ gridData.left.pressure       //å·¦
				+ gridData.lowerLeft.pressure * 0.5 //å·¦ä¸‹
				- gridData.upperRight.pressure * 0.5 //å³ä¸Š
				- gridData.right.pressure       //å³
				- gridData.lowerRight.pressure * 0.5 //å³ä¸‹
			) * 0.25;
			
			gridData.yvel += (
				  gridData.upperLeft.pressure * 0.5 //å·¦ä¸Š
				+ gridData.up.pressure       //ä¸Š
				+ gridData.upperRight.pressure * 0.5 //å³ä¸Š
				- gridData.lowerLeft.pressure * 0.5 //å·¦ä¸‹
				- gridData.low.pressure       //ä¸‹
				- gridData.lowerRight.pressure * 0.5 //å³ä¸‹
			) * 0.25;
			
			gridData.xvel *= 0.99;
			gridData.yvel *= 0.99;
		}
		
		private function mouseDownHandler(e:Event):void {
			mousePressed = true;
		}
		
		private function mouseUpHandler(e:Event):void {
			mousePressed = false;
		}
	}	
}



import flash.geom.Rectangle;
class BaseGridData {
	
	public var col:int = 0;
	public var row:int = 0;
	
	public var x:int = 0;
	public var y:int = 0;
	
	public var xvel:Number = 0;
	public var yvel:Number = 0;
	
	public var pressure:Number = 0;
	
	public var color:Number = 0;
	public var rgb:uint;
	public var rectangle:Rectangle;
}

class GridData extends BaseGridData{
	
	public function GridData(x:int, y:int, resolution:Number) {
		this.x = x;
		this.y = y;
		rectangle = new Rectangle(x, y, resolution, resolution)
	}

	public var upperLeft:BaseGridData = new NullGridData();//å·¦ä¸Š
	public var up:BaseGridData = new NullGridData();//ä¸Š
	public var upperRight:BaseGridData = new NullGridData();//å³ä¸Š
	
	public var left:BaseGridData = new NullGridData();//å·¦
	public var right:BaseGridData = new NullGridData();//å³
	
	public var lowerLeft:BaseGridData = new NullGridData();//å·¦ä¸‹
	public var low:BaseGridData = new NullGridData();//ä¸‹
	public var lowerRight:BaseGridData = new NullGridData();//å³ä¸‹	
}

class NullGridData extends BaseGridData{
}

class Particle {	
	
	public function Particle(x:Number, y:Number) {
		this.x = px = x;
		this.y = py = y;
	}
	
	public var x:Number;
	public var y:Number;
	
	public var color:Number;
	
	public var px:Number;
	public var py:Number;
	public var xvel:Number = 0;
	public var yvel:Number = 0;
	
}