package as3ufw.physics.tests {
	import as3ufw.physics.forces.InverseAttractor;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.Spring;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.physics.renderers.SegmentCurveRenderer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestL extends ParticleTestBase {

		public var center : Particle;

		public function ParticleTestL() {
			super();
			group.damping = 0.8;
			
			var pos : Vector2D = new Vector2D(200, 200);
			center = Particle.GetParticle(pos);
			//group.addParticle(center);
			center.fixed = true;
			
			var points : int = 400;
			var mass1 : Number = 5.0;
			var mass2 : Number = 0.5;
			var baseMod : Number = 10.0;
			var partNum : Number = 100;
			
			for (var i : int = 0;i < points;i++) {
				var p : Particle = Particle.GetParticle(pos);

				p.mass = 1+(i/points);//i/20;
				group.addParticle(p);	
				
				var spring : Spring = new Spring(center, p, 0.1);
				group.addSpring(spring);
			}
			group.iterations = 1;
			group.addRenderer(new PointRenderer(viewContext.graphics, 1));
			group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, 1, 0x000000, 0.02));
			group.addForceGenerator(new InverseAttractor(center.pos, 200));
			//			group.addForceGenerator(new RelativeAttractor(mousePos, -20, 30));

			removeChild(renderContext);
			
			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			center.pos.copy(mousePos);
			renderContext.graphics.clear();
			viewContext.graphics.clear();
			engine.update();
			if (lmb)
				bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);
		}
	}
}
