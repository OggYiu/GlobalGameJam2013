package firerice.ui;
import firerice.components.SpriteComponent;
import firerice.core.Entity;
import firerice.common.Helper;
import firerice.core.Process;
import firerice.interfaces.IEntityCollection;
import firerice.types.EOrientation;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.geom.Matrix;

class UIScrollBg extends Entity {
	var source_ : BitmapData = null;
	//var bitmaps_ : Array<Bitmap> = null;
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
	
	public function new(	p_id : String,
							p_parent : IEntityCollection,
							p_bitmapData : BitmapData,
							x : Float,
							y : Float,
							width : Int,
							height : Int,
							velocityX : Float,
							velocityY : Float,
							?orientation : EOrientation = null ) {
		super( p_id, p_parent ) ;
		
		var spriteComponent : SpriteComponent;
		
		source_ = p_bitmapData.clone();
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

		//bitmaps_ = new Array<Bitmap>();
		var bitmapDataCollection : Array<BitmapData> = new Array<BitmapData>();
		for( i in 0 ... rows_ ) {
			for( j in 0 ... cols_ ) {
				//var bitmap : Bitmap = new Bitmap();
				var bitmapData : BitmapData = null;
				if( orientation != null ) {
					var matrix : Matrix = Helper.getMatrixWithOrientation( orientation, source_.width, source_.height );
					bitmapData = new BitmapData( source_.width, source_.height );
					// bitmap.bitmapData.draw( source_, matrix, null, null, null, true );
					bitmapData.draw( source_, matrix );
				} else {
					var matrix : Matrix;
					bitmapData = source_;
				}
				bitmapDataCollection.push( bitmapData );
				// bitmap.x = startX_;
				// bitmap.y = startY_;
				this.context.addChild( new Bitmap( bitmapData ) );
				//l_context.addChild( bitmap );
				// bitmap.visible = false;
				//bitmaps_.push( bitmap );
			}
		}

		
		// for ( bitmapData in bitmapDataCollection ) {
		// 	var bitmap : Bitmap = new Bitmap( bitmapData );
		// 	// bitmapCollection.push( bitmap );
		// 	this.context.addChild( bitmap );
		// }
		
		// chopchop( true );
		updateBitmapsPosition();
	}

	override private function update_(dt:Float):Void 
	{
		super.update_(dt);
	
		updateBitmapsPosition();
		// chopchop();

		targetX_ += velocityX_ * dt;
		targetY_ += velocityY_ * dt;
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
		var spriteComponent : SpriteComponent = cast ( this.getComponent( SpriteComponent.ID ), SpriteComponent );
		
		// check if x excess
		if( !Helper.isZero( velocityX_ ) ) {
			for( i in 0 ... rows_ ) {
				targetBitmap = spriteComponent.bitmapCollection[i*cols_];
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
				targetBitmap = spriteComponent.bitmapCollection[i];
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
				targetBitmap = spriteComponent.bitmapCollection[i*cols_ + j];
				targetBitmap.x = Math.round(targetX_) + j * source_.width;
				targetBitmap.y = Math.round(targetY_) + i * source_.height;
			}
		}
	}
}