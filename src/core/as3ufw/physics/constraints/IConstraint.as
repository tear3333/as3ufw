package as3ufw.physics.constraints {
	/**
	 * @author richard.jewson
	 */
	public interface IConstraint {
		function resolve(iterationPercent:Number) : Boolean;
	}
}
