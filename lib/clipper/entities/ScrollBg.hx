package clipper.entities;

import awe6.interfaces.IKernel;
import awe6.core.Context;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Matrix;

import clipper.entities.ClipperEntity;
import clipper.share.Helper;
import clipper.share.Defines;

class ScrollBg extends ClipperEntity {
	var source_ : BitmapData = null;
	var bitmaps_ : Array<Bitmap> = null;
	var startX_ : Float = 0;
	var startY_ : Float = 0;
	var targetX_ : Float = 0;
	var targetY_ : Float = 0;
	var rows_ : Int = 0;
	var cols_ : Int = 0;
	var velocityX_ : Float = 0;
	var velocityY_ : Float = 0;
	var width_ : Float = 0;
	var height_ : Float = 0;

	public function new(	p_kernel : IKernel,
							bitmapData : BitmapData,
							x : Float,
							y : Float,
							width : Int,
							height : Int,
							velocityX : Float,
							velocityY : Float,
							?orientation : Orientation = null ) {
		source_ = bitmapData.clone();
		rows_ = Math.ceil( height / source_.height );
		cols_ = Math.ceil( width / source_.width );
		if( !Helper.isZero( velocityX ) ) {
			++cols_;
		}
		if( !Helper.isZero( velocityY ) ) {
			++rows_;
		}
		velocityX_ = velocityX;
		velocityY_ = velocityY;
		startX_ = x;
		startY_ = y;
		targetX_ = startX_;
		targetY_ = startY_;
		width_ = width;
		height_ = height;

		var context : Context = new Context();
		bitmaps_ = new Array<Bitmap>();
		for( i in 0 ... rows_ ) {
			for( j in 0 ... cols_ ) {
				var bitmap : Bitmap = new Bitmap();
				if( orientation != null ) {
					var matrix : Matrix = Helper.getMatrixWithOrientation( orientation, source_.width, source_.height );
					bitmap.bitmapData = new BitmapData( source_.width, source_.height );
					// bitmap.bitmapData.draw( source_, matrix, null, null, null, true );
					bitmap.bitmapData.draw( source_, matrix );
				} else {
					var matrix : Matrix;
					bitmap.bitmapData = source_;
				}
				// bitmap.x = startX_;
				// bitmap.y = startY_;
				context.addChild( bitmap );
				// bitmap.visible = false;
				bitmaps_.push( bitmap );
			}
		}
		// chopchop( true );
		updateBitmapsPosition();
		super( p_kernel, context );
	}

	override private function _updater( ?p_deltaTime:Int = 0 ) : Void {
		super._updater( p_deltaTime );
		updateBitmapsPosition();
		// chopchop();

		targetX_ += velocityX_ * p_deltaTime / 1000.0;
		targetY_ += velocityY_ * p_deltaTime / 1000.0;
	}

	// function chopchop( force : Bool = false ) : Void {
	// 	var targetBitmap : Bitmap = null;

	// 	// chop for x
	// 	if( !Helper.isZero( velocityX_ )  && !force ) {
	// 		for( i in 0 ... rows_ ) {
	// 			for( j in 1 ... cols_ ) {
	// 				if( velocityX_ > 0 ) {
	// 					// get the last bitmap of a row
	// 					targetBitmap = bitmaps_[i * cols_ + cols_ - j];
	// 					var targetWidth = ( startX_ + width_ ) - targetBitmap.x;
	// 					targetBitmap.width = source_.width;
	// 					if( targetWidth >= source_.width && targetBitmap.width > 0 ) {
	// 						break;
	// 					}
	// 					if( targetWidth < 0 ) {
	// 						targetWidth = 0;
	// 					}
	// 					if( targetWidth > source_.width ) {
	// 						targetWidth = source_.width;
	// 					}
	// 					targetBitmap.width = targetWidth;
	// 				} else {
	// 					targetBitmap = bitmaps_[i * cols_];
	// 				}
	// 			}
	// 		}
	// 	}

	// 	// chop for y
	// 	if( !Helper.isZero( velocityY_ )  && !force ) {
	// 		for( i in 0 ... cols_ ) {
	// 		}
	// 	}
	// }

	function updateBitmapsPosition() : Void {
		var targetBitmap : Bitmap = null;
		// check if x excess
		if( !Helper.isZero( velocityX_ ) ) {
			for( i in 0 ... rows_ ) {
				targetBitmap = bitmaps_[i*cols_];
				if( !Helper.isZero( Math.abs( targetBitmap.x - startX_ ) ) ) {
					if( velocityX_ > 0 ) {
						if( targetBitmap.x > startX_ ) {
							targetX_ = targetBitmap.x - source_.width;
						}
					} else {
						if( ( targetBitmap.x + targetBitmap.width ) < startX_ ) {
							targetX_ = startX_;
						}
					}
				}
			}
		}

		// check if y excess
		if( !Helper.isZero( velocityY_ ) ) {
			for( i in 0 ... cols_ ) {
				targetBitmap = bitmaps_[i];
				if( !Helper.isZero( Math.abs( targetBitmap.y - startY_ ) ) ) {
					if( velocityY_ > 0 ) {
						if( targetBitmap.y > startY_ ) {
							targetY_ = targetBitmap.y - source_.height;
						}
					} else {
						if( ( targetBitmap.y + targetBitmap.height ) < startY_ ) {
							targetY_ = startY_;
						}
					}
				}
			}
		}

		// set the positions
		for( i in 0 ... rows_ ) {
			for( j in 0 ... cols_ ) {
				targetBitmap = bitmaps_[i*cols_ + j];
				targetBitmap.x = Math.round(targetX_) + j * source_.width;
				targetBitmap.y = Math.round(targetY_) + i * source_.height;
			}
		}
	}
}