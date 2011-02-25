package as3ufw.physics.tests {
	import org.rje.graphics.vector.brushes.BrushParams;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.emitters.PointEmitter;
	import as3ufw.physics.renderers.JoinedCurveRenderer;

	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestB extends ParticleTestBase {

		public var emitter : PointEmitter;

		public function ParticleTestB() {
			super();
			emitter = new PointEmitter();
			emitter.position = new Vector2D(300, 200);
			emitter.velocity = 1;
			
			group.addEmitter(emitter);
			group.addRenderer(new JoinedCurveRenderer(renderContext.graphics, new BrushParams(1,1)));
			//group.addRenderer(new PointRenderer(graphics,4));

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			renderContext.graphics.clear();
			emitter.angle += 1;
			emitter.emit({ttl:10000});
			engine.update();
		}
	}
}
