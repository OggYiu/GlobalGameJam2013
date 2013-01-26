package firerice.game;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
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
	public var DEFAULT_FEQUENCE : Int = 1;
	public var frequence( default, default ) : Int;

	var sound_ : Sound = null;

	public function new() {
		// super( "heartBeat" );
		frequence = DEFAULT_FEQUENCE;

		sound_ = Assets.getSound( "assets/audio/heartbeat.mp3" );
		playSound();
		// var soundChannel = sound_.play ();
		// soundChannel.addEventListener (Event.COMPLETE, onComplete );
		// soundChannel.stop();
	}

	function playSound() : Void {
		var soundChannel = sound_.play ();
		// soundChannel.addEventListener (Event.COMPLETE, onComplete );
		soundChannel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		// soundChannel.stop();
	}
	
	function onComplete( e : Event ) : Void {
		Actuate.tween( sound_, 1 / frequence, [] ).onComplete( playSound );
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