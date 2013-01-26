package firerice.game;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.InputManager;
import firerice.entities.Actor;
import firerice.entities.Player;
import firerice.entities.Monster;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.media.Sound;
import com.eclecticdesignstudio.motion.Actuate;

class HeartBeat {
	public var DEFAULT_FEQUENCE : Float = 1;
	public var MAX_FEQUENCE : Float = 100;
	public var frequence( default, default ) : Float;

	// var sound_ : Sound = null;
	var heartBeatA_ : Sound = null;
	var heartBeatB_ : Sound = null;
	var heartBeatChannelA_ : nme.media.SoundChannel = null;
	var heartBeatChannelB_ : nme.media.SoundChannel = null;

	public function new() {
		// super( "heartBeat" );
		frequence = DEFAULT_FEQUENCE;

		// var soundChannel = sound_.play ();
		// soundChannel.addEventListener (Event.COMPLETE, onComplete );
		// soundChannel.stop();
		heartBeatA_ = Assets.getSound( "assets/audio/heartbeatA.mp3" );
		heartBeatB_ = Assets.getSound( "assets/audio/heartbeatB.mp3" );
	}

	public function play() : Void {
		heartBeatChannelA_ = null;
		heartBeatChannelB_ = null;
		playHeartBeatA();
	}

	public function stop() : Void {
		if( heartBeatChannelA_ != null ) {
			heartBeatChannelA_.stop();
		}
		if( heartBeatChannelB_ != null ) {
			heartBeatChannelB_.stop();
		}
	}

	function playHeartBeatA() : Void {
		if( heartBeatChannelB_ != null ) {
			heartBeatChannelB_.stop();
			heartBeatChannelB_ = null;
		}

		heartBeatChannelA_ = heartBeatA_.play ();
		// soundChannel.addEventListener (Event.COMPLETE, onComplete );
		heartBeatChannelA_.addEventListener(Event.SOUND_COMPLETE, onHeartBeatAComplete);
		// soundChannel.stop();
	}

	function playHeartBeatB() : Void {
		if( heartBeatChannelA_ != null ) {
			heartBeatChannelA_.stop();
			heartBeatChannelA_ = null;
		}

		heartBeatChannelB_ = heartBeatB_.play ();
		// soundChannel.addEventListener (Event.COMPLETE, onComplete );
		heartBeatChannelB_.addEventListener(Event.SOUND_COMPLETE, onHeartBeatBComplete);
		// soundChannel.stop();
	}
	
	function onHeartBeatAComplete( e : Event ) : Void {
		Actuate.tween( heartBeatA_, ( 1 / frequence ) / 4, [] ).onComplete( playHeartBeatB );
	}

	function onHeartBeatBComplete( e : Event ) : Void {
		Actuate.tween( heartBeatA_, (1 / frequence ), [] ).onComplete( playHeartBeatA );
	}

	static var s_canInit_ : Bool = false;
	static var s_instance_ : HeartBeat = null;
	public static function getInstance() : HeartBeat {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new HeartBeat();
			s_canInit_ = false;
		}

		return s_instance_;
	}
}