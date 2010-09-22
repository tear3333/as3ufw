package as3ufw.physics.tests {
	import as3ufw.physics.renderers.CircleRenderer;
	import as3ufw.physics.forces.InitialPositionAttractor;
	import as3ufw.physics.forces.RelativeAttractor;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.ParticleGroup;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestF extends ParticleTestBase {

		public var center : Particle;
		public var lines:int = 40;
		public var particlesPerLine:int = 20;

		public function ParticleTestF() {
			super();
			
			var pointRenderer:PointRenderer = new PointRenderer(graphics,3);
			var curveRenderer:CircleRenderer = new CircleRenderer(graphics,1);
			curveRenderer.join = false;
			
			for (var i : int = 0; i < lines; i++) {
				var lineGroup:ParticleGroup = new ParticleGroup();
				lineGroup.damping = 0.99;
				for (var j : int = 0;j < particlesPerLine;j++) {
					var pos:Vector2D = new Vector2D(j*30,i*10);
					var p:Particle = Particle.GetParticle(pos);
					lineGroup.addParticle(p);
				}
				//lineGroup.addRenderer(pointRenderer);
				lineGroup.addRenderer(curveRenderer);
				engine.addGroup(lineGroup);
			}
			
			engine.addForceGenerator(new RelativeAttractor(mousePos, -20, 100));
			engine.addForceGenerator(new InitialPositionAttractor(1.1));
			
			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			graphics.clear();
			engine.update();
			//bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);
		}
	}
}
