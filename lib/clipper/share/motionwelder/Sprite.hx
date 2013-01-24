package clipper.share.motionwelder;

import nme.display.BitmapData;
import nme.geom.Rectangle;

import clipper.share.Debug;
import clipper.share.motionwelder.MReader;

class PrimitiveBase {
	public var color : Int;

	public function new() {
		color = 0;
	}
}

class Line extends PrimitiveBase {
	public var x1 : Float;
	public var y1 : Float;
	public var x2 : Float;
	public var y2 : Float;

	public function new() {
		super();

		x1 = 0;
		y1 = 0;
		x2 = 0;
		y2 = 0;
	}
}

class Rect extends PrimitiveBase {
	public function new() {
		super();
	}
}

class RoundRect extends PrimitiveBase {
	public function new() {
		super();
	}
}

class Circle extends PrimitiveBase {
	public function new() {
		super();
	}
}

// a clip ( class Clip ) in a frame
class FrameClip {
	var x : Float;
	var y : Float;
	var clipId : Int;
	var orientation : Orientation;

	public function new() {
		x = 0;
		y = 0;
		clipId = 0;
		orientation = Orientation.none;
	}
}

// a single frame in an animation
class Frame {
	var frameId_ : String;
	var frameClips_ : Array<FrameClip>;
	var colliders_ : Array<Rectangle>;
	var primitives_ : Array<PrimitiveBase>;
	var delayCount_ : Int; // in motionwelder value

	public var Id( getId, null ) : String;

	public function new() {
		// frameClips = new Array<FrameClip>();
		// colliders = new Array<Rectangle>();
		// primitives = new Array<PrimitiveBase>();
		frameId_ = "";
		frameClips_ = null;
		colliders_ = null;
		primitives_ = null;
		delayCount_ = 0;
	}

	function getId() : String {
		return frameId_;
	}
}

// an animation like attack, move left, move right etc.
class Animation {
	var animationId : String;
	var frames : Array<Frame>;
	var wrapMode : WrapMode;
	var playAutomatically_ : Bool;
	var curFrameIndex_ : Int;

	public function new() {
		animationId = "";
		frames = null;
		wrapMode = WrapMode.once;
		curFrameIndex_ = 0;

		if( playAutomatically_ ) {
			play( curFrameIndex_ );
		}
	}

	function getFrameIndexWithId( frameId : String ) : Int {
		for( i in 0 ... frames.length ) {
			if( frames[i].Id == frameId ) {
				return i;
			}
		}

		Debug.Assert( false, "<Sprite::getFrameIndexWithId>, frameId not found!" );
		return -1;
	}
	public function playWithName( frameId : String ) : Void {
		play( getFrameIndexWithId( frameId ) );
	}

	public function play( frameIndex : Int ) : Void {
	}
}

class AnimationSprite {
	var animations_ : Array<Animation>;

	public function new() {
		animations_ = null;
	}
}

// the original spritesheet image
class ImageInfo {
	public var Id : String;
	public var bitmapdata : BitmapData;

	public function new() {
		Id = "";
		bitmapdata = null;
	}
}

// info to create the bitmapdata of a clip
class ClipInfo {
	public var imageId : String;
	public var x : Int;
	public var y : Int;
	public var width : Int;
	public var height : Int;
	public var orientation : Int;

	public function new() {
		imageId = "";
		x = 0;
		y = 0;
		width = 0;
		height = 0;
	}
}

// a single sprite from a spritesheet
class Clip {
	// contain images with different orientation
	var bitmapdata_ : Array<BitmapData>;

	public function new() {
		bitmapdata_ = null;
	}

	function generateBitmapdata( clipInfo : ClipInfo ) : Void {
	}

	public function getBitmapData( orientation : Orientation ) : BitmapData {
		return bitmapdata_[Type.enumIndex(orientation)];
	}
}