package firerice.core.motionwelder;

class MSprite {
	public static var ORIENTATION_NONE : Int = 0;
	public static var ORIENTATION_FLIP_H : Int = 1;
	public static var ORIENTATION_FLIP_V : Int = 2;
	public static var ORIENTATION_FLIP_BOTH_H_V : Int = ORIENTATION_FLIP_H | ORIENTATION_FLIP_V;
	
	// /**
	//  *  @return x-position of sprite to render
	//  * */
	// public int getSpriteDrawX();
	
	// /**
	//  * @return y-position of sprite to render
	//  * */
	// public int getSpriteDrawY();
	
	// /**
	//  *  It can return ORIENTATION_NONE,ORIENTATION_FLIP_H,ORIENTATION_FLIP_V
	//  *  Note: ORIENTATION_FLIP_BOTH_H_V is not supported
	//  *  @return orientation of sprite
	//  * */
	// public byte getSpriteOrientation();
	
	// /**
	//  *  Method to provide notification that sprite position is to be updated by deltaX, and deltaY in x and y direction respectively  
	//  */
	// public void updateSpritePosition(int deltaX,int deltaY);
	
	// /**
	//  *  Method to provide notification that current animation has come to end. 
	//  */
	// public void endOfAnimation();
}
