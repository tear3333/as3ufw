package as3ufw.physics.tests {
	import as3ufw.utils.Random;
	import as3ufw.physics.Spring;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.forces.InitialPositionAttractor;
	import as3ufw.physics.forces.RelativeAttractor;
	import as3ufw.physics.renderers.ContinuousCurveRenderer;
	import as3ufw.physics.renderers.PointRenderer;

	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestJ extends ParticleTestBase {

		public var center : Particle;
		public var lines : int = 1;
		public var particlesPerLine : int = 5;
		public var lineWidth : int = 600;
		public var lineHeight : int = 200;

		public function ParticleTestJ() {
			super();
			
			var pointRenderer : PointRenderer = new PointRenderer(renderContext.graphics, 3);
			var curveRenderer : ContinuousCurveRenderer = new ContinuousCurveRenderer(renderContext.graphics, 1);
			curveRenderer.join = false;
			
			for (var i : int = 0;i < lines;i++) {
				var lineGroup : ParticleGroup = new ParticleGroup();
				lineGroup.damping = 1;
				var first:Particle = null;
				var last:Particle = null;
				
				for (var j : int = 0;j < particlesPerLine;j++) {
					var pos : Vector2D = new Vector2D(j * (lineWidth/particlesPerLine), lineHeight + Random.float(-100, 100));
					var p : Particle = Particle.GetParticle(pos);
					if (j==0 ) {
						first = p;
						p.fixed = true;
						p.pos.y = lineHeight;
					} else if (j==particlesPerLine-1)
						p.fixed = true;
						p.pos.y = lineHeight;
					if (last) {
						var spring : Spring = new Spring(last, p, 0.05);
						group.addSpring(spring);
						//spring = new Spring(first, p, 0.05);
						//group.addSpring(spring);
					}
					lineGroup.addParticle(p);
					last = p;
				}
				lineGroup.addRenderer(pointRenderer);
				lineGroup.addRenderer(curveRenderer);
				engine.addGroup(lineGroup);
			}
			
			engine.addForceGenerator(new RelativeAttractor(mousePos, 10, 50));
			//engine.addForceGenerator(new InitialPositionAttractor(0.1));
			
			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			renderContext.graphics.clear();
			engine.update();
			//bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);
		}
	}
}
