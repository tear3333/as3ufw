package as3ufw.physics {
	import flash.utils.getQualifiedClassName;
	import as3ufw.geom.Vector2D;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestBase extends Sprite {

		public var engine : ParticleEngine;
		public var group : ParticleGroup;
		public var mousePos : Vector2D;
		public var oldMousePos : Vector2D;
		public var lmb : Boolean;
		public var bmd : BitmapData;
		public var bm : Bitmap;
		public var renderContext : Shape;
		public var viewContext : Shape;

		public function ParticleTestBase() {
			init();
		}

		public function init() : void {
			engine = new ParticleEngine();
			group = new ParticleGroup();
			engine.addGroup(group);
			mousePos = new Vector2D();
			oldMousePos = new Vector2D();
			bmd = new BitmapData(600, 400);	
			bm = new Bitmap(bmd);//,"auto",true);
			addChild(bm); 
			renderContext = new Shape();
			addChild(renderContext);
			viewContext = new Shape();
			addChild(viewContext);
		}

		virtual public function start() : void {
			trace(getQualifiedClassName(this));
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(Event.REMOVED_FROM_STAGE, stop);
		}

		private function onMouseUp(event : MouseEvent) : void {
			lmb = false;
		}

		private function onMouseDown(event : MouseEvent) : void {
			lmb = true;
		}

		virtual public function stop(e : Event = null) : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
			removeEventListener(Event.REMOVED_FROM_STAGE, stop);
		}

		public function onEnterFrame(event : Event) : void {
		}
	}
}
