package firerice.game;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.Process;
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
import nme.geom.Rectangle;
import com.eclecticdesignstudio.motion.Actuate;

class CollisionManager extends Process {
	public var collisionBoxes( default, null ) : Array<CollisionBox> = null;

	public function new() {
		super( "collisionManager" );
		collisionBoxes = new Array<CollisionBox>();
	}

	public function addCollisionBox( collisionBox : CollisionBox ) : Void {
		collisionBoxes.push( collisionBox );
	}

	public function removeCollisionBox( p_owner : Player ) : Void {
		for( box in collisionBoxes ) {
			if( box.owner == p_owner ) {
				collisionBoxes.remove( box );
				break;
			}
		}
		// collisionBoxs.push( collisionBox );
	}

	static var s_canInit_ : Bool = false;
	static var s_instance_ : CollisionManager = null;
	public static function getInstance() : CollisionManager {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new CollisionManager();
			s_canInit_ = false;
		}

		return s_instance_;
	}
}