package firerice.core.motionwelder;

class Debug {
	public function new() {
	}

	public static function Log( msg:String ) {
		trace( msg );
	}

	public static function Assert( condition:Bool, msg:String ) {
		if( !condition ) {
			// trace( msg );
			throw msg;
		}
	}
}