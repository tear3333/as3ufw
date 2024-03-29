package as3ufw.physics {
	import as3ufw.physics.tests.ParticleTestT;
	import as3ufw.physics.tests.ParticleTestS;
	import as3ufw.physics.tests.ParticleTestR;
	import as3ufw.physics.tests.ParticleTestQ;
	import as3ufw.physics.tests.ParticleTestP;
	import as3ufw.physics.tests.ParticleTestO;
	import as3ufw.physics.tests.ParticleTestN;
	import as3ufw.physics.tests.ParticleTestM;
	import as3ufw.physics.tests.ParticleTestA;
	import as3ufw.physics.tests.ParticleTestB;
	import as3ufw.physics.tests.ParticleTestC;
	import as3ufw.physics.tests.ParticleTestD;
	import as3ufw.physics.tests.ParticleTestE;
	import as3ufw.physics.tests.ParticleTestF;
	import as3ufw.physics.tests.ParticleTestG;
	import as3ufw.physics.tests.ParticleTestH;
	import as3ufw.physics.tests.ParticleTestI;
	import as3ufw.physics.tests.ParticleTestJ;
	import as3ufw.physics.tests.ParticleTestK;
	import as3ufw.physics.tests.ParticleTestL;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleHarness extends Sprite {
		private var tests : Array = [ParticleTestI,ParticleTestT,ParticleTestS,ParticleTestR,ParticleTestQ,ParticleTestP,ParticleTestO,ParticleTestN,ParticleTestM, ParticleTestL, ParticleTestK, ParticleTestJ, ParticleTestI, ParticleTestH, ParticleTestG, ParticleTestF, ParticleTestE, ParticleTestD, ParticleTestC, ParticleTestB, ParticleTestA];
		// private var testIndex:int = 6;
		private var testIndex : int = 0;
		private var currentTest : Sprite;

		public function ParticleHarness() {
			init();
		}

		private function init() : void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			runTest(testIndex);
		}

		private function onKeyDown(event : KeyboardEvent) : void {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					prevTest();
					break;
				case Keyboard.RIGHT:
					nextTest();
					break;
			}
		}

		private function runTest(index : int) : void {
			var clazz : Class = tests[index];
			if (currentTest) {
				removeChild(currentTest);
			}
			currentTest = Sprite(addChild(new clazz()));
		}

		private function nextTest() : void {
			testIndex++;
			if (testIndex == tests.length) testIndex = 0;
			runTest(testIndex);
		}

		private function prevTest() : void {
			testIndex--;
			if (testIndex == -1) testIndex = tests.length - 1;
			runTest(testIndex);
		}
	}
}
