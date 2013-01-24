package firerice.core.motionwelder;
import nme.display.BitmapData;

/**
 * ...
 * @author oggyiu
 */

class MFrameImage {
	public var bitmapdata : BitmapData;
	public var xPos : Int;
	public var yPos : Int;
	public var observer : Int;

	public function new(p_bitmapdata : BitmapData,
						p_xPos : Int,
						p_yPos : Int,
						p_observer : Int ) {
		bitmapdata = p_bitmapdata;
		xPos = p_xPos;
		yPos = p_yPos;
		observer = p_observer;
	}

	public function log( append : String ) : Void {
		trace( append + "\t/////////MFrameImage" );
		trace( append + "\tbitmapdata: " + bitmapdata );
		trace( append + "\tbitmap.width: " + bitmapdata.width );
		trace( append + "\tbitmap.height: " + bitmapdata.height );
		trace( append + "\txPos: " + xPos );
		trace( append + "\tyPos: " + yPos );
		trace( append + "\tobserver: " + observer );
	}
}