package as3ufw.physics.tests {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.forces.InitialPositionAttractor;
	import as3ufw.physics.renderers.BitmapRenderer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestC extends ParticleTestBase {
		private var gap : int = 1;
		private var bitmapData : BitmapData;
		private var bitmap : Bitmap;

		public function ParticleTestC() {
			super();

			bitmapData = new BitmapData(600, 600, false, 0xFFFFFF);
			bitmap = new Bitmap(bitmapData);
			addChild(bitmap);

			// group.addRenderer(new PointRenderer(graphics, 1));
			group.damping = 0.9;
			group.addRenderer(new BitmapRenderer(bitmapData));

			group.addForceGenerator(new InitialPositionAttractor(Forces.Uniform,10));

			for (var i : int = 0; i < 100; i++) {
				for (var j : int = 0; j < 50; j++) {
					group.addParticle(Particle.GetParticle(new Vector2D((i * gap) + 100, (j * gap) + 100)));
				}
			}

			group.addForceGenerator(new Attractor(Forces.Uniform, mousePos, 20, 20));

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			bitmapData.fillRect(bitmapData.rect, 0xFFFFFF);
			// bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(0,0), new BlurFilter(1.1,1.1))
			engine.update();
		}
	}
}
