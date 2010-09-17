package as3ufw.physics.tests {
	import as3ufw.physics.renderers.CircleRenderer;
	import as3ufw.physics.renderers.CurveRenderer;
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
	public class ParticleTestD extends ParticleTestBase {
		public function ParticleTestD() {
			super();
			
			var center:Particle = Particle.GetParticle(new Vector2D(200,200));
			center.fixed = true;
			//group.addParticle(center);	
			var first:Particle;
			var last:Particle;
			var firstPos:Vector2D = new Vector2D(200,200);
			
			var points:int = 8;
			
			for (var i : int = 0; i < points; i++) {
				var pos:Vector2D = new Vector2D(100,0);
				
				pos.angle = ( -2 * Math.PI * i) / (points);
				pos.plusEquals(firstPos);
				var p:Particle = Particle.GetParticle(pos);
				group.addParticle(p);	
				if (i==0) first = p;
				
				var spring:Spring = new Spring(center, p,0.02);
				group.addSpring(spring);

				if (last) {
					 group.addSpring(new Spring(last,p,0.4));
				}

				last = p;
			}
			group.addSpring(new Spring(last,first,0.4));
			
			group.addRenderer(new PointRenderer(graphics,3));
			group.addRenderer(new CircleRenderer(graphics,3));
			
			group.addForceGenerator(new RelativeAttractor(mousePos, -20, 30));
			
			start();
		}
		
		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			graphics.clear();
			engine.update();
		}
	}
}
