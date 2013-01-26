package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.InputManager;
import firerice.entities.Player;
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
	static var CAMERA_VELOCITY : Float = 20;

	var player_ : Player = null;
	var monster_ : Monster = null;
	var livingRoom_ : LivingRoom = null;

	public var floorLayer( default, null ) : Sprite = null;
	public var playerCharacterLayer( default, null ) : Sprite = null;
	public var enemyCharacterLayer( default, null ) : Sprite = null;
	public var obstaclesLayer( default, null ) : Sprite = null;
	public var fogLayer( default, null ) : Sprite = null;

	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );

		floorLayer = new Sprite();
		playerCharacterLayer = new Sprite();
		enemyCharacterLayer = new Sprite();
		obstaclesLayer = new Sprite();
		fogLayer = new Sprite();

		this.context.addChild( floorLayer );
		this.context.addChild( playerCharacterLayer );
		this.context.addChild( enemyCharacterLayer );
		this.context.addChild( obstaclesLayer );
		this.context.addChild( fogLayer );

		livingRoom_ = new LivingRoom( "living room" );
		this.addChild( livingRoom_ );
		floorLayer.addChild( livingRoom_.context );

		player_ = new Player( "monster1");
		this.addChild( player_ );
		playerCharacterLayer.addChild( player_.context );
		player_.addComponent( new TransformComponent( player_, 300, 300, 0 ) );
		player_.addComponent( new AnimationComponent( player_, "assets/motionwelder/monster1" ) );

		// monster_ = new Monster( "monster1");
		// this.addChild( monster_ );
		// playerCharacterLayer.addChild( monster_.context );
		// monster_.addComponent( new TransformComponent( monster_, 300, 300, 0 ) );
		// monster_.addComponent( new AnimationComponent( monster_, "assets/motionwelder/monster1" ) );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
		if( InputManager.getInstance().isKeyOnPress( 38 ) ) {
			floorLayer.y += CAMERA_VELOCITY;
			obstaclesLayer.y += CAMERA_VELOCITY;
			fogLayer.y += CAMERA_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 40 ) ) {
			floorLayer.y -= CAMERA_VELOCITY;
			obstaclesLayer.y -= CAMERA_VELOCITY;
			fogLayer.y -= CAMERA_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 37 ) ) {
			floorLayer.x += CAMERA_VELOCITY;
			obstaclesLayer.x += CAMERA_VELOCITY;
			fogLayer.x += CAMERA_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 39 ) ) {
			floorLayer.x -= CAMERA_VELOCITY;
			obstaclesLayer.x -= CAMERA_VELOCITY;
			fogLayer.x -= CAMERA_VELOCITY;
		}
	}
}