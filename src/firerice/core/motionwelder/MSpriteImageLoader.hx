package firerice.core.motionwelder;

import nme.display.BitmapData;
// import awe6.core.Context;

/*
 * COPYRIGHT - MOTIONWELDER
 */
interface MSpriteImageLoader {
	/** 
	 *  Method to provide implementation for loading image.
	 *  <br></br>-This method will be called when splitImageClips = true.
	 *  <br></br>-Indicates not to chop the image, keep complete image in heap
	 *  <br></br>-Load image corresponding to image-id, and spriteName
	 *  <br></br>-This function is called to that user load the image in advance before playing this image.
	 *  <br></br>-It is upto user how he loads and store image, this is just a notification, that image has to be loaded
	 *  
	 *  @param spriteName Indicates the name of the sprite whose image is to be loaded
	 *  @param imageId    Image to be loaded, image is starts from 0
	 *  @param orientationUsedInStudio denotes kind of orientation used in studio for this given image
	 *  
	 *  @return Image[] of dimension 3 - for No-Orientation, Flip-H, Flip-V
	 *  <pre><blockquote>
	 *  Image[0] = Image without any orientation
	 *  Image[1] = Image Flipped Horizontally  // null if not required
	 *  Image[2] = Image Flipped Vertically    // null if not required
	 *  </pre></blockquote>
	 */
	function loadImage( spriteName:String, imageId:Int, orientationUsedInStudio:Int ) : Array<BitmapData>;

	/** 
	 *  Method to provide implementation for loading image.
	 *  <br></br>-This method will be called when splitImageClips = false.
	 * <br></br>-Indicates chop the image to it's small image clips, keep complete image in heap.
	 *  
	 * @param spriteName Indicates the name of the sprite whose image is to be loaded
	 * @param imageId    Image to be loaded
	 * @param x  X position of a clip in it's image demoted by image id
	 * @param y  Y position of a clip in it's image demoted by image id
	 * @param w  Width of a clip in it's image demoted by image id
	 * @param h  Height of a clip in it's image demoted by image id
	 * @param orientationUsedInStudio denotes kind of orientation used in studio for this given image clip
	 * 
	 * @return Image[] of dimension 3 - for No-Orientation, Flip-H, Flip-V
	 * 	<pre><blockquote>	
	 *  Image[0] = Image without any orientation
	 *  Image[1] = Image Flipped Horizontally // null if not required
	 *  Image[2] = Image Flipped Vertically   // null if not required
	 *  </pre></blockquote>
	 *        
	 */
	function loadImageClip( spriteName:String, imageId:Int , x:Int, y:Int, w:Int, h:Int, orientationUsedInStudio:Int ) : Array<BitmapData>;
}
