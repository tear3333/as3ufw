package org.rje.graphics.vector.brushes {
	import com.br.as3ufw.geom.Vector2D;

	import org.rje.graphics.vector.space.PointSpace;

	import flash.display.Graphics;

	/**
	 * @author Richard.Jewson
	 */
	public interface IBrush {

		function set pointSpace( points : PointSpace ) : void;

		function set graphicsContext( graphics : Graphics ) : void;

		function startStroke(point : Vector2D) : void;

		function doStroke(point : Vector2D) : void;

		function endStroke(point : Vector2D) : void;

		function draw(point : Vector2D, targetPoint : Vector2D, ageDelta : Number, dSqr : Number, dX : Number, dY : Number ) : void;
	}
}
