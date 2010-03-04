package taskTestSuite.tests {
	import org.flexunit.Assert;

	/**
	 * @author Richard.Jewson
	 */
	public class TestCase1 {

		[Test( description = "This tests addition" )]
		public function simpleAdd() : void {
			var x : int = 5 + 3;
			Assert.assertEquals(8, x);
		}
	}
}
