package clipper.share.motionwelder;

import clipper.share.MSpriteData;
import clipper.share.MPlayer;
import clipper.share.Defines;

// import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Rectangle;

enum WrapMode {
	loop;
	loopSection;
	once;
	pingPong;
	single;
}

class MFrameImage {
	public var bitmapdata : BitmapData;
	public var xPos : Int;
	public var yPos : Int;
	public var observer : Int;

	public function new(p_bitmapdata : BitmapData,
						p_xPos : Int,
						p_yPos : Int,
						p_observer : Int ) {
		bitmapdata = p_bitmapdata;
		xPos = p_xPos;
		yPos = p_yPos;
		observer = p_observer;
	}

	public function log( append : String ) : Void {
		trace( append + "\t/////////MFrameImage" );
		trace( append + "\tbitmapdata: " + bitmapdata );
		trace( append + "\tbitmap.width: " + bitmapdata.width );
		trace( append + "\tbitmap.height: " + bitmapdata.height );
		trace( append + "\txPos: " + xPos );
		trace( append + "\tyPos: " + yPos );
		trace( append + "\tobserver: " + observer );
	}
}

class MFrame {
	var Id_ : String;
	var frameImages_ : Array<MFrameImage>;
	var colliders_ : Array<Rectangle>;
	var delayCount_ : Int;
	var triggerEvent_ : Bool;

	public var Id( getId, null ) : String;
	public var frameImages( getFrameImages, null ) : Array<MFrameImage>;
	public var colliders( getColliders, null ) : Array<Rectangle>;
	public var delayCount( getDelayCount, null ) : Int;
	public var triggerEvent( getTriggerEvent, null ) : Bool;

	public function new(Id : String,
						frameImages : Array<MFrameImage>,
						colliders : Array<Rectangle>,
						delayCount : Int,
						triggerEvent : Bool ) {
		Id_ = Id;
		colliders_ = colliders;
		frameImages_ = frameImages;
		delayCount_ = delayCount;
		triggerEvent_ = triggerEvent;
	}

	function getId() : String {
		return Id_;
	}

	function getFrameImages() : Array<MFrameImage> {
		return frameImages_;
	}

	function getColliders() : Array<Rectangle> {
		return colliders_;
	}

	function getDelayCount() : Int {
		return delayCount_;
	}

	function getTriggerEvent() : Bool {
		return triggerEvent_;
	}

	public function log( append : String ) : Void {
		trace( append + "\t/////////MFrame" );
		trace( append + "\tId: " + Id_ );
		trace( append + "\tdelayCount: " + delayCount_ );
		trace( append + "\ttriggerEvent: " + triggerEvent_ );
		for( i in 0 ... colliders_.length ) {
			trace( append + "\tcolliders_[" + i + "]" );
			trace( append + "\t\tx: " + colliders_[i].x );
			trace( append + "\t\ty: " + colliders_[i].y );
			trace( append + "\t\twidth: " + colliders_[i].width );
			trace( append + "\t\theight: " + colliders_[i].height );
		}

		for( i in 0 ... frameImages_.length ) {
			frameImages_[i].log( append + "\t" );
		}
	}
}

class MAnimation {
	var Id_ : String;
	var frames_ : Array<MFrame>;
	// var wrapMode_ : WrapMode;
	var fps_ : Int;
	var loopStart_ : Int;

	public var Id( getId, null ) : String;
	public var frames( getFrames, null ) : Array<MFrame>;
	// public var wrapMode( getWrapMode, null ) : WrapMode;
	public var fps( getFps, null ) : Int;
	public var loopStart( getLoopStart, null ) : Int;

	public function new(Id : String,
						frames : Array<MFrame>,
						// wrapMode : WrapMode,
						fps : Int,
						loopStart : Int ) {
		Id_ = Id;
		frames_ = frames;
		// wrapMode_ = wrapMode;
		fps_ = fps;
		loopStart_ = loopStart;
	}

	function getId() : String {
		return Id_;
	}

	function getFrames() : Array<MFrame> {
		return frames_;
	}

	// function getWrapMode() : WrapMode {
	// 	return wrapMode_;
	// }

	function getFps() : Int {
		return fps_;
	}

	function getLoopStart() : Int {
		return loopStart_;
	}

	public function log( append : String ) : Void {
		trace( append + "\t/////////MAnimation" );
		trace( append + "\tId: " + Id_ );
		// trace( append + "\twrapMode: " + wrapMode_ );
		trace( append + "\tfps: " + fps_ );
		trace( append + "\tloopStart: " + loopStart_ );
		for( i in 0 ... frames_.length ) {
			frames_[i].log( append + "\t" );
		}
	}
}

class MReader {
	// var mplayer : MPlayer;
	// var minfos_ : Array<MInfo>;

	public static function read( spriteData : MSpriteData ) : MAnimationSet {
		var mplayer : MPlayer = new MPlayer( spriteData );
		
		// var frameCount : Int = mplayer.getFrameCount();
		var animationCount : Int = mplayer.getAnimationCount();
		var frameCount : Int;
		var animations_ : Array<MAnimation> = new Array<MAnimation>();

		for( i in 0 ... animationCount ) {
			mplayer.setAnimation(i);
			// mplayer.setAnimation(0);
			// var minfo : MInfo = new MInfo();
			// minfo.delayCount = mplayer.getDelayCount();
			frameCount = mplayer.getFrameCount();

			var frames : Array<MFrame> = new Array<MFrame>();
			for( m in 0 ... frameCount ) {
				mplayer.setFrame(m);

				// read all image in a frame

				var frameImages : Array<MFrameImage> = null;
				frameImages = mplayer.getFrames();
				// trace( minfo.toString() );

				// read the collision box
				var colliders : Array<Rectangle> = new Array<Rectangle>();
				var colliderCount : Int = mplayer.getNumberOfCollisionRect();
				for( u in 0 ... colliderCount ) {
					colliders.push( mplayer.getCollisionRect( u ) );
				}

				var frame : MFrame = new MFrame(i + "" + m,
												frameImages,
												colliders,
												mplayer.getDelayCount(),
												true );
				// trace( "frame " + m + frame );
				frames.push( frame );
			}
			var animation : MAnimation = new MAnimation("animation",
														frames,
														// WrapMode.loop,
														30,
														0);
			animations_.push( animation );
		}

		var animationSet : MAnimationSet = new MAnimationSet( animations_ );
		return animationSet;
	}
	// public function new( mSpriteData : MSpriteData ) {
	// 	mplayer_ = new MPlayer( mSpriteData );
		// minfos_ = new Array<MInfo>();

		// // var frameCount : Int = mplayer_.getFrameCount();
		// var animationCount : Int = mplayer_.getAnimationCount();
		// var frameCount : Int;
		// for( i in 0 ... animationCount ) {
		// 	mplayer_.setAnimation(i);
		// 	// mplayer_.setAnimation(0);
		// 	var minfo : MInfo = new MInfo();
		// 	minfo.delayCount = mplayer_.getDelayCount();
		// 	frameCount = mplayer_.getFrameCount();

		// 	for( m in 0 ... frameCount ) {
		// 		mplayer_.setFrame(m);

		// 		// read all image in a frame
		// 		mplayer_.drawFrame( minfo );
		// 		trace( minfo.toString() );

		// 		// read the collision box
		// 		var colliderCount : Int = mplayer_.getNumberOfCollisionRect();
		// 		for( u in 0 ... colliderCount ) {
		// 			minfo.addCollider( mplayer_.getCollisionRect( u ) );
		// 		}
		// 	}

		// 	minfos_.push( minfo );
		// }


		// trace( "msimpleAnimationPlayer_.getAnimationCount(): " + msimpleAnimationPlayer_.getAnimationCount() );
		// for( m in 0 ... msimpleAnimationPlayer_.getAnimationCount() ) {
		// 	msimpleAnimationPlayer_.setAnimation(m);
		// 	for( n in 0 ... msimpleAnimationPlayer_.getFrameCount() ) {
		// 		msimpleAnimationPlayer_.setFrame(n);
		// 		var targetDrawImageInfo : DrawImageInfo = null;
		// 		msimpleAnimationPlayer_.drawFrame( mgraphics );
		// 		for( i in 0 ... mgraphics.drawImageInfos.length ) {
		// 			targetDrawImageInfo = mgraphics.drawImageInfos[i];
		// 			// trace( "m: " + m + ", n: " + n + ", i: " + i );
		// 			trace( targetDrawImageInfo );
		// 			var newEntity : GameEntity = GameEntityFactor.getInstance().CreateWithMSpriteData( _kernel, targetDrawImageInfo );
		// 			this.addEntity( newEntity, true, i );
		// 			// newEntity.setPosition( 100, 100 );
		// 			newEntity.x += n * 180 + targetDrawImageInfo.xPos + 100;
		// 			newEntity.y = 100 + targetDrawImageInfo.yPos;
		// 		}
		// 		// trace( "\n" );
		// 	}
	// }
}

typedef AnimationCompleteDelegate = MAnimationSet -> Int -> Void;
typedef AnimationEventDelegate = MAnimationSet -> MAnimation -> MFrame -> Int -> Void;

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
	var animationEventDelegate_ : AnimationEventDelegate = null;

	var specTargetCallbackObj_ : Dynamic = null;
	var specAnimationCompleteDelegate_ : AnimationCompleteDelegate = null;
	var specAnimationEventDelegate_ : AnimationEventDelegate = null;
	
	public var currentAnimation( getCurrentAnimation, null ) : MAnimation;
	public var currentFrame( getCurrentFrame, null ) : MFrame;
	public var previousFrame( getPreviousFrame, null ) : Int;
	public var targetCallbackObj( getTargetCallbackObj, setTargetCallbackObj ) : Dynamic = null;
	public var animationCompleteDelegate( getAnimationCompleteDelegate, setAnimationCompleteDelegate ) : AnimationCompleteDelegate;
	public var animationEventDelegate( getAnimationEventDelegate, setAnimationEventDelegate ) : AnimationEventDelegate;

	public function new( animations : Array<MAnimation> ) {
		animations_ = animations;
		// playAutomatically_ = playAutomatically;
		targetCallbackObj_ = targetCallbackObj;
		animationCompleteDelegate_ = animationCompleteDelegate;
		animationEventDelegate_ = animationEventDelegate;
	}

	// function start() : Void {
	// 	// base.Start();
		
	// 	if( playAutomatically_ )
	// 		play(currClipId_);
	// }
	
	public function playWithName(	name : String,
									orientation : Orientation,
									wrapMode : WrapMode,
									overrideCurr : Bool,
									targetCallbackObj : Dynamic = null,
									animationCompleteDelegate : AnimationCompleteDelegate = null,
									animationEventDelegate : AnimationEventDelegate = null ) : Void {
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
				overrideCurr,
				targetCallbackObj,
				animationCompleteDelegate,
				animationEventDelegate );
	}
	
	public function stop() : Void {
		currentAnimation_ = null;
	}
	
	public function isPlaying() : Bool {
		return currentAnimation_ != null;
	}

	public function play(	id : Int,
							orientation : Orientation,
							wrapMode : WrapMode,
							overrideCurr : Bool,
							targetCallbackObj : Dynamic = null,
							animationCompleteDelegate : AnimationCompleteDelegate = null,
							animationEventDelegate : AnimationEventDelegate = null ) : Void {
		if( !overrideCurr ) {
			if( id == currClipId_ ) {
				return ;
			}
		}

		specTargetCallbackObj_ = targetCallbackObj;
		specAnimationCompleteDelegate_ = animationCompleteDelegate;
		specAnimationEventDelegate_ = animationEventDelegate;

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
					if (specAnimationEventDelegate_ != null && specTargetCallbackObj_ != null ) {
						// animationEventDelegate( this, currentAnimation_, currentAnimation_.frames[0], 0 );
						Reflect.callMethod( specTargetCallbackObj_, specAnimationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[0], 0 ] );
					}
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
		if (specAnimationCompleteDelegate_ != null && specTargetCallbackObj_ != null ) {
			Reflect.callMethod( specTargetCallbackObj_, specAnimationCompleteDelegate_, [ this, currClipId_ ] );
		}
	}
	
	function setFrame( currFrame : Int ) : Void {
		if (previousFrame_ != currFrame)
		{
			// SwitchCollectionAndSprite( currentAnimation_.frames[currFrame].spriteCollection, currentAnimation_.frames[currFrame].spriteId );
			if ( currentAnimation_.frames[currFrame].triggerEvent ) {
				if (animationEventDelegate_ != null && targetCallbackObj_ != null ) {
					Reflect.callMethod( targetCallbackObj_, animationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[currFrame], currFrame ] );
				}
				if (specAnimationEventDelegate_ != null && specTargetCallbackObj_ != null ) {
					Reflect.callMethod( specTargetCallbackObj_, specAnimationEventDelegate_, [ this, currentAnimation_, currentAnimation_.frames[currFrame], currFrame ] );
				}
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

	function getTargetCallbackObj() : Dynamic {
		return targetCallbackObj_;
	}

	function setTargetCallbackObj( value : Dynamic ) : Dynamic {
		targetCallbackObj_ = value;
		return targetCallbackObj_;
	}

	function getAnimationCompleteDelegate() : AnimationCompleteDelegate {
		return animationCompleteDelegate_;
	}

	function setAnimationCompleteDelegate( value : AnimationCompleteDelegate ) : AnimationCompleteDelegate {
		animationCompleteDelegate_ = value;
		return animationCompleteDelegate_;
	}

	function getAnimationEventDelegate() : AnimationEventDelegate {
		return animationEventDelegate_;
	}

	function setAnimationEventDelegate( value : AnimationEventDelegate ) : AnimationEventDelegate {
		animationEventDelegate_ = value;
		return animationEventDelegate_;
	}
	
	// public var animationEventDelegate( ,  ) : AnimationEventDelegate;
}