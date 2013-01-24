package firerice.game;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class SpriteFound extends Sprite
{
	public function new( x : Float, y : Float, width : Int, height : Int, isFound : Bool = true ) 
	{
		super();
		
		var imgPath : String = isFound? "assets/game/check.png" : "assets/game/cross.png";
		var bitmapData : BitmapData = Assets.getBitmapData( imgPath );
		var bitmap : Bitmap = new Bitmap( bitmapData );
		var size : Int = width > height? width : height;
		//bitmap.width = size;
		//bitmap.height = size;
		bitmap.width = width;
		bitmap.height = height;
		this.x = x;
		this.y = y;
		this.addChild( bitmap );
	}
	
}