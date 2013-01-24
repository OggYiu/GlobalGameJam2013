package clipper.entities;

import awe6.interfaces.IKernel;
import awe6.core.Context;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.BlendMode;
import nme.geom.Matrix;

import clipper.entities.ClipperEntity;

class TiledSprite extends ClipperEntity {
	var source_ : BitmapData = null;
	var x_ : Int = 0;
	var y_ : Int = 0;

	public function new( p_kernel : IKernel, bitmapData : BitmapData, x : Int, y : Int, width : Int, height : Int ) {
		source_ = bitmapData.clone();
		x_ = x;
		y_ = y;

		var targetBitmapData = createTiledBitmapData( source_, width, height );

		var context : Context = new Context();
		var bitmap : Bitmap = new Bitmap( targetBitmapData );
		context.addChild( bitmap );
		bitmap.x = x_;
		bitmap.y = y_;
		// context.x = x_;
		// context.y = y_;
		super( p_kernel, context );
	}

	static public function createTiledBitmapData( source :BitmapData, width : Int, height : Int ) : BitmapData {
		var rows : Int = Math.ceil( height / source.height );
		var cols : Int = Math.ceil( width / source.width );
		var targetBitmapData = new BitmapData( width, height, true, 0x00000000 );
		for( i in 0 ... rows ) {
			for( j in 0 ... cols ) {
				var matrix : Matrix = new Matrix( 1, 0, 0, 1, 0, 0 );
				matrix.translate( j * source.width, i * source.height );
				targetBitmapData.draw( source, matrix, null );
			}
		}
		return targetBitmapData;
	}
}