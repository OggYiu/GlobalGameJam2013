package firerice.core.motionwelder;
/*
 * COPYRIGHT - MOTIONWELDER
 */
// import awe6.core.Context;
import nme.display.BitmapData;

class MSpriteData {

	/*  Animation table 
	 *  FORMAT:
	 *    1. [frametable-start][frametable-end]
	 *    2. [frametable-start][frametable-end]
	 *    3. [frametable-start][frametable-end]
	 */
	public var animationTable : Array<Int>;
	
	/* Animation Frame Table 
	 *  FORMAT
	 *      1. [FRAME-INDEX][delay][xinc][yinc]
	 * 		2. [FRAME-INDEX][delay][xinc][yinc]
	 * 		3. [FRAME-INDEX][delay][xinc][yinc]
	 * 
	 * 		4. [FRAME-INDEX][delay][xinc][yinc]
	 * 		5. [FRAME-INDEX][delay][xinc][yinc]
	 * 
	 *      6. [FRAME-INDEX][delay][xinc][yinc]
	 * 		7. [FRAME-INDEX][delay][xinc][yinc]
	 * 		8. [FRAME-INDEX][delay][xinc][yinc]
	 * 
	 * 		9. [FRAME-INDEX][delay][xinc][yinc]
	 * 		10.[FRAME-INDEX][delay][xinc][yinc]
	 */
	public var frameTable : Array<Int>;
	
	
	/*   Frame Pool Table 
	 *  FORMAT
	 *  
	 *       [CLIP INDEX][X][Y][FLAG]
	 *       [CLIP INDEX][X][Y][FLAG]   - FRAME 0
	 *       [CLIP INDEX][X][Y][FLAG]
	 *       
	 *       [CLIP INDEX][X][Y][FLAG]
	 *       [CLIP INDEX][X][Y][FLAG]    - FRAME 1
	 *       [CLIP INDEX][X][Y][FLAG]
	 *       [CLIP INDEX][X][Y][FLAG]
	 *       
	 *       [CLIP INDEX][X][Y][FLAG]
	 *       [CLIP INDEX][X][Y][FLAG]   - FRAME 2
	 *       [CLIP INDEX][X][Y][FLAG]
	 *  
	 */

	public var framePoolTable : Array<Int>;
	
	/*   Clip Pool Table
	 *  FORMAT
	 *  Image
	 *  	[x][y][w][h]
	 *  	[x][y][w][h]
	 *  	[x][y][w][h]
	 *  
	 *  Ellipse
	 *  	[w][h][startAngle][endAngle][color]
	 *  	[w][h][startAngle][endAngle][color]
	 *  	[w][h][startAngle][endAngle][color]
	 *  
	 *  Line
	 *     [x2][y2][color]
	 *     [x2][y2][color]
	 *     
	 *  Rect
	 *     [w][h][color]
	 *     [w][h][color]
	 *     
	 *  RoundedRect
	 *     [w][h][arcwidth][archeight][color]
	 *     [w][h][arcwidth][archeight][color]
	 *     
	 *  PositionerRoundedRect
	 *     [w][h]
	 *     [w][h]
	 */
	
	public var imageClipPool : Array<Int>;
	public var ellipseClipPool : Array<Int>;
	public var lineClipPool : Array<Int>;
	public var rectangleClipPool : Array<Int>;
	public var roundedRectangleClipPool : Array<Int>;
	public var positionerRectangleClipPool : Array<Int>;
	
	/*  Image Indexer
	 *  Indexing is not read from file, so we need to index it while reading
	 */ 

	public var imageIndexTable : Array<Int>;
	
	
	/*  Frame Indexer
	 *  Indexing is not read from file, so we need to index it while reading
	 */ 
	
	public var frameTableIndex : Array<Int>;

	/*  Split individual image clips 
	 *  Set true when needed to split images from clips 
	 * 
	 */
	public var splitImageClips : Bool;
	
	
	/*  Images 
	 *  imageVector will contain list of images array if splitImageClip is false
	 *  else if will contain list of two dimentional image[] imageArray 
	 * 
	 */
	// public var imageVector : Array<Array<Bitmap>>;
	public var imageVector : Array<Array<Array<BitmapData>>>;
	
	/**
	 *	 MSpiteData represents actual .anu data.
	 *   @param splitImageClips
	 *   			if true 
	 *              <br></br>
	 *  			Images will be chopped to it's clips. loadImage() of {@link MSpriteLoader} will be called to load individual image clips.
	 *  			<br></br>
	 *   			else 
	 *              <br></br>
	 *  			Single image will be kept in memory. loadImage() of {@link MSpriteLoader} will be called to load image.
	 **/
	public function new( p_splitImageClips : Bool ){
		splitImageClips = p_splitImageClips;
		imageVector = new Array<Array<Array<BitmapData>>>();
	}

	public function toString() : String {
		var output : String = "\n";
		var arraySize : Int = 0;

		output += "animationTable------\n";
		arraySize = Std.int( animationTable.length / 2 );
		for( i in 0 ... arraySize ) {
			output += "frametable-start: " + animationTable[i*2+0] + "\n";
			output += "frametable-end: " + animationTable[i*2+1] + "\n";
			output += "\n";
		}
		output += "\n";

		// Animation Frame Table
		output += "frameTable------\n";
		arraySize = Std.int( frameTable.length / 4 );
		for( i in 0 ... arraySize ) {
			output += "frame-index: " + frameTable[i*4+0] + "\n";
			output += "delay: " + frameTable[i*4+1] + "\n";
			output += "xinc: " + frameTable[i*4+2] + "\n";
			output += "yinc: " + frameTable[i*4+3] + "\n";
			output += "\n";
		}
		output += "\n";

		// Frame Pool Table
		output += "framePoolTable------\n";
		arraySize = Std.int( framePoolTable.length / 4 );
		for( i in 0 ... arraySize ) {
			output += "CLIP INDEX: " + framePoolTable[i*4+0] + "\n";
			output += "x: " + framePoolTable[i*4+1] + "\n";
			output += "y: " + framePoolTable[i*4+2] + "\n";
			output += "flag: " + framePoolTable[i*4+3] + "\n";
			output += "\n";
		}
		output += "\n";

		// Clip Pool Table
		output += "imageClipPool------\n";
		arraySize = Std.int( imageClipPool.length / 4 );
		for( i in 0 ... arraySize ) {
			output += "i: " + i + "\n";
			output += "x: " + imageClipPool[i*4+0] + "\n";
			output += "y: " + imageClipPool[i*4+1] + "\n";
			output += "w: " + imageClipPool[i*4+2] + "\n";
			output += "h: " + imageClipPool[i*4+3] + "\n";
			output += "\n";
		}
		output += "\n";

		// Ellipse
		output += "ellipseClipPool------\n";
		arraySize = Std.int( ellipseClipPool.length / 5 );
		for( i in 0 ... arraySize ) {
			output += "w: " + ellipseClipPool[i*5+0] + "\n";
			output += "h: " + ellipseClipPool[i*5+1] + "\n";
			output += "startAngle: " + ellipseClipPool[i*5+2] + "\n";
			output += "endAngle: " + ellipseClipPool[i*5+3] + "\n";
			output += "color: " + ellipseClipPool[i*5+4] + "\n";
			output += "\n";
		}
		output += "\n";

	 	// Line
		output += "lineClipPool------\n";
		arraySize = Std.int( lineClipPool.length / 3 );
		for( i in 0 ... arraySize ) {
			output += "x2: " + lineClipPool[i*3+0] + "\n";
			output += "y2: " + lineClipPool[i*3+1] + "\n";
			output += "color: " + lineClipPool[i*3+2] + "\n";
			output += "\n";
		}
		output += "\n";

	 	// Rect
		output += "rectangleClipPool------\n";
		arraySize = Std.int( rectangleClipPool.length / 3 );
		for( i in 0 ... arraySize ) {
			output += "w: " + rectangleClipPool[i*3+0] + "\n";
			output += "h: " + rectangleClipPool[i*3+1] + "\n";
			output += "color: " + rectangleClipPool[i*3+2] + "\n";
			output += "\n";
		}
		output += "\n";

		// RoundedRect
		output += "roundedRectangleClipPool------\n";
		arraySize = Std.int( roundedRectangleClipPool.length / 5 );
		for( i in 0 ... arraySize ) {
			output += "w: " + roundedRectangleClipPool[i*5+0] + "\n";
			output += "h: " + roundedRectangleClipPool[i*5+1] + "\n";
			output += "arcwidth: " + roundedRectangleClipPool[i*5+2] + "\n";
			output += "archeight: " + roundedRectangleClipPool[i*5+3] + "\n";
			output += "color: " + roundedRectangleClipPool[i*5+4] + "\n";
			output += "\n";
		}
		output += "\n";

		// PositionerRoundedRect
		output += "positionerRectangleClipPool------\n";
		arraySize = Std.int( positionerRectangleClipPool.length / 2 );
		for( i in 0 ... arraySize ) {
			output += "w: " + positionerRectangleClipPool[i*2+0] + "\n";
			output += "h: " + positionerRectangleClipPool[i*2+1] + "\n";
			output += "\n";
		}
		output += "\n";

		// Image Indexer
		arraySize = Std.int( imageIndexTable.length );
		for( i in 0 ... arraySize ) {
			output += "imageIndexTable[" + i + "]: " + imageIndexTable[i] + "\n";
		}
		output += "\n";

		// frame table index
		arraySize = Std.int( frameTableIndex.length );
		for( i in 0 ... arraySize ) {
			output += "frameTableIndex[" + i + "]: " + frameTableIndex[i] + "\n";
		}
		output += "\n";

		output += "splitImageClips: " + splitImageClips + "\n";

		output += "imageVector------\n";
		output += "imageVector.length: "+ imageVector.length + "\n";
		for( i in 0 ... imageVector.length ) {
			if( imageVector[i] != null ) {
				output += "imageVector[" + i + "].length: "+ imageVector[i].length + "\n";
				for( j in 0 ... imageVector[i].length ) {
					if( imageVector[i][j] != null ) {
						output += "imageVector[" + i + "][" + j + "].length: "+ imageVector[i][j].length + "\n";
						output += imageVector[i][j].toString() + "\n";
					}
				}
			}
		}
		output += "\n";

		return output;
	}
}
