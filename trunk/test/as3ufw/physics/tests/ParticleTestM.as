package as3ufw.physics.tests {
	import as3ufw.utils.Random;
	import as3ufw.physics.RelativeParticle;
	import as3ufw.physics.RelativeParticleGroup;
	import as3ufw.physics.structure.Branch;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.renderers.PointRenderer;

	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestM extends ParticleTestBase {
		
		private var branches : Vector.<Branch>;
		private var brancheRelativeGroups : Vector.<RelativeParticleGroup>;

		public function ParticleTestM() {
			super();

			branches = new Vector.<Branch>();
			brancheRelativeGroups = new Vector.<RelativeParticleGroup>();

			group.iterations = 5;
			group.damping = 0.8;

			renderContext.graphics.lineStyle(1, 0);
			branches.push(new Branch(group, null, 100, 0, 2));
			branches.push(new Branch(group, branches[0], 40, 40, 1.5));
			branches.push(new Branch(group, branches[0], 90, -50, 1.5));
			branches.push(new Branch(group, branches[1], 50, 0));
			branches.push(new Branch(group, branches[1], 30, 40));
			branches.push(new Branch(group, branches[1], 70, -40));

			//addLeafs(branches[1],20);		
			addLeafs(branches[2],20);		
			addLeafs(branches[3],20);		
			addLeafs(branches[4],15);		
			addLeafs(branches[5],10);		

			engine.addForceGenerator(new Attractor(Forces.Relative, mousePos, -200, 100));

			group.addRenderer(new PointRenderer(renderContext.graphics, 4));

			start();
		}

		private function addLeafs(branch:Branch, count:int) : void {
			var relativeGroup:RelativeParticleGroup = new RelativeParticleGroup(branch.root, branch.tip);
			
			for (var i : int = 0; i < count; i++) {
				relativeGroup.attachParticle(new RelativeParticle( Random.float(0.4, 1.4), Random.float(-25,25)));
			}

			brancheRelativeGroups.push(relativeGroup);
		}


		override public function onEnterFrame(event : Event) : void {
			oldMousePos.copy(mousePos);
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;

			renderContext.graphics.clear();
			viewContext.graphics.clear();
			engine.update();

			for each (var branch : Branch in branches) {
				branch.update();
				branch.draw(renderContext.graphics);
			}

			for each (var branchRelGroup : RelativeParticleGroup in brancheRelativeGroups) {
				branchRelGroup.resolve();
				branchRelGroup.render(renderContext.graphics);
			}
			

		}
	}
}


