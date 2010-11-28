package as3ufw.physics.tests {
	import as3ufw.physics.AngularSpringConstraint;
	import as3ufw.geom.Vector2D;
	import as3ufw.physics.Particle;
	import as3ufw.physics.ParticleTestBase;
	import as3ufw.physics.Spring;
	import as3ufw.physics.forces.Attractor;
	import as3ufw.physics.forces.Forces;
	import as3ufw.physics.renderers.PointRenderer;
	import as3ufw.physics.renderers.SegmentCurveRenderer;

	import flash.display.BlendMode;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleTestM extends ParticleTestBase {
		private var invAttractor : Attractor;

		private var a:Particle;
		private var b:Particle;
		private var c:Particle;

		private var d:Particle;
		private var e:Particle;
		private var f:Particle;

		private var b1:Branch;
		private var b2:Branch;
		private var b3:Branch;
		private var b4:Branch;
		private var b5:Branch;
		private var b6:Branch;
		
		private var branches:Vector.<Branch>;

		public function ParticleTestM() {
			super();

			branches = new Vector.<Branch>();

			group.iterations = 5;
			group.damping = 0.8;
/*
			a = new Particle(new Vector2D(200,200));
			b = new Particle(new Vector2D(200,300));
			c = new Particle(new Vector2D(200,200));
			group.addParticle(a);
			group.addSpring(new AngularSpringConstraint(a, b, c, 10, 10, 0.01));
			//group.addParticle(b);
			//group.addParticle(c);
			//b.mass = Number.POSITIVE_INFINITY;
			//c.mass = Number.POSITIVE_INFINITY;

			d = new Particle(new Vector2D(200,100));
			e = new Particle(new Vector2D(200,100));
			//d.mass = 0.1;
			group.addParticle(d);
			group.addSpring(new AngularSpringConstraint(d, a, e, 10, 10, 0.01));
			
			//group.addSpring(new Spring(a, c, 1));
			//group.addSpring(new Spring(b, c, 1));
			 */
			renderContext.graphics.lineStyle(1,0);
			b1 = new Branch(group,null,100,0);
			b2 = new Branch(group,b1,40,40);
			b3 = new Branch(group,b1,90,-50);
			b4 = new Branch(group,b2,50,0);
			b5 = new Branch(group,b2,30,40);
			b6 = new Branch(group,b2,70,-40);
			
			engine.addForceGenerator(new Attractor(Forces.Uniform, mousePos, -200,100));
			
			group.addRenderer(new PointRenderer(renderContext.graphics, 4));
			
			start();
		}

		private function targetPos() : void {
			e.pos = a.pos.minus(b.pos).plus(d.pos);
		}


		override public function onEnterFrame(event : Event) : void {
			oldMousePos.copy(mousePos);
			mousePos.x = stage.mouseX;
			mousePos.y = stage.mouseY;

			// invAttractor

			renderContext.graphics.clear();
			
			//targetPos();
			b1.update();
			b2.update();
			b3.update();
			b4.update();
			b5.update();
			b6.update();
			b1.draw(renderContext.graphics);
			b2.draw(renderContext.graphics);
			b3.draw(renderContext.graphics);
			b4.draw(renderContext.graphics);
			b5.draw(renderContext.graphics);
			b6.draw(renderContext.graphics);
			//draw();
			
			viewContext.graphics.clear();
			engine.update();
		}

		private function draw() : void {
			
			with (renderContext.graphics) {
				lineStyle(1,0);
				moveTo(b.pos.x,b.pos.y);
				lineTo(a.pos.x,a.pos.y);
				lineTo(d.pos.x,d.pos.y);
			}
		}
	}
}
import flash.display.Graphics;
import as3ufw.physics.AngularSpringConstraint;
import as3ufw.geom.Vector2D;
import as3ufw.physics.Particle;
import as3ufw.physics.ParticleGroup;

class Branch {
	
	private var group : ParticleGroup;
	private var parent : Branch;
	private var length : Number;
	private var angle : Number;
	
	public var root : Particle;
	public var tip : Particle;
	public var rest : Particle;
	
	public var tipPos:Vector2D;
	
	public function Branch(group:ParticleGroup,parent:Branch,length:Number,angle:Number,tipMass:Number = 1) {
		this.group = group;
		this.parent = parent;
		this.length = length;
		this.angle = angle;
		initBranch();
	}

	private function initBranch() : void {
		
		if (!parent) {
			root = new Particle(new Vector2D(300,300));
		} else {
			root = parent.tip;
			
		}

		tipPos = new Vector2D(0,-length);
		tipPos = tipPos.rotate(angle).plus(root.pos);
		
		tip = new Particle(tipPos);
		group.addParticle(tip);
		rest = new Particle(tipPos);
		group.addSpring(new AngularSpringConstraint(tip, root, rest, 10, 10, 0.1));		
	}
	
	public function update():void {
		rest.pos.copy(targetTipPos());
	}
	
	
	private function targetTipPos():Vector2D {
		if (!parent) return rest.pos;
		var targetPos:Vector2D = parent.root.pos.minus(parent.tip.pos).normalize().mult(-length).rotate(angle);
		return root.pos.plus(targetPos);
	}
	
	public function draw(g:Graphics):void {
		g.lineStyle(1,0);
		g.moveTo(root.pos.x,root.pos.y);
		g.lineTo(tip.pos.x,tip.pos.y);
	}

}

