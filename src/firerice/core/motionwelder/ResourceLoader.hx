package firerice.core.motionwelder;

import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.display.BlendMode;
import nme.Assets;
import nme.geom.Matrix;
import nme.geom.Rectangle;

// import awe6.core.Context;
/**
 * Resource Loader: Class to load Images
 * @author Nitin Pokar (pokar.nitin@gmail.com)
 *
 */
 class ResourceLoader implements MSpriteImageLoader {
	/** Making Class Singleton */
	// static var FILL_COLOR : Int = 0xFFFF0000;
	static var FILL_COLOR : Int = 0x00000000;
	static var resourceLoader : ResourceLoader;
	
	public function new() {}

	static public function getInstance() : ResourceLoader {
		if(resourceLoader==null){
			resourceLoader = new ResourceLoader();
		}
		return resourceLoader;
	}
	
	/**
	 *  Function : LoadImage will be called while loading .anu.
	 *  This version of Load Image will be called when .anu is loaded without chopping images
     *  In this example we have not loaded any .anu where we have passed false to MSpriteLoader, hence this function will never be called
	 */
	public function loadImage( fileName:String, imageId:Int, orientationUsedInStudio:Int ) : Array<BitmapData> {
		// returning null, as we are clipping the image in this example, this function will never be called 
		return null;
	}
	
	/**
	 *  If you are using Nokia DirectGraphics, please don't load flipped image, Instead modify MPlayer to flip it at runtime 
	 *
	 *  Function : LoadImageClip will be called while loading .anu.
	 *  This version of Load Image will be called when .anu is loaded with chopped images
     *  In this example we have loaded .anu with passing true in MSpriteLoader, hence this function will be called
	 */
	public function loadImageClip( fileName:String, imageId:Int , x:Int, y:Int, w:Int, h:Int, orientationUsedInStudio:Int ) : Array<BitmapData> {
		// trace( "<ResourceLoader::loadImageClip>\n" );
		// trace(	"\n" + 
		// 		"fileName: " + fileName +
		// 		", imageId: " + imageId +
		// 		", x: " + x +
		// 		", y: " + y +
		// 		", w: " + w +
		// 		", h: " + h +
		// 		", orientationUsedInStudio: " + orientationUsedInStudio );

		var image : Array<BitmapData> = new Array<BitmapData>();
		var origImage : BitmapData =  nme.Assets.getBitmapData( fileName + ".png" );
		var imageFragment : BitmapData;
		var bitmap : Bitmap;
		var cropArea : Rectangle = new Rectangle( 0, 0, w, h );
		var transX : Int;
		var transY : Int;
		var trans : Matrix;
		trans = new Matrix();
		trans.translate( -x, -y );
		// trans.scale(0.5, 0.5); //scale the image
		imageFragment = new BitmapData( w, h, true, FILL_COLOR );
		imageFragment.draw( origImage, trans, null, null, cropArea, true );
		// bitmap = new Bitmap( imageFragment );
		image.push( imageFragment );
		// reset trans

		// trace( "MSprite.ORIENTATION_FLIP_H: " + MSprite.ORIENTATION_FLIP_H );
		/** Please don't load this if using Nokia Direct Graphics */
		if( orientationUsedInStudio == MSprite.ORIENTATION_FLIP_H || orientationUsedInStudio == MSprite.ORIENTATION_FLIP_BOTH_H_V ) {
			trans = new Matrix();
			trans.scale(-1,1);
			trans.translate( w + x, -y );
			imageFragment = new BitmapData( w, h, true, FILL_COLOR );
			imageFragment.draw( origImage, trans, null, null, cropArea, false );
			image.push( imageFragment );
		} else 
		{
			image.push( null );
		}
		
		/** Please don't load this if using Nokia Direct Graphics */
		if( orientationUsedInStudio == MSprite.ORIENTATION_FLIP_V || orientationUsedInStudio == MSprite.ORIENTATION_FLIP_BOTH_H_V ) {
			// trans.scale(1,-1);
			// transX = -x;
			// transY = h + y;
			trans = new Matrix();
			trans.scale(1,-1);
			trans.translate( -x, h + y );
			imageFragment = new BitmapData( w, h, true, FILL_COLOR );
			imageFragment.draw( origImage, trans, null, null, cropArea, false );
			// trace( "------ image added for orientation 2, image.length: " + image.length );
			image.push( imageFragment );
			// trace( "------ image added for orientation 2, image.length: " + image.length );
		} else {
			image.push( null );
		}
		// if( orientationUsedInStudio == MSprite.ORIENTATION_FLIP_V || orientationUsedInStudio == MSprite.ORIENTATION_FLIP_BOTH_H_V ) {
		// 	throw "unhandled case: orientationUsedInStudio == MSprite.ORIENTATION_FLIP_V";
		// 	// image[2] = Image.createImage(baseImage,x,y,w,h,Sprite.TRANS_MIRROR_ROT180);
		// }

		// var img:Image = new Image();
		// img.source = new Bitmap(transBMD); //This image will be 50% smaller and 

		// draw(source:IBitmapDrawable, matrix:Matrix = null, colorTransform:flash.geom:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void
		// determine whether i need flipped version in my game
		// var doYouNeedHFlippedSpriteInYourgame : Bool = false;
		// var doYouNeedVFlippedSpriteInYourgame : Bool = false;
		
		// var baseImage : Bitmap = null;
		// if(fileName == "/mongo/mongo.anu"){
		// 	if(imageId==0){
		// 		baseImage = loadImage("/mongo/character.png");
		// 		doYouNeedHFlippedSpriteInYourgame = true; // mongo need any flip, as that monkey moves both in left and right
		// 		doYouNeedVFlippedSpriteInYourgame = false;
		// 	}else if(imageId==1){
		// 		baseImage = loadImage("/mongo/banana.png");
		// 		doYouNeedHFlippedSpriteInYourgame = false; // banana doesn't need any flip
		// 		doYouNeedVFlippedSpriteInYourgame = false;
		// 	}
		// }
		
		// var image : Array<Bitmap> = new Array<Bitmap>();
		// image[2] = null;

		// image[0] = Image.createImage(baseImage,x,y,w,h,Sprite.TRANS_NONE);
		
		// /** Please don't load this if using Nokia Direct Graphics */
		// if(orientationUsedInStudio==MSprite.ORIENTATION_FLIP_H || orientationUsedInStudio==MSprite.ORIENTATION_FLIP_BOTH_H_V ||doYouNeedHFlippedSpriteInYourgame )
		// 	image[1] = Image.createImage(baseImage,x,y,w,h,Sprite.TRANS_MIRROR);
		
		// /** Please don't load this if using Nokia Direct Graphics */
		// if(orientationUsedInStudio==MSprite.ORIENTATION_FLIP_V || orientationUsedInStudio==MSprite.ORIENTATION_FLIP_BOTH_H_V || doYouNeedVFlippedSpriteInYourgame)
		// 	image[2] = Image.createImage(baseImage,x,y,w,h,Sprite.TRANS_MIRROR_ROT180);
		
		return image;
	}
	
	// public static function createImage( str : String ) : Bitmap {
	// 	try{
	// 		return Image.createImage(str);
	// 	} catch ( e : String ) {
	// 		trace("Error loading Image " + str);
	// 	}
	// 	return null;
	// }
}
