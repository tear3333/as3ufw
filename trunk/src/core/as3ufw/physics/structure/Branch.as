package as3ufw.physics.structure {
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.AngularSpringConstraint;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleGroup;

	import flash.display.Graphics;

	/**
	 * @author richard.jewson
	 */
	public class Branch {
		private var group : ParticleGroup;
		private var parent : Branch;
		private var length : Number;
		private var angle : Number;
		public var root : Particle;
		public var tip : Particle;
		public var rest : Particle;
		public var tipPos : Vector2D;
		private var tipMass : Number;

		public function Branch(group : ParticleGroup, parent : Branch, length : Number, angle : Number, tipMass : Number = 1) {
			this.group = group;
			this.parent = parent;
			this.length = length;
			this.angle = angle;
			this.tipMass = tipMass;
			initBranch();
		}

		private function initBranch() : void {
			if (!parent) {
				root = new Particle(new Vector2D(300, 300));
			} else {
				root = parent.tip;
			}

			tipPos = new Vector2D(0, -length);
			tipPos = parent ? targetTipPos() : tipPos.rotate(angle).plus(root.pos);

			tip = new Particle(tipPos);
			tip.mass = tipMass;
			group.addParticle(tip);
			
			rest = new Particle(tipPos);
			
			group.addSpring(new AngularSpringConstraint(tip, root, rest, 10, 10, 0.1));
		}

		public function update() : void {
			rest.pos.copy(targetTipPos());
		}

		private function targetTipPos() : Vector2D {
			if (!parent) return rest.pos;
			var targetPos : Vector2D = parent.root.pos.minus(parent.tip.pos).normalize().mult(-length).rotate(angle);
			return root.pos.plus(targetPos);
		}

		public function draw(g : Graphics) : void {
			g.lineStyle(1, 0);
			g.moveTo(root.pos.x, root.pos.y);
			g.lineTo(tip.pos.x, tip.pos.y);
		}
	}
}
