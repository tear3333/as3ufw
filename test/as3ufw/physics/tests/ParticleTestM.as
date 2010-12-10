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

			group.iterations = 7;
			group.damping = 0.6;

			renderContext.graphics.lineStyle(1, 0);
			
			var leafBranchIndexes:Array = [];
			
			var trunk0 : Branch = new Branch(group, null, 80, 0, 2);
			branches.push(trunk0);
			var trunk1:Branch = new Branch(group, trunk0, 20, 355, 2, 0.99);
			branches.push(trunk1);
			var trunk2:Branch = new Branch(group, trunk1, 45, 0, 2, 0.99);
			branches.push(trunk2);
			
			var left1:Branch = new Branch(group, trunk0, 80, 310, 1.5);
			branches.push(left1);
			branches.push(new Branch(group, left1, 80, 320, 1.5));
			leafBranchIndexes.push(branches.length-1);
			branches.push(new Branch(group, left1, 60, 0, 1.5));
			leafBranchIndexes.push(branches.length-1);
			branches.push(new Branch(group, left1, 50, 40, 1.5));
			leafBranchIndexes.push(branches.length-1);
			
			var left3:Branch = new Branch(group, trunk1, 60, 340, 1.5,0.99);
			branches.push(left3);
			branches.push(new Branch(group, left3, 60, 320, 1.5));
			var left32:Branch = new Branch(group, left3, 20, 40, 0.5,0.99);
			branches.push(left32);
			branches.push(new Branch(group, left32, 70, 300, 0.5));
			leafBranchIndexes.push(branches.length-1);
			branches.push(new Branch(group, left32, 30, 25, 0.5));
			leafBranchIndexes.push(branches.length-1);
			
			var right2:Branch = new Branch(group, trunk1, 60, 70, 1.5);
			branches.push(right2);		
			var right21:Branch = new Branch(group, right2, 30, 300, 1.5);
			branches.push(right21);		
			branches.push(new Branch(group, right21, 30, 0, 0.5));
			leafBranchIndexes.push(branches.length-1);
			branches.push(new Branch(group, right21, 40, 45, 0.5));
			leafBranchIndexes.push(branches.length-1);

			branches.push(new Branch(group, right2, 60, 0, 0.5));
			leafBranchIndexes.push(branches.length-1);
			branches.push(new Branch(group, right2, 70, 40, 0.5));
			leafBranchIndexes.push(branches.length-1);

			var right3:Branch = new Branch(group, trunk1, 60, 20, 1.5,2);
			branches.push(right3);					
			var right30:Branch = new Branch(group, right3, 20, 350, 1.5,2);
			branches.push(right30);					
			var right31:Branch = new Branch(group, right3, 50, 320, 1.5);
			branches.push(right31);					
			
			branches.push(new Branch(group, right30, 60, 345, 0.5));
			leafBranchIndexes.push(branches.length-1);
			branches.push(new Branch(group, right30, 60, 30, 0.5));
			leafBranchIndexes.push(branches.length-1);
			
			var count:int = 0;
			for each (var index : int in leafBranchIndexes) {
				addLeafs(branches[index],25);
				count += 25;		
			}
			trace(count);
			
			//addLeafs(branches[1],20);		
			//addLeafs(branches[2],20);		
			//addLeafs(branches[3],20);		
			//addLeafs(branches[4],15);		
			//addLeafs(branches[5],10);		

			engine.addForceGenerator(new Attractor(Forces.Relative, mousePos, -100, 100));

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


