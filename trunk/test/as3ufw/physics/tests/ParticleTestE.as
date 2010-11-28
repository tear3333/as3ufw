package as3ufw.physics.tests {
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
	public class ParticleTestE extends ParticleTestBase {

		public var center : Particle;

		public function ParticleTestE() {
			super();
			group.damping = 0.8;
			
			var pos : Vector2D = new Vector2D(200, 200);
			center = Particle.GetParticle(pos);
			//group.addParticle(center);
			center.fixed = true;
			
			var points : int = 200;
			var mass1 : Number = 5.0;
			var mass2 : Number = 0.5;
			var baseMod : Number = 10.0;
			var partNum : Number = 100;
			
			for (var i : int = 0;i < points;i++) {
				var p : Particle = Particle.GetParticle(pos);

				p.mass = ((mass1 + i * mass2 + Math.random()) * baseMod) / partNum;

				group.addParticle(p);	
				
				var spring : Spring = new Spring(center, p, 1);
				group.addSpring(spring);
			}
			
			group.addRenderer(new PointRenderer(graphics, 3));
			group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, 1, 0x000000, 0.02));
			
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
			if (lmb)
				bmd.draw(renderContext, null, null, BlendMode.DARKEN, null, true);
		}
	}
}