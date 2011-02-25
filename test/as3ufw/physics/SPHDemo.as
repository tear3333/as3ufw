package as3ufw.physics {
	import org.rje.graphics.vector.brushes.BrushParams;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.forces.AbstractForce;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.fluid.FluidParticleGroup;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author richard.jewson
	 */
	public class SPHDemo extends Sprite {
		public var engine : ParticleEngine;
		public var group : FluidParticleGroup;
		public var mousePos : Vector2D;
		public var oldMousePos : Vector2D;
		public var lmb : Boolean;
		public var bmd : BitmapData;
		public var bm : Bitmap;
		public var renderContext : Shape;
		public var viewContext : Shape;
		private var attractor : AbstractForce;

		public function SPHDemo() {
			init();
		}

		public function init() : void {
			engine = new ParticleEngine();
			group = new FluidParticleGroup();
			engine.addGroup(group);
			mousePos = new Vector2D();
			oldMousePos = new Vector2D();
			bmd = new BitmapData(600, 400);
			bm = new Bitmap(bmd);
			// ,"auto",true);
			//addChild(bm);
			renderContext = new Shape();
			addChild(renderContext);
			viewContext = new Shape();
			addChild(viewContext);
			
//			attractor = new Attractor(Forces.Uniform, mousePos, -2, -1);
			attractor = new Attractor(Forces.Uniform, mousePos, -50, 40);
			attractor.active = false;
			
			group.addForceGenerator(attractor);
			
			group.damping = 0.95;
			group.globalForce.y = 5;
			group.addRenderer(new PointRenderer(renderContext.graphics,new BrushParams(1,3)));
			
			for (var i : int = 0; i < 1000; i++) {
				var p:Particle = new Particle(new Vector2D(200+(Math.random()*100),200+(Math.random()*100)));
				p.mass = 1;
				group.addParticle(p);				
			}
			
			start();
		}

		virtual public function start() : void {
			trace(getQualifiedClassName(this));
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(Event.REMOVED_FROM_STAGE, stop);
		}

		private function onMouseUp(event : MouseEvent) : void {
			lmb = false;
			attractor.active = false;
		}

		private function onMouseDown(event : MouseEvent) : void {
			lmb = true;
			attractor.active = true;
		}

		virtual public function stop(e : Event = null) : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(Event.REMOVED_FROM_STAGE, stop);
		}

		public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			renderContext.graphics.clear();
			engine.update();
			var p:Particle = group.particles;
			var e:Number = 0.000000001;
			while (p) {
				if (p.pos.x<100) p.pos.x = 100+e;
				if (p.pos.x>400) p.pos.x = 400-e;
				if (p.pos.y<100) p.pos.y = 100+e;
				if (p.pos.y>390) p.pos.y = 390-e;
				p = p.next;
			}
		}
	}
}
