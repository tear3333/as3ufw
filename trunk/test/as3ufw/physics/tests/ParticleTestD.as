package as3ufw.physics.tests {
	import flash.geom.ColorTransform;
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.Spring;
	import as3ufw.physics.forces.RandomForce;
	import as3ufw.physics.renderers.CircleRenderer;
	import as3ufw.physics.renderers.PointRenderer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestD extends ParticleTestBase {

		public var bmd : BitmapData;
		public var bm : Bitmap;
		public var renderContext : Shape;

		public function ParticleTestD() {
			super();

			group.damping = 1;

			bmd = new BitmapData(600, 400);	
			bm = new Bitmap(bmd);//,"auto",true);
			addChild(bm); 
			renderContext = new Shape();

			var firstPos : Vector2D = new Vector2D(200, 200);
			
			var center : Particle = Particle.GetParticle(firstPos.clone());
			center.fixed = true;
			group.addControlParticle(center);
			group.pos.copy(firstPos);
			
			var first : Particle;
			var last : Particle;
			
			var points : int = 15;
			
			for (var i : int = 0;i < points;i++) {
				var pos : Vector2D = new Vector2D(100, 0);
				
				pos.angle = ( -2 * Math.PI * i) / (points);
				pos.plusEquals(firstPos);
				var p : Particle = Particle.GetParticle(pos);
				group.addParticle(p);	
				if (i == 0) first = p;
				
				var spring : Spring = new Spring(center, p, 0.01);
				group.addSpring(spring);

				if (last) {
					group.addSpring(new Spring(last, p, 0.4));
				}

				last = p;
			}
			group.addSpring(new Spring(last, first, 0.4));
			
			//group.addRenderer(new PointRenderer(graphics, 3));
			group.addRenderer(new CircleRenderer(renderContext.graphics, 1,0x00000, 0.1));
			
			//group.addForceGenerator(new RelativeAttractor(mousePos, -20, 30));
			group.addForceGenerator(new RandomForce(3));
			//group.addForceGenerator(new PulseAttractor(mousePos,0.1));

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			group.skew(mousePos.minus(group.pos));
			renderContext.graphics.clear();
			engine.update();
			if (lmb)
				bmd.draw(renderContext, null, null, BlendMode.MULTIPLY, null, true);
			bmd.colorTransform(bmd.rect, new ColorTransform(1,1,1,1,0,0,0,0));
			//bmd.applyFilter(bmd, bmd.rect, new Point(0,0), new BlurFilter(1.1, 1.1, 1));
		}
	}
}
