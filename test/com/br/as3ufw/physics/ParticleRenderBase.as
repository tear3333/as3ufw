package com.br.as3ufw.physics {
	import com.br.as3ufw.physics.forces.RelativeAttractor;
	import com.br.as3ufw.geom.Vector2D;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleRenderBase extends Sprite {

		[SWF(width=500, height=500, backgroundColor=0x000000)]

		private var _engine : ParticleEngine;
		private var _particleLayer : Sprite;
		private var _group : ParticleGroup;
		
		public function ParticleRenderBase() {
			_particleLayer = new Sprite();
			addChild(_particleLayer);

			_engine = new ParticleEngine();
			_engine.damping = 0.99;
			//_engine.graphics = _particleLayer.graphics;
			_group = new ParticleGroup();
			
			_group.addParticle(new Particle(new Vector2D(120,100)));
			_group.addParticle(new Particle(new Vector2D(200,250)));
			_group.addParticle(new Particle(new Vector2D(320,300)));
			_group.addParticle(new Particle(new Vector2D(400,410)));
			
			_engine.addForceGenerator(new RelativeAttractor(new Vector2D(250,250), 1, 300));
			
			_engine.addGroup(_group);
			
			addEventListener(Event.ENTER_FRAME, onSpriteEnterFrame);
		}

		private function onSpriteEnterFrame(event : Event) : void {
			_particleLayer.graphics.clear();
			_engine.update();
			_group.renderCurveLine(_particleLayer.graphics, 1, 0x000000, 1);
		}		
	}
}
