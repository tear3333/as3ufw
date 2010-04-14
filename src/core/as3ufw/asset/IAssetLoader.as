package as3ufw.asset {

	/**
	 * @author Richard.Jewson
	 */
	public interface IAssetLoader {
		function cleanup() : void;

		function get content() : * ;

	}
}
