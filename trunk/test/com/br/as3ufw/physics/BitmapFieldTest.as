package com.br.as3ufw.physics {
	import flash.geom.Rectangle;
	import com.br.as3ufw.physics.emitters.RectangularRandomEmitter;
	import com.br.as3ufw.physics.forces.field.BitmapField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	[SWF(width=500, height=500, backgroundColor=0x000000)]

	/**
	* Tests the different settings available in BitmapData's perlinNoise() method.
	*/
	public class BitmapFieldTest extends Sprite {

		private static const BASE_X:Number = 200;
		private static const BASE_Y:Number = 200;
		private static const NUM_OCTAVES:Number = 2;
		private static const RANDOM_SEED:Number = Number(new Date());
		private static const STITCH:Boolean = false;
		private static const FRACTAL:Boolean = true;
		private static const CHANNELS:uint = BitmapDataChannel.RED | BitmapDataChannel.GREEN | BitmapDataChannel.BLUE;
		private static const GRAYSCALE:Boolean = false;
		private static const OFFSET_X_RATE:Number = 0.5;
		private static const OFFSET_Y_RATE:Number = 0;//5;

		private var _bitmapData:BitmapData;
		private var _offsets:Array;

		private var _engine:ParticleEngine;
		private var _particleLayer:Sprite;

		private var e:RectangularRandomEmitter;

		public function BitmapFieldTest() {
			_bitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
			_offsets = [];
			for (var i:uint = 0; i < NUM_OCTAVES; i++) {
				_offsets.push(new Point());
			}
			makePerlinNoise();
			var bm:Bitmap = new Bitmap(_bitmapData);
			//bm.height /=4;
			addChild(bm);
			_particleLayer = new Sprite();
			addChild(_particleLayer);
			setupParticles();
			addEventListener(Event.ENTER_FRAME, onSpriteEnterFrame);
		}

		private function setupParticles():void {
			
			_engine = new ParticleEngine();
			_engine.damping = 0.99;
			//_engine.graphics = _particleLayer.graphics;
			var group:ParticleGroup = new ParticleGroup();
			_engine.addGroup(group);
			e = new RectangularRandomEmitter(new Rectangle(0,0,stage.width,stage.height));
			e.group = group;
			for (var i : int = 0; i < 100; i++) {
				e.emit(null);
			}
			var bitmapField:BitmapField = new BitmapField(_bitmapData,0,0,1);
			_engine.addForceGenerator(bitmapField);
			
		}


		private function makePerlinNoise():void {
			_bitmapData.perlinNoise(
				BASE_X,
				BASE_Y,
				NUM_OCTAVES,
				RANDOM_SEED,
				STITCH,
				FRACTAL,
				CHANNELS,
				GRAYSCALE,
				_offsets
				);
		}

		private function onSpriteEnterFrame(event:Event):void {
			e.emit(null);
			_particleLayer.graphics.clear();
			_engine.update();
//			var point:Point;
//			var direction:int;
//			for (var i:uint = 0; i < NUM_OCTAVES; i++) {
//				point = _offsets[i] as Point;
//				direction = (i%2==0) ? -1 : 1;
//				point.x += OFFSET_X_RATE/(NUM_OCTAVES-i)*direction;
//				point.y += OFFSET_Y_RATE/(NUM_OCTAVES-i)*direction;
//			}
//			makePerlinNoise();
		}

	}

}