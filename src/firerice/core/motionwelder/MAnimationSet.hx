package firerice.core.motionwelder;

import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;

/**
 * ...
 * @author oggyiu
 */

typedef AnimationCompleteDelegate = MAnimationSet -> Int -> Void;
typedef AnimationEnterFrameDelegate = MAnimationSet -> MAnimation -> MFrame -> Int -> Void;

class MAnimationSet {
	var animations_ : Array<MAnimation> = null;

	var currClipId_ : Int = 0;
	var currWrapMode_ : WrapMode;
	// var playAutomatically_ : Bool = false;
	
	static var g_paused : Bool = false;
	var paused_ : Bool = false;
	
	var currentAnimation_ : MAnimation = null;
    var currClipTime_ : Float = 0.0;
	var previousFrame_ : Int = -1;
	
	var targetCallbackObj_ : Dynamic = null;
	var animationCompleteDelegate_ : AnimationCompleteDelegate = null;
	var animationEventDelegate_ : AnimationEnterFrameDelegate = null;

	//var specTargetCallbackObj_ : Dynamic = null;
	//var specAnimationCompleteDelegate_ : AnimationCompleteDelegate = null;
	//var specAnimationEventDelegate_ : AnimationEnterFrameDelegate = null;
	
	public var currentAnimation( getCurrentAnimation, null ) : MAnimation;
	public var currentFrame( getCurrentFrame, null ) : MFrame;
	public var previousFrame( getPreviousFrame, null ) : Int;
	//public var targetCallbackObj( getTargetCallbackObj, setTargetCallbackObj ) : Dynamic = null;
	//public var animationCompleteDelegate( getAnimationCompleteDelegate, setAnimationCompleteDelegate ) : AnimationCompleteDelegate;
	//public var animationEventDelegate( getAnimationEventDelegate, setAnimationEventDelegate ) : AnimationEventDelegate;

	public function new( animations : Array<MAnimation> ) {
		animations_ = animations;
		// playAutomatically_ = playAutomatically;
		//targetCallbackObj_ = targetCallbackObj;
		//animationCompleteDelegate_ = animationCompleteDelegate;
		//animationEventDelegate_ = animationEventDelegate;
	}

	// function start() : Void {
	// 	// base.Start();
		
	// 	if( playAutomatically_ )
	// 		play(currClipId_);
	// }
	
	public function playWithName(	name : String,
									orientation : EOrientation,
									wrapMode : WrapMode,
									overrideCurr : Bool ) : Void {
		var id : Int = -1;
		for( i in 0 ... animations_.length ) {
			if( animations_[i].Id == name ) {
				id = i;
				break;
			}
		}
		play(	id,
				orientation,
				wrapMode,
				overrideCurr );
				//targetCallbackObj,
				//animationCompleteDelegate,
				//animationEventDelegate );
	}
	
	public function stop() : Void {
		currentAnimation_ = null;
	}
	
	public function isPlaying() : Bool {
		return currentAnimation_ != null;
	}

	public function play(	id : Int,
							orientation : EOrientation,
							wrapMode : WrapMode,
							overrideCurr : Bool ) : Void {
		if( !overrideCurr ) {
			if( id == currClipId_ ) {
				return ;
			}
		}

		//specTargetCallbackObj_ = targetCallbackObj;
		//specAnimationCompleteDelegate_ = animationCompleteDelegate;
		//specAnimationEventDelegate_ = animationEventDelegate;

		// targetCallbackObj_ = targetCallbackObj;
		// animationCompleteDelegate_ = animationCompleteDelegate;
		// animationEventDelegate_ = animationEventDelegate;

		currClipId_ = id;
		currWrapMode_ = wrapMode;

		if ( id >= 0 && animations_ != null && id < animations_.length ) {
			currentAnimation_ = animations_[id];
	// currentAnimation_.log("\t");
			// Simply swap, no animation is played
			if(	currWrapMode_ == WrapMode.single ||
				currentAnimation_.frames == null ) {
				// SwitchCollectionAndSprite(currentAnimation_.frames[0].spriteCollection, currentAnimation_.frames[0].spriteId);
				
				// if (currentAnimation_.drawImageInfos[0].triggerEvent)
				{
					if (animationEventDelegate_ != null && targetCallbackObj_ != null ) {
						// animationEventDelegate( this, currentAnimation_, currentAnimation_.frames[0], 0 );
						Reflect.callMethod( targetCallbackObj_, animationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[0], 0 ] );
					}
					//if (specAnimationEventDelegate_ != null && specTargetCallbackObj_ != null ) {
						// animationEventDelegate( this, currentAnimation_, currentAnimation_.frames[0], 0 );
						//Reflect.callMethod( specTargetCallbackObj_, specAnimationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[0], 0 ] );
					//}
				}
				currentAnimation_ = null;
			}
			else
			{
				currClipTime_ = 0.0;
				previousFrame_ = -1;
			}
		}
		else
		{
			onCompleteAnimation();
			currentAnimation_ = null;
		}
	}
	
	public function pause() : Void {
		paused_ = true;
	}
	
	public function resume() : Void {
		paused_ = false;
	}
	
	function onCompleteAnimation() : Void {
		previousFrame_ = -1;
		if (animationCompleteDelegate_ != null && targetCallbackObj_ != null ) {
			Reflect.callMethod( targetCallbackObj_, animationCompleteDelegate_, [ this, currClipId_ ] );
		}
		//if (specAnimationCompleteDelegate_ != null && specTargetCallbackObj_ != null ) {
			//Reflect.callMethod( specTargetCallbackObj_, specAnimationCompleteDelegate_, [ this, currClipId_ ] );
		//}
	}
	
	function setFrame( currFrame : Int ) : Void {
		if (previousFrame_ != currFrame)
		{
			// SwitchCollectionAndSprite( currentAnimation_.frames[currFrame].spriteCollection, currentAnimation_.frames[currFrame].spriteId );
			if ( currentAnimation_.frames[currFrame].triggerEvent ) {
				if (animationEventDelegate_ != null && targetCallbackObj_ != null ) {
					Reflect.callMethod( targetCallbackObj_, animationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[currFrame], currFrame ] );
				}
				//if (specAnimationEventDelegate_ != null && specTargetCallbackObj_ != null ) {
					//Reflect.callMethod( specTargetCallbackObj_, specAnimationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[currFrame], currFrame ] );
				//}
			}
			previousFrame_ = currFrame;
		}
	}
	
	public function update( deltaTime : Float ) : Void {
		if( g_paused || paused_ )
			return;
		
		if (currentAnimation_ != null && currentAnimation_.frames != null)
		{
			currClipTime_ += deltaTime * currentAnimation_.fps / (this.currentFrame == null? 1.0 : (this.currentFrame.delayCount));
			if (currWrapMode_ == WrapMode.loop)
			{
				var currFrame : Int = Std.int(currClipTime_) % currentAnimation_.frames.length;
				setFrame(currFrame);
			}
			else if (currWrapMode_ == WrapMode.loopSection)
			{
				var currFrame : Int = Std.int(currClipTime_);
				if (currFrame >= currentAnimation_.loopStart)
				{
					currFrame = currentAnimation_.loopStart + ((currFrame - currentAnimation_.loopStart) % (currentAnimation_.frames.length - currentAnimation_.loopStart));
				}
				setFrame(currFrame);
			}
			else if (currWrapMode_ == WrapMode.pingPong)
			{
				var currFrame : Int = Std.int(currClipTime_) % (currentAnimation_.frames.length + currentAnimation_.frames.length - 2);
				if (currFrame >= currentAnimation_.frames.length)
				{
					var i : Int = currFrame - currentAnimation_.frames.length;
					currFrame = currentAnimation_.frames.length - 2 - i;
				}
				setFrame(currFrame);
			}
			else if (currWrapMode_ == WrapMode.once)
			{
				var currFrame : Int = Std.int(currClipTime_);
				if (currFrame >= currentAnimation_.frames.length)
				{
					// currentAnimation_ = null;
					onCompleteAnimation();
				}
				else
				{
					setFrame(currFrame);
				}
				
			}
		}
	}

	// public function update( deltaTime : Float ) : Void {
	// 	if( g_paused || paused_ )
	// 		return;
		
	// 	var currentMFrame : MFrame = this.currentFrame;
	// 	if( currentMFrame == null ) {
	// 		setFrame(0);
	// 		return ;
	// 	}

	// 	if (currentAnimation_ != null && currentAnimation_.frames != null)
	// 	{
	// 		currClipTime_ += deltaTime;
	// 		if (currWrapMode_ == WrapMode.loop)
	// 		{
	// 			if( currClipTime_ >= currentMFrame.delayCount ) {
	// 				var currFrame : Int = ( previousFrame_ + 1 ) % currentAnimation_.frames.length;
	// 				setFrame(currFrame);
	// 				currClipTime_ = 0;
	// 			}
	// 			// var currFrame : Int = Std.int(currClipTime_) % currentAnimation_.frames.length;
	// 			// setFrame(currFrame);
	// 		}
	// 		// else if (currWrapMode_ == WrapMode.loopSection)
	// 		// {
	// 		// 	var currFrame : Int = Std.int(currClipTime_);
	// 		// 	if (currFrame >= currentAnimation_.loopStart)
	// 		// 	{
	// 		// 		currFrame = currentAnimation_.loopStart + ((currFrame - currentAnimation_.loopStart) % (currentAnimation_.frames.length - currentAnimation_.loopStart));
	// 		// 	}
	// 		// 	setFrame(currFrame);
	// 		// }
	// 		// else if (currWrapMode_ == WrapMode.pingPong)
	// 		// {
	// 		// 	var currFrame : Int = Std.int(currClipTime_) % (currentAnimation_.frames.length + currentAnimation_.frames.length - 2);
	// 		// 	if (currFrame >= currentAnimation_.frames.length)
	// 		// 	{
	// 		// 		var i : Int = currFrame - currentAnimation_.frames.length;
	// 		// 		currFrame = currentAnimation_.frames.length - 2 - i;
	// 		// 	}
	// 		// 	setFrame(currFrame);
	// 		// }
	// 		// else if (currWrapMode_ == WrapMode.once)
	// 		// {
	// 		// 	var currFrame : Int = Std.int(currClipTime_);
	// 		// 	if (currFrame >= currentAnimation_.frames.length)
	// 		// 	{
	// 		// 		currentAnimation_ = null;
	// 		// 		onCompleteAnimation();
	// 		// 	}
	// 		// 	else
	// 		// 	{
	// 		// 		setFrame(currFrame);
	// 		// 	}
				
	// 		// }
	// 	}
	// }

	public function log( append : String = "" ) : Void {
		trace( append + "\t/////////MAnimationSet" );
		trace( append + "\tclipId: " + currClipId_ );
		// trace( append + "\tplayAutomatically: " + playAutomatically_ );
		trace( append + "\tg_paused: " + g_paused );
		trace( append + "\tpaused: " + paused_ );
		trace( append + "\tclipTime: " + currClipTime_ );
		trace( append + "\tpreviousFrame: " + previousFrame_ );
		trace( append + "\tanimationCompleteDelegate: " + animationCompleteDelegate_ );
		trace( append + "\tanimationEventDelegate: " + animationEventDelegate_ );

		for( i in 0 ... animations_.length ) {
			animations_[i].log( append + "\t" );
		}

		// if( currentAnimation_ != null ) {
		// 	trace( append + "\tcurrentAnimation_: " + currentAnimation_.log( append + "\t" ) );
		// }
	}

	function getCurrentAnimation() : MAnimation {
		return currentAnimation_;
	}

	function getPreviousFrame() : Int {
		return previousFrame_;
	}

	function getCurrentFrame() : MFrame {
		// if( currentAnimation_ == null ) {
		// 	throw "<MReader::getCurrentFrame>, invalid currentAnimation_!";
		// }
		// if( previousFrame_ < 0 ) {
		// 	throw "<MReader::getCurrentFrame>, invalid previousFrame_!";
		// }

		if(	currentAnimation_ == null ||
			currentAnimation_.frames == null ||
			previousFrame_ < 0 ||
			previousFrame_ >= currentAnimation_.frames.length ) {
			return null;
		}

		return currentAnimation_.frames[previousFrame_];
	}
	
	public function setEventReceiver(	target : Dynamic,
										completeHandler : AnimationCompleteDelegate,
										enterFrameHandler : AnimationEnterFrameDelegate ) : Void {
		targetCallbackObj_ = target;
		animationCompleteDelegate_ = completeHandler;
		animationEventDelegate_ = enterFrameHandler;
	}
}