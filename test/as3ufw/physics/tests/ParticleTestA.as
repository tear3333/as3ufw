package as3ufw.physics.tests {
	import org.rje.graphics.vector.brushes.BrushParams;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.emitters.PointEmitter;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.renderers.JoinedCurveRenderer;
	import as3ufw.utils.Random;

	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestA extends ParticleTestBase {
		public var emitter : PointEmitter;

		public function ParticleTestA() {
			super();
			emitter = new PointEmitter();
			emitter.position = new Vector2D(300, 200);
			emitter.velocity = 1;

			group.addEmitter(emitter);
			group.addRenderer(new JoinedCurveRenderer(renderContext.graphics, new BrushParams(1,3)));
			// group.addRenderer(new PointRenderer(graphics,3));

			group.addForceGenerator(new Attractor(Forces.Uniform, mousePos, 20, 20));

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;

			renderContext.graphics.clear();
			emitter.angle += Random.float(0.45, 0.55);
			emitter.velocity = Random.float(0.95, 1.05);
			emitter.emit({ttl:10000});
			engine.update();
		}
	}
}
