package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.InputManager;
import firerice.entities.Monster;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import firerice.game.LivingRoom;
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

class SceneGame extends Scene
{
	public static var ID : String = "sceneGame";
	static var CAMERA_VELOCITY : Float = 50;

	var monster_ : Monster = null;
	var livingRoom_ : LivingRoom = null;

	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );

		livingRoom_ = new LivingRoom( "living room", this );

		monster_ = new Monster( "monster1", this );
		monster_.addComponent( new TransformComponent( monster_, 300, 300, 0 ) );
		monster_.addComponent( new AnimationComponent( monster_, "assets/motionwelder/monster1" ) );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
		if( InputManager.getInstance().isKeyOnPress( 38 ) ) {
			livingRoom_.context.y += CAMERA_VELOCITY;
		} else if( InputManager.getInstance().isKeyOnPress( 40 ) ) {
			livingRoom_.context.y -= CAMERA_VELOCITY;
		}
	}
}