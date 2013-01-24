package firerice.core.motionwelder;

class MSimpleAnimationPlayer extends MPlayer {
	var spriteX : Int;
	var spriteY : Int;
	
	var spriteOrientation : Int;
	
	var isPlaying_ : Bool;

	/**
	 * 
	 * @param spriteData spriteData to be played
	 * @param spriteX    x position at which animation is to be played
	 * @param spriteY    y position at which animation is to be played
	 */
	public function new( spriteData : MSpriteData, spriteX : Int, spriteY : Int ) {
		super( spriteData );
		this.spriteX = spriteX;
		this.spriteY = spriteY;
	}
	
	/**
	 * Sets the x position
	 * @param val x position at which animation is to be played 
	 */
	public function setSpriteX( val : Int ) : Void {
		this.spriteX = val;
	}
	
	/**
	 * Sets the y position
	 * @param val y position at which animation is to be played 
	 */
	public function setSpriteY( val : Int) : Void {
		this.spriteY = val;
	}
	
	override public function notifyStartOfAnimation() : Void {
		isPlaying_ = true;
	}
	
	override public function notifyEndOfAnimation() : Void {
		isPlaying_ = false;
	}
	
	/**
	 * Method to check if player is currently playing that animation, of animation has come to an end
	 * @return true- if animation is playing , else false
	 */
	public function isPlaying() : Bool {
		return isPlaying_;
	}
	
	/**
	 * @param orientation sprite Orientation, can accept MSprite.ORIENTATION_NONE, MSprite.ORIENTATION_FLIP_H, MSprite.ORIENTATION_FLIP_V
	 */
	public function setSpriteOrientation( orientation : Int ) : Void {
		this.spriteOrientation = orientation;
	}
	
	/**
	 * Used by MPlayer to play animation at a given orientation
	 * @return sprite orientaion
	 */
	override public function getSpriteOrientation() : Int {
		return spriteOrientation;
	}
	
	/**
	 * @return x position of sprite
	 */
	override public function getSpriteDrawX() : Int {
		return spriteX;
	}
	
	/**
	 * @return y position of sprite
	 */
	override public function getSpriteDrawY() : Int {
		return spriteY;
	}
	
	/**
	 * Updates the sprite position by xinc, and yinc 
	 */
	override public function updateSpritePositionBy( xinc : Int, yinc : Int ) : Void {
		spriteX+=xinc;
		spriteY+=yinc;
	}
}
