package firerice.core.motionwelder;

// import nme.display.Bitmap;
import firerice.types.EOrientation;
import nme.display.BitmapData;
import nme.geom.Rectangle;

enum WrapMode {
	loop;
	loopSection;
	once;
	pingPong;
	single;
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