package clipper.entities;

import awe6.core.Context;
import awe6.interfaces.IKernel;

// import nme.display.Sprite;
import nme.display.Bitmap;

import clipper.share.motionwelder.MReader;
import clipper.share.Debug;
import clipper.share.Defines;

class AnimatedEntity extends MovableEntity {
	var animDef_ : MAnimationDefine = null;
	var animSet_ : MAnimationSet = null;
	var contextBitmap_ : Bitmap = null;

	public function new(p_kernel:IKernel, animationSet : MAnimationSet, animDef : MAnimationDefine ) {
		super( p_kernel, new Context() );

		// test: define animation defination
		animDef_ = animDef;

		animSet_ = animationSet;
		// animSet_.play(1);
		// animSet_.update(0);
		animSet_.targetCallbackObj = this;
		animSet_.animationCompleteDelegate = AnimationCompleteHandler;
		animSet_.animationEventDelegate = AnimationEventHandler;
		// animSet_.log( "\t" );

		// var currentAnimation : MAnimation = animSet_.currentAnimation;
		// var currentFrameIndex : Int = animSet_.previousFrame;
		// if( currentAnimation == null ) {
		// 	throw "<MGameEntity::new>, invalid currentAnimation!";
		// }
		// if( currentFrameIndex < 0 ) {
		// 	throw "<MGameEntity::new>, invalid currentFrameIndex!";
		// }
		// var currentFrame : MFrame = animationSet.currentFrame;
		// if( currentFrame != null ) {
		// contextBitmap_ = new Bitmap( currentFrame.frameImages[0].bitmapdata );
		contextBitmap_ = new Bitmap();
			// var tempSprte : Sprite = new Sprite( bitmap );
		this.context_.addChild( contextBitmap_ );
		// var targetFrame : MFrame;
		// for( i in 0 ... currentClip.frames.length ) {
		// 	targetFrame = currentClip.frames[i];
		// }

		// playWithAnimName( "attack" );
	}

	override private function _updater( ?p_deltaTime:Int = 0 ) : Void {
		super._updater( p_deltaTime );
		// animSet_.update( p_deltaTime / 10080 );
		animSet_.update( p_deltaTime / 1000 );
	}

	public function playAnimWithName(	name : String,
										orientation : Orientation,
										wrapMode : WrapMode,
										overrideCurr : Bool,
										targetCallbackObj : Dynamic = null,
										animationCompleteDelegate : AnimationCompleteDelegate = null,
										animationEventDelegate : AnimationEventDelegate = null ) : Void {
		animSet_.play(	animDef_.getIndex( name ),
						orientation,
						wrapMode,
						overrideCurr,
						targetCallbackObj,
						animationCompleteDelegate,
						animationEventDelegate );
	}

	public function playAnimWithId(	id : Int,
									orientation : Orientation,
									wrapMode : WrapMode,
									overrideCurr : Bool,
									targetCallbackObj : Dynamic = null,
									animationCompleteDelegate : AnimationCompleteDelegate = null,
									animationEventDelegate : AnimationEventDelegate = null ) : Void {
		animSet_.play(	id,
						orientation,
						wrapMode,
						overrideCurr,
						targetCallbackObj,
						animationCompleteDelegate,
						animationEventDelegate );
	}

	function AnimationCompleteHandler(	animationSet : MAnimationSet,
										clipId : Int) : Void {
		// trace( "<MGameEntity::AnimationCompleteHandler>" );
	}

	function AnimationEventHandler(	animationSet : MAnimationSet,
									animation : MAnimation,
									frame : MFrame,
									unknown : Int ) : Void {
		// trace( "<MGameEntity::AnimationEventHandler>" );
		contextBitmap_.bitmapData = frame.frameImages[0].bitmapdata;
		contextBitmap_.x = frame.frameImages[0].xPos;
		contextBitmap_.y = frame.frameImages[0].yPos;

		// trace( "<MGameEntity::AnimationEventHandler>, contextBitmap_.bitmapData: " + contextBitmap_.bitmapData );
	}
}