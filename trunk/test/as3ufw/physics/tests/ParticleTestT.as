package as3ufw.physics.tests {
	import as3ufw.utils.Random;
	import flash.display.Shape;
	import flash.filters.GlowFilter;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.ParticleUtils;
	import as3ufw.physics.forces.RandomForce;
	import as3ufw.physics.renderers.ContinuousCurveRenderer;
	import as3ufw.physics.renderers.PointRenderer;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestT extends ParticleTestBase {
		public var center : Particle;
		public var control : Particle;
		public var perpParticles : Vector.<Particle> = new Vector.<Particle>();
		public var currentAngle : Number = -100;
		private var filter : DropShadowFilter;
		
		public function ParticleTestT() {
			super();

			group.damping = 1;

			var firstPos : Vector2D = new Vector2D(200, 200);

			var center : Particle = Particle.GetParticle(firstPos.clone());
			center.fixed = true;
			group.addControlParticle(center);
			group.pos.copy(firstPos);

			ParticleUtils.createSpringCircle(group, center, 5, 80);

			group.addRenderer(new PointRenderer(viewContext.graphics, new BrushParams(1, 2)));
			var bp:BrushParams = new BrushParams(1, 3, 0x555555);
			bp.fill = true;
			bp.fillColour = 0xFAFAFA;
			group.addRenderer(new ContinuousCurveRenderer(renderContext.graphics,bp ));
			// group.addRenderer(new TestPathRenderer(renderContext.graphics, 1,0x00000, 0.1));

			// group.addForceGenerator(new RelativeAttractor(mousePos, -20, 30));
			group.addForceGenerator(new RandomForce(2));
			// group.addForceGenerator(new PulseAttractor(mousePos,0.1));
renderContext.filters = [new GlowFilter(0x000000,0.9,2,2,1)];
//renderContext.filters = [new GlowFilter(0x000000),new DropShadowFilter()];
			removeChild(viewContext);
			removeChild(renderContext);
			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			group.skew(mousePos.minus(group.pos));
			renderContext.graphics.clear();
			viewContext.graphics.clear();
			engine.update();
			if (lmb) {
				lmb = false;
				//bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);
				//renderShape(renderContext,0.9);
				//renderShape(renderContext,0.8);
				//renderShape(renderContext,0.7);
				renderShape(renderContext,0.6);
				renderShape(renderContext,0.5);
				renderShape(renderContext,0.4);
				renderShape(renderContext,0.3);
				renderShape(renderContext,0.2);
				renderShape(renderContext,0.1);
//				var m1:Matrix = new Matrix();
//				m1.scale(0.8 ,0.8);
//				m1.translate( mousePos.x*0.2, mousePos.y*0.2);
//				bmd.draw(renderContext, m1, null, BlendMode.NORMAL, null, true);
//				var m2:Matrix = new Matrix();
//				m2.scale(0.6, 0.6);
//				m2.translate( mousePos.x*0.4, mousePos.y*0.4);
//				bmd.draw(renderContext, m2, null, BlendMode.NORMAL, null, true);
//				var m3:Matrix = new Matrix();
//				m3.scale(0.4, 0.4);
//				m3.translate( mousePos.x*0.6, mousePos.y*0.6);
//				bmd.draw(renderContext, m3, null, BlendMode.NORMAL, null, true);
//				var m4:Matrix = new Matrix();
//				m4.scale(0.2, 0.2);
//				m4.translate( mousePos.x*0.8, mousePos.y*0.8);
//				bmd.draw(renderContext, m4, null, BlendMode.NORMAL, null, true);
			}
			// bmd.colorTransform(bmd.rect, new ColorTransform(1,1,1,1,0,0,0,0));
			// bmd.applyFilter(bmd, bmd.rect, new Point(0,0), new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.992,0 ] ) );
			// bmd.applyFilter(bmd, bmd.rect, new Point(0,0), new BlurFilter(1.1, 1.1, 1));
		}

		public function renderShape(shape:Shape,scale:Number) : void {
			var sc : Number = 0.0005;
			
			var m:Matrix = new Matrix();
			m.translate(-group.pos.x,-group.pos.y);
			m.rotate(Random.float(-0.1, 0.1));
			m.scale(scale+Random.float(sc,-sc) ,scale+Random.float(sc,-sc));
			m.translate( mousePos.x, mousePos.y);
			//m.translate( mousePos.x*(1-scale), mousePos.y*(1-scale));
			bmd.draw(renderContext, m, null, BlendMode.NORMAL, null, true);
		}
		
	}
}
