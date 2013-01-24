package clipper.share;

import clipper.share.TilePosition;

class TransformComponent {
	var directionX_ : Float = 0;
	var directionY_ : Float = 0;
	var directionZ_ : Float = 0;
	var x_ : Float = 0;
	var y_ : Float = 0;
	var z_ : Float = 0;

	public var x( getX, setX ) : Float;
	public var y( getY, setY ) : Float;
	public var z( getZ, setZ ) : Float;
	public var dirX( getDirX, setDirX ) : Float;
	public var dirY( getDirY, setDirY ) : Float;
	public var dirZ( getDirZ, setDirZ ) : Float;
	public var pos( getPosition, setPosition ) : Dynamic;
	public var dir( getDirection, setDirection ) : Dynamic;

	public function new( x:Float=0, y:Float=0, z:Float=0 ) {
		// super();
		 x_ = x;
		 y_ = y;
		 z_ = z;
	}

	// public function setWithTilePosition( tilePos:TilePosition ) : Void {
	// 	x_ = tilePos.x * tilePos.tileSize;
	// 	y_ = tilePos.y * tilePos.tileSize;
	// 	// z_ = z;
	// }

	function getPosition() : Dynamic {
		var output : Dynamic = { x:x_, y:y_, z:z_ };
		return output;
	}
	
	function setPosition( value : Dynamic ) : Dynamic {
		x_ = value.x;
		y_ = value.y;
		z_ = value.z;

		return value;
	}

	function setDirection( value : Dynamic ) : Dynamic {
		directionX_ = value.x;
		directionY_ = value.y;
		directionZ_ = value.z;
		return value;
	}

	function getDirection() : Dynamic {
		// var diffx : Float = x_ - lastX_;
		// var diffy : Float = y_ - lastY_;
		// var diffz : Float = z_ - lastZ_;

		// var max_value : Float = 0;
		// max_value = Math.max( Math.abs(diffx), Math.abs(diffy) );
		// max_value = Math.max( max_value, Math.abs(diffz) );

		// var output : Dynamic = { x:0, y:0, z:0 };
		// // trace( "max_value: " + max_value );
		// if( max_value >= Helper.MIN_FLOAT ) {
		// // trace( "max_value 1" );
		// 	lastDirectionX_ = output.x = diffx / max_value;
		// 	lastDirectionY_ = output.y = diffy / max_value;
		// 	lastDirectionZ_ = output.z = diffz / max_value;
		// } else  {
		// 	output.x = lastDirectionX_;
		// 	output.y = lastDirectionY_;
		// 	output.z = lastDirectionZ_;
		// }

		var output : Dynamic = { x:directionX_, y:directionY_, z:directionZ_ };
		return output;
	}

	// get and set
	function getX() : Float {
		return x_;
	}

	function setX( x:Float ) : Float {
		x_ = x;
		return x_;
	}

	function getY() : Float {
		return y_;
	}

	function setY( y:Float ) : Float {
		y_ = y;
		return y_;
	}

	function getZ() : Float {
		return z_;
	}

	function setZ( z:Float ) : Float {
		z_ = z;
		return z_;
	}

	function getDirX() : Float {
		return directionX_;
	}

	function setDirX( value:Float ) : Float {
		directionX_ = value;
		return directionX_;
	}

	function getDirY() : Float {
		return directionY_;
	}

	function setDirY( value:Float ) : Float {
		directionY_ = value;
		return directionY_;
	}

	function getDirZ() : Float {
		return directionZ_;
	}

	function setDirZ( value:Float ) : Float {
		directionZ_ = value;
		return directionZ_;
	}
}