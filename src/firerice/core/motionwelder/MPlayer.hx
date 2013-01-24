package firerice.core.motionwelder;

import nme.geom.Rectangle;
import nme.display.Bitmap;
import nme.display.BitmapData;

class MPlayer {
	var data : MSpriteData;
	
	/** Current Animation */
	var animation : Int;
	
	/** Current Frame */
	var frame : Int;
	
	/** Frame Count */
	var frameCount : Int;
	
	var loopOffset : Int;
	
	/** Delay Count */
	var delayCount : Int;
	
	var framePoolPointer : Int;
	
//	private boolean isPlaying;
	
	var rect : Rectangle;

	static var IMAGE_FLAG_NONE : Int				= 0x00; // 0000 0000
	static var IMAGE_FLAG_HFLIP : Int				= 0x02; // 0000 0010 
	static var IMAGE_FLAG_VFLIP : Int				= 0x04; // 0000 0100
	
	static var ELLIPSE_FLAG_NONE : Int				= 0x01; // 0000 0001
	static var ELLIPSE_FLAG_FILLED : Int			= 0x03; // 0000 0011
	
	static var LINE_FLAG : Int 						= 0x05; // 0000 0101 
	
	static var RECTANGLE_FLAG_NONE : Int			= 0x07; // 0000 0111
	static var RECTANGLE_FLAG_FILLED : Int			= 0x09; // 0000 1001
	
	static var ROUNDEDRECTANGLE_FLAG_NONE : Int 	= 0x0b; // 0000 1011
	static var ROUNDEDRECTANGLE_FLAG_FILLED : Int 	= 0x0d; // 0000 1101
	
	static var POSITIONERRECTANGLE_FLAG : Int 		= 0x0f; // 0000 1111
	
	/**
	 * @param data sprite data to be played
	 */
	public function new( data : MSpriteData ) {
		this.data = data;
		rect = new Rectangle();

		animation = 0;
		frame = 0;
		frameCount = 0;
		loopOffset = 0;
		delayCount = 0;
		framePoolPointer = 0;
	}
	
	/**
	 * Sets Animation
	 * @param id Sets player to play animation referring to this id.
	 */
	public function setAnimation( id : Int ) : Void {
		animation = id;
		
		var pos : Int = (animation<<1);
		frameCount = (data.animationTable[pos+1]-data.animationTable[pos] +1);
		
		setFrame(0);
		notifyStartOfAnimation();
	}
	
	/**
	 * @return animtion id for the current animation of a player
	 */
	public function getAnimation() : Int {
		return animation;
	}
	
	/**
	 * @return frameCount for current animation
	 */
	public function getFrameCount() : Int {
		return frameCount;
	}
	
	/**
	 * @return current frame that is played
	 */
	public function getCurrentFrame() : Int {
		return frame;
	}
	
	/**
	 * Sets Frame
	 * @param frame sets the player to this frame
	 */
	public function setFrame( frame : Int ) : Void {
		this.frame = frame;
		delayCount = 0;
		var frameIndex : Int = data.animationTable[animation<<1] +frame;
		framePoolPointer = data.frameTable[(frameIndex<<2)];
	}
	
	/**	
	*   Sets loop offset for a animation
	*   @param val Loop Offset
	*	<p><font size="2" color="#000080"><i>&nbsp;Loop offset stores from where the 
	*	next frame is to start after one round of animation is completed</i></font></p>
	*	<p><font size="2" color="#000080"><i>if frameNo =-1, it will not loop and throw 
	*	end of animation on completion of animation<br>
	*	if frameNo &gt;=0, it will loop from frame number</i></font></p>
	*	<p><font size="2" color="#000080"><i>For eg.<br>
	*	&nbsp;we have 5 frames in a animation<br>
	*	setLoop(-1); <br>
	*	&nbsp;&nbsp;&nbsp; 0,1,2,3,4,(end of animation)<br>
	*	setLoop(2);<br>
	*	&nbsp;&nbsp;&nbsp; 0,1,2,3,4,2,3,4,2,3,4,2,.....</i></font></p>
	*	<p>&nbsp;</p>
	*	<p><font size="2" color="#000080"><i><br>
	*	&nbsp;</i></font></p>
	*	<p><i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </i></p>
	*	<p>&nbsp;</p>
	*/
	
	public function setLoopOffset( val : Int ) : Void {
		this.loopOffset = val;
	}
	
	/**
	 * @return Animation Count
	 */
	public function getAnimationCount() : Int {
		return (data.animationTable.length>>>1);
	}
	
	
	/**
	 * @return Number of Collisiton rect for current frame
	 */
	
	public function getNumberOfCollisionRect() : Int {
		var count : Int = 0;
		var startIndex : Int = data.frameTableIndex[framePoolPointer<<1];
		var endIndex : Int = data.frameTableIndex[(framePoolPointer<<1)+1];
		while(startIndex<endIndex){
			startIndex+=3;
			if(data.framePoolTable[startIndex++]==POSITIONERRECTANGLE_FLAG){
				count++;
			}
		}
		
		return count;
	}
	
	/**
	 * @return Returns Collision Rect at given index
	 */
	public function getCollisionRect( index : Int ) : Rectangle {
		var count : Int = -1;
		var startIndex : Int = data.frameTableIndex[framePoolPointer<<1];
		var endIndex : Int = data.frameTableIndex[(framePoolPointer<<1)+1];
		while(startIndex<endIndex){
			var clipIndex : Int = data.framePoolTable[startIndex++];
			var x : Int = data.framePoolTable[startIndex++]; // + sprite.getSpriteX()
			var y : Int = data.framePoolTable[startIndex++]; // + sprite.getSpriteY()
			if(data.framePoolTable[startIndex++]==POSITIONERRECTANGLE_FLAG){
				count++;
				if(count==index){
					clipIndex=clipIndex<<1;
					rect.width = data.positionerRectangleClipPool[clipIndex];
					rect.height = data.positionerRectangleClipPool[clipIndex+1];
					// changing x and y
					var spriteOrientation : Int = getSpriteOrientation();
					if(spriteOrientation==1){// flip h
						x = -x-Std.int(rect.width);
					} else if(spriteOrientation==2){// flip v
						y = -y-Std.int(rect.height);
					}
					rect.x = x;
					rect.y = y;

					return rect;
				}
			}
		}
		
		return null;
	}

	
	/**  
	 * This method will update sprite to next frame  
	 */
	
	public function getDelayCount() : Int {
		var frameIndex : Int = data.animationTable[animation<<1] +frame;
		return data.frameTable[(frameIndex<<2) +1];
	}

	public function update() : Void {
		var frameIndex : Int = data.animationTable[animation<<1] +frame;
		if(delayCount<getDelayCount()){
			delayCount++;
			return;
		}
		
		// check for end of animation
		if(frame>=frameCount-1){
			if(loopOffset<0){
				notifyEndOfAnimation();
//				isPlaying = false;
//				if(sprite!=null)
//					sprite.endOfAnimation();
				return;
			} else {
				frame = loopOffset-1;
			}
		}
		
		setFrame(frame+1);
		frameIndex = data.animationTable[animation<<1] +frame;
		
		var xInc : Int = data.frameTable[(frameIndex<<2) +2];
		var yInc : Int = data.frameTable[(frameIndex<<2) +3];
//		data.frameTable[(frameIndex<<2) +2]
//		data.frameTable[(frameIndex<<2) +3]
//		if(sprite!=null)
//			sprite.updateSpritePosition(getSpriteOrientation()==1?-xInc:xInc,getSpriteOrientation()==2?-yInc:yInc);
//		else{
//			spriteX+=getSpriteOrientation()==1?xInc:-xInc;
//			spriteY+=getSpriteOrientation()==2?yInc:-yInc;
//		}
		updateSpritePositionBy(getSpriteOrientation()==1?-xInc:xInc,getSpriteOrientation()==2?-yInc:yInc);
		delayCount++;
	}
	
/*
 * 
 *       [CLIP INDEX][X][Y][FLAG]
 *       [CLIP INDEX][X][Y][FLAG]   - FRAME 0
 *       [CLIP INDEX][X][Y][FLAG]
 */
	/**
	 *  @param g Graphics object on which frame is rendered
	 */
	public function getFrames() : Array<MFrameImage> {
		var frameImage : Array<MFrameImage> = new Array<MFrameImage>();
		// trace( "<MPlayer::drawFrame>" );
		var startIndex : Int = data.frameTableIndex[framePoolPointer<<1];
		var endIndex : Int = data.frameTableIndex[(framePoolPointer<<1)+1];
		
		// var clipX : Int = g.getClipX();
		// var clipY : Int = g.getClipY();
		// var clipW : Int = g.getClipWidth();
		// var clipH : Int = g.getClipHeight();
		
		while(startIndex<endIndex){
			var clipIndex : Int = data.framePoolTable[startIndex++];
			var x : Int = data.framePoolTable[startIndex++]; // + sprite.getSpriteX()
			var y : Int = data.framePoolTable[startIndex++]; // + sprite.getSpriteY()
			var flag : Int = data.framePoolTable[startIndex++];
			drawClip(frameImage,x,y,clipIndex,flag);
			
			// reset the clip position 
			// g.setClip(clipX,clipY,clipW,clipH);
		}

		return frameImage;
	}
	
	function drawClip( outputArray : Array<MFrameImage>, x : Int, y : Int, clipIndex : Int, flag : Int) {
		// trace( "<MPlayer::drawClip>" );
//		byte type = (byte)(flag&0x0f);
		// check for image type flag
		if((flag&0x01)==0){
		// trace( "<MPlayer::drawClip> 1" );
			var imageId : Int = ((flag&0xf8)>>3);
			var orientation : Int = (flag&0x07);
			orientation=(orientation>>1);
			
			drawImageClip(outputArray,x,y,imageId,clipIndex,orientation);
		} else {
			throw "<MPlayer::drwaClip>, unhandled case : " + flag;
		}
		// else if(flag == ELLIPSE_FLAG_NONE || flag == ELLIPSE_FLAG_FILLED) {
		// 	//[w][h][startAngle][endAngle][color]
		// 	var index : Int = clipIndex*5;
		// 	drawEllipseClip(g,x,y,data.ellipseClipPool[index],data.ellipseClipPool[index+1],data.ellipseClipPool[index+2],data.ellipseClipPool[index+3],data.ellipseClipPool[index+4],flag == ELLIPSE_FLAG_FILLED);
		// } else if(flag ==LINE_FLAG) {
		// 	 //[x2][y2][color]
		// 	var index : Int = clipIndex*3;
		// 	drawLineClip(g,x,y,data.lineClipPool[index],data.lineClipPool[index+1],data.lineClipPool[index+2]);
		// } else if(flag == RECTANGLE_FLAG_NONE || flag == RECTANGLE_FLAG_FILLED) {
		// 	//[w][h][color]
		// 	var index : Int = clipIndex*3;
		// 	drawRectangleClip(g,x,y,data.rectangleClipPool[index],data.rectangleClipPool[index+1],data.rectangleClipPool[index+2],flag == RECTANGLE_FLAG_FILLED);
		// } else if(flag == ROUNDEDRECTANGLE_FLAG_NONE || flag == ROUNDEDRECTANGLE_FLAG_FILLED) {
		// 	//[w][h][arcwidth][archeight][color]
		// 	var index : Int = clipIndex*5;
		// 	drawRoundedRectangleClip(g,x,y,data.roundedRectangleClipPool[index],data.roundedRectangleClipPool[index+1],data.roundedRectangleClipPool[index+2],data.roundedRectangleClipPool[index+3],data.roundedRectangleClipPool[index+4],flag == ROUNDEDRECTANGLE_FLAG_FILLED);
		// }
	}
	
/*	
 sprite oritn->			| 0   1   2
 					 ---------------				
 clip oritn			  0 | 0   1   2
 					  1 | 1   0   3
 					  2 | 2   3   0
 	         
 	         0 - no orientation
 	         1 - flip H
 	         2 - flip V
 	         3 - rotate 180 - NOT RECOMENDED
*/	
	
	// please don't use this if you are using Nokia Direct Graphics, instead use one below this.  
	function drawImageClip( outputArray : Array<MFrameImage>, x : Int, y : Int, imageId : Int, clipIndex : Int, orientation : Int ) : Void {
		// trace( 	"\n\ndrawImageClip" + 
		// 		", x : " + x +
		// 		", y : " + y + 
		// 		", imageId : " + imageId + 
		// 		", clipIndex : " + clipIndex + 
		// 		", orientation : " + orientation );
		// trace( "<MPlayer::drawImageClip>" );
		var index : Int = clipIndex*4;
		var clipX : Int = data.imageClipPool[index++];
		var clipY : Int = data.imageClipPool[index++];
		var clipW : Int = data.imageClipPool[index++];
		var clipH : Int = data.imageClipPool[index++];
		
		// var spriteOrientation : Int = getSpriteOrientation();
		
		// if(orientation == spriteOrientation){ // if user have same operation as wat clip is having.. than.. flip&flip = normal
		// 	orientation = 0;
		// } else if(orientation==0 || spriteOrientation==0){
		// 	orientation = (orientation + spriteOrientation); // take non zero value	
		// } else {
		// 	//orientation = 3;
		// 	throw "FLIP H and FLIP V, cannot be used at a same time, use your own implementation";
		// 	return;
		// }
		// trace( "after: orientation: " + orientation );
		// changing x and y
		// if(orientation==1){// flip h
		// 	x = -x-clipW;
		// } else if(orientation==2){// flip v
		// 	y = -y-clipH;
		// }
		
		
		// render image based on whether it is cliped or not  
		if(data.splitImageClips){
			// trace( "<MPlayer::drawImageClip> 1" );
		
			var bitmapdata : BitmapData = (data.imageVector[imageId])[clipIndex-data.imageIndexTable[imageId]][orientation];
			// trace( "!!!!!!!!!!!!orientation: " + orientation + ", width: " + bitmapdata.width + ", height: " + bitmapdata.height );
			// var img : Bitmap = new Bitmap( bitmapdata );
			// var img : Bitmap = ((Image[][])data.imageVector.elementAt(imageId))[clipIndex-data.imageIndexTable[imageId]][orientation];
			
			var xPos : Int = x + getSpriteDrawX();
			var yPos : Int = y + getSpriteDrawY();
			
			outputArray.push( new MFrameImage( bitmapdata, xPos, yPos, 20 ) );
			//g.drawImage(img,xPos,yPos,20);
		} else {
			throw "<MPlayer::drawImageClip>, unhandled case: " + data.splitImageClips;
		}
		// else {
		// 	// Image[] imageArr = (Image[])data.imageVector.elementAt(imageId);
		// 	var imageArr : Array<Bitmap> = data.imageVector[imageId];
			
		// 	if(orientation==1){ // flip h
		// 		clipX = imageArr[0].getWidth() - clipW - clipX;
		// 	} else if(orientation==1){
		// 		clipY = imageArr[0].getHeight() - clipH - clipY;
		// 	}
			
		// 	var xPos : Int = x + getSpriteDrawX();
		// 	var yPos : Int = y + getSpriteDrawY();
		// 	g.clipRect(xPos,yPos,clipW,clipH);
			
		// 	g.drawImage(imageArr[orientation],xPos-clipX,yPos-clipY,20);
		// }
	}
	
	/**
	 *  USE THIS DRAW METHOD, IF YOU ARE USING NOKIA DIRECT GRAPHICS
	 */
	/*
	protected void drawImageClip(Graphics g,int x,int y,byte imageId,int clipIndex,byte orientation){
		
		int index = clipIndex*4;
		int clipX = data.imageClipPool[index++];
		int clipY = data.imageClipPool[index++];
		int clipW = data.imageClipPool[index++];
		int clipH = data.imageClipPool[index++];
		
		byte spriteOrientation = getSpriteOrientation();
		
		if(orientation == spriteOrientation){ // if user have same operation as wat clip is having.. than.. flip&flip = normal
			orientation = 0;
		} else if(orientation==0 || spriteOrientation==0){
			orientation = (byte)(orientation + spriteOrientation); // take non zero value	
		} else {
			//orientation = 3;
			System.out.println("FLIP H and FLIP V, cannot be used at a same time, use your own implementation");
			return;
		}
		
		// changing x and y
		if(spriteOrientation==1){// flip h
			x = -x-clipW;
		} else if(spriteOrientation==2){// flip v
			y = -y-clipH;
		}
		
		
		// render image based on whether it is cliped or not  
		if(data.splitImageClips){
			Image img = ((Image[][])data.imageVector.elementAt(imageId))[clipIndex-data.imageIndexTable[imageId]][0];
			
			int xPos = x + getSpriteDrawX();
			int yPos = y + getSpriteDrawY();
			
			if(orientation==MSprite.ORIENTATION_NONE)
				g.drawImage(img,xPos,yPos,20);
			else if(orientation==MSprite.ORIENTATION_FLIP_H){
				DirectGraphics dg = DirectUtils.getDirectGraphics(g);
				dg.drawImage(img,xPos,yPos,20,DirectGraphics.FLIP_HORIZONTAL);
			}else if(orientation==MSprite.ORIENTATION_FLIP_V){
				DirectGraphics dg = DirectUtils.getDirectGraphics(g);
				dg.drawImage(img,xPos,yPos,20,DirectGraphics.FLIP_VERTICAL);
			}
		} else {
			Image[] imageArr = (Image[])data.imageVector.elementAt(imageId);
			
			if(orientation==1){ // flip h
				clipX = imageArr[0].getWidth() - clipW - clipX;
			} else if(orientation==1){
				clipY = imageArr[0].getHeight() - clipH - clipY;
			}
			
			int xPos = x + getSpriteDrawX();
			int yPos = y + getSpriteDrawY();
			g.clipRect(xPos,yPos,clipW,clipH);
			
			if(orientation==MSprite.ORIENTATION_NONE){
				g.drawImage(imageArr[0],xPos-clipX,yPos-clipY,20);
		    }else if(orientation==MSprite.ORIENTATION_FLIP_H){
				DirectGraphics dg = DirectUtils.getDirectGraphics(g);
				dg.drawImage(imageArr[0],xPos-clipX,yPos-clipY,20,DirectGraphics.FLIP_HORIZONTAL);
			}else if(orientation==MSprite.ORIENTATION_FLIP_V){
				DirectGraphics dg = DirectUtils.getDirectGraphics(g);
				dg.drawImage(imageArr[0],xPos-clipX,yPos-clipY,20,DirectGraphics.FLIP_VERTICAL);
			}
		}
	}
	*/
	
	// function drawEllipseClip(Graphics g,int x,int y,int width,int height,int startAngle,int endAngle,int color,boolean isFilled) : Void {
		
	// 	byte spriteOrientation = getSpriteOrientation();
	// 	// changing x and y
	// 	if(spriteOrientation==1){// flip h
	// 		x = -x-width;
	// 	} else if(spriteOrientation==2){// flip v
	// 		y = -y-height;
	// 	}

	// 	int xPos = x + getSpriteDrawX();
	// 	int yPos = y + getSpriteDrawY();
		
	// 	g.setColor(color);
	// 	if(isFilled)
	// 		g.fillArc(xPos,yPos,width,height,startAngle,endAngle);
	// 	else
	// 		g.drawArc(xPos,yPos,width,height,startAngle,endAngle);
	// }
	
	// protected void drawLineClip(Graphics g,int x1,int y1,int x2,int y2,int color){
	// 	byte spriteOrientation = getSpriteOrientation();
	// 	// changing x and y
	// 	if(spriteOrientation==1){// flip h
	// 		x1 = -x1;
	// 		x2 = -x2;
	// 	} else if(spriteOrientation==2){// flip v
	// 		y1 = -y1;
	// 		y2 = -y2;
	// 	}

	// 	int xPos1 = x1 + getSpriteDrawX();
	// 	int xPos2 = x2 + getSpriteDrawX();
		
	// 	int yPos1 = y1 + getSpriteDrawY();
	// 	int yPos2 = y2 + getSpriteDrawY();
		
	// 	g.setColor(color);
	// 	g.drawLine(xPos1,yPos1,xPos2,yPos2);
	// }
	
	// protected void drawRectangleClip(Graphics g,int x,int y,int width,int height,int color,boolean isFilled){
	// 	g.setColor(color);

	// 	byte spriteOrientation = getSpriteOrientation();
	// 	// changing x and y
	// 	if(spriteOrientation==1){// flip h
	// 		x = -x-width;
	// 	} else if(spriteOrientation==2){// flip v
	// 		y = -y-height;
	// 	}
		
	// 	int xPos = x + getSpriteDrawX();
	// 	int yPos = y + getSpriteDrawY();

	// 	if(isFilled)
	// 		g.fillRect(xPos,yPos,width,height);
	// 	else
	// 		g.drawRect(xPos,yPos,width,height);		
	// }
	
	// protected void drawRoundedRectangleClip(Graphics g,int x,int y,int width,int height,int arcWidth,int arcHeight,int color,boolean isFilled){
	// 	byte spriteOrientation = getSpriteOrientation();
	// 	// changing x and y
	// 	if(spriteOrientation==1){// flip h
	// 		x = -x-width;
	// 	} else if(spriteOrientation==2){// flip v
	// 		y = -y-height;
	// 	}

	// 	int xPos = x + getSpriteDrawX();
	// 	int yPos = y + getSpriteDrawY();
		
	// 	g.setColor(color);
	// 	if(isFilled)
	// 		g.fillRoundRect(xPos,yPos,width,height,arcWidth,arcHeight);
	// 	else	
	// 		g.drawRoundRect(xPos,yPos,width,height,arcWidth,arcHeight);		
	// }
	
	/**
	 * @return spriteX
	 */
	function getSpriteDrawX() : Int {
		return 0;
	}
	
	/**
	 * @return spriteY
	 */
	function getSpriteDrawY() : Int {
		return 0;
	}
	
	/**
	 * Updates the sprite position by xinc, and yinc 
	 */
	function updateSpritePositionBy( xinc : Int, yinc : Int ) : Void {
	}
	
	/**
	 * @return sprite orientation
	 */
	function getSpriteOrientation() : Int {
		return 0;
	}
	
	/**
	 * Method to notify start of animation
	 */
	function notifyStartOfAnimation() : Void {

	}
	
	/**
	 * Method to notify end of animation
	 */
	function notifyEndOfAnimation() : Void {

	}
}
