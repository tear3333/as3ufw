package as3ufw.physics.tests {
	import flash.geom.Rectangle;
	import as3ufw.physics.emitters.RectangularRandomEmitter;
	import flash.display.BlendMode;
	import as3ufw.physics.renderers.SegmentCurveRenderer;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.forces.Gravity;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.physics.renderers.TestPathRenderer;
	import as3ufw.utils.Random;

	import org.rje.graphics.vector.brushes.BrushParams;

	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestI extends ParticleTestBase {

		public function ParticleTestI() {
			super();

			group.damping = 1;
			var emitter:RectangularRandomEmitter = new RectangularRandomEmitter(group,new Rectangle(0,0,600,400));
			for (var i : int = 0; i < 50; i++) {
				emitter.emit();
			}
			group.addRenderer(new PointRenderer(viewContext.graphics, new BrushParams(1, 2)));
			group.addRenderer(new SegmentCurveRenderer(renderContext.graphics, new BrushParams(0.1, 1)));
			group.addForceGenerator(new Gravity());

			start();
		}

		override public function onEnterFrame(event : Event) : void {
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;
			renderContext.graphics.clear();
			viewContext.graphics.clear();
			engine.update();
			bmd.draw(renderContext, null, null, BlendMode.NORMAL, null, true);
		}
	}
}
