package as3ufw.physics.forces.field {
	import as3ufw.geom.Vector2D;

	import flash.display.BitmapData;

	import as3ufw.physics.Particle;
	import as3ufw.physics.forces.AbstractForce;
	import as3ufw.physics.forces.IForceGenerator;

	/**
	 * @author Richard.Jewson
	 */
	public class BitmapField extends AbstractForce implements IForceGenerator {

		private var _bitmapData : BitmapData;
		private var x : Number;
		private var y : Number;
		private var max : Number;
		private var channelX : uint;
		private var channelY : uint;

		public var tiled : Boolean;
		public var scaleX : Number;
		public var scaleY : Number;

		
		public function BitmapField(bitmapData : BitmapData,x : Number = 0, y : Number = 0, max : Number = 1, channelX : uint = 1, channelY : uint = 2) {
			this._bitmapData = bitmapData;
			this.x = x;
			this.y = y;
			this.max = max;
			this.channelX = channelX;
			this.channelY = channelY;
			this.tiled = true;
			this.scaleX = 1;
			this.scaleY = 1;
		}

		override public function applyForce(targetParticles : Particle) : void {
			if (!active) return;
			var particle : Particle = targetParticles;
			while (particle) {
				var px : Number = x + (particle.pos.x / scaleX);
				var py : Number = y + (particle.pos.y / scaleY);
	                        
				if (tiled) {
					px = px % _bitmapData.width;
					py = py % _bitmapData.height;
				} else {
					if ((px < 0) || (px >= _bitmapData.width) || (py < 0) || (py >= _bitmapData.height))
						return;
				}
	                        
				var colour:uint = _bitmapData.getPixel(int(px), int(py));
				var force:Vector2D = new Vector2D();
				switch (channelX) {
					case 1:
						force.x = 2 * ((((colour & 0xFF0000) >> 16) / 255) - 0.5) * max;
						break;
					case 2:
						force.x = 2 * ((((colour & 0x00FF00) >> 8) / 255) - 0.5) * max;
						break;
					case 4:
						force.x = 2 * (((colour & 0x0000FF) / 255) - 0.5) * max;
						break;
				}
	                        
				switch (channelY) {
					case 1:
						force.y = 2 * ((((colour & 0xFF0000) >> 16) / 255) - 0.5) * max;
						break;
					case 2:
						force.y = 2 * ((((colour & 0x00FF00) >> 8) / 255) - 0.5) * max;
						break;
					case 4:
						force.y = 2 * (((colour & 0x0000FF) / 255) - 0.5) * max;
						break;
				}
	                        
				particle.addForce(force);
				particle = particle.next;
			}
		}

		public function set bitmapData(bitmapData : BitmapData) : void {
			_bitmapData = bitmapData;
		}
	}
}