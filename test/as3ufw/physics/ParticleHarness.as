package as3ufw.physics {
	import as3ufw.physics.tests.ParticleTestE;
	import as3ufw.physics.tests.ParticleTestD;
	import as3ufw.physics.tests.ParticleTestC;
	import as3ufw.physics.tests.ParticleTestB;
	import as3ufw.physics.tests.ParticleTestA;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;

	/**
	 * @author Richard.Jewson
	 */
	public class ParticleHarness extends Sprite {
		
		private var tests:Array = [ParticleTestA,ParticleTestB,ParticleTestC,ParticleTestD,ParticleTestE];
		private var testIndex:int = 0;
		private var currentTest:Sprite;
		
		public function ParticleHarness() {
			init();
		}

		private function init() : void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			runTest(testIndex);
		}

		private function onKeyDown(event : KeyboardEvent) : void {
			switch (event.keyCode) {
				case Keyboard.LEFT:prevTest();break;
				case Keyboard.RIGHT:nextTest();break;
			}
		}

		private function runTest(index:int):void {
			var clazz:Class = tests[index];
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
			if (testIndex == -1) testIndex = tests.length-1;
			runTest(testIndex);
		}
	}
}
