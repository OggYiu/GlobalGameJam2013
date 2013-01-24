package clipper.share;

class TilePosition {
	var x_ : Int;
	var y_ : Int;
	var cols_ : Int;
	var rows_ : Int;
	var tileSize_ : Int;

	public var x( getX, setX ) : Int;
	public var y( getY, setY ) : Int;
	public var tileSize( getTileSize, null ) : Int;

	public function new( cols:Int, rows:Int, tileSize:Int, x:Int, y:Int ) {
		x_ = x;
		y_ = y;
		cols_ = cols;
		rows_ = rows;
		tileSize_ = tileSize;
	}

	public function setWithScreenPosition( x:Float, y:Float ) : Void {
		x_ = Std.int( Math.floor( x / tileSize_ ) );
		y_ = Std.int( Math.floor( y / tileSize_ ) );

		if( !isValid( x_, y_ ) ) {
			Debug.Assert( false, "<TilePosition::setWithScreenPosition>, invalid position detected!" );
		}
	}

	public function isValid( x:Int, y:Int ) : Bool {
		return ( x >= 0 && y >= 0 && x < cols_ && y < rows_ );
	}

	// set and get
	function getX() : Int {
		return x_;
	}

	function setX( x:Int ) : Int {
		x_ = x;
		return x_;
	}

	function getY() : Int {
		return y_;
	}

	function setY( y:Int ) : Int {
		y_ = y;
		return y_;
	}

	function getTileSize() : Int {
		return tileSize_;
	}
}