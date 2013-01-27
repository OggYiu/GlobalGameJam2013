package firerice.entities;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.InputManager;
import firerice.entities.Actor;
import firerice.entities.Monster;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import firerice.game.CollisionManager;
import firerice.game.CollisionBox;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;

/**
 * ...
 * @author oggyiu
 */

class Player extends Actor {
	public static var PLAYER_VELOCITY : Float = 180;
	// public static var PLAYER_VELOCITY : Float = 1800;
	
	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );
		isEnemy = false;

		playerType = ActorEntityType.player;
	}
}