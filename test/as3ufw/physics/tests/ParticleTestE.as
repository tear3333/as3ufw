package as3ufw.physics.tests {
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import as3ufw.physics.renderers.SegmentCurveRenderer;
	import as3ufw.physics.renderers.CircleRenderer;
	import as3ufw.physics.renderers.JoinedCurveRenderer;
	import as3ufw.physics.forces.RelativeAttractor;
	import as3ufw.physics.Spring;
	import as3ufw.physics.renderers.PointRenderer;

	import flash.events.Event;

	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestE extends ParticleTestBase {
		
		public var center:Particle;
		public var bmd:BitmapData;
		public var bm:Bitmap;
		public var renderContext:Shape;
		
		public function ParticleTestE() {
			super();
			
			bmd = new BitmapData(600, 400);	
			bm = new Bitmap(bmd);//,"auto",true);
			addChild(bm);
			renderContext = new Shape();
			
			var pos:Vector2D = new Vector2D(200,200);
			center = Particle.GetParticle(pos);
			//group.addParticle(center);
			center.fixed = true;
			
			var points:int = 100;
			
			for (var i : int = 0; i < points; i++) {
				var p:Particle = Particle.GetParticle(pos);
				p.mass = i+2;
				group.addParticle(p);	
				
				var spring:Spring = new Spring(center, p,0.2*(i+1));
				group.addSpring(spring);

			}
			
//			group.addRenderer(new PointRenderer(graphics,3));
			group.addRenderer(new SegmentCurveRenderer(renderContext.graphics,1,0,0.05));
			
//			group.addForceGenerator(new RelativeAttractor(mousePos, -20, 30));
			
			start();
		}
		
		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			center.pos.copy(mousePos);
			renderContext.graphics.clear();
			graphics.clear();
			engine.update();
			bmd.draw(renderContext);
		}
	}
}
