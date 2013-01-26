package firerice.scenes;
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
import firerice.game.LivingRoom;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.media.Sound;
import flash.geom.Point;

/**
 * ...
 * @author oggyiu
 */

class SceneGame extends Scene
{
	public static var ID : String = "sceneGame";
	static var PLAYER_VELOCITY : Float = 10;

	var player_ : Player = null;

	var monster_ : Monster = null;
	var livingRoom_ : LivingRoom = null;
	var bgMusic_ : Sound = null;

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

		player_ = new Player( "player");
		this.addChild( player_ );
		playerCharacterLayer.addChild( player_.context );
		player_.addComponent( new TransformComponent( player_, 100, 100, 0 ) );
		player_.addComponent( new AnimationComponent( player_, "assets/motionwelder/boy" ) );

		monster_ = new Monster( "monster1");
		this.addChild( monster_ );
		enemyCharacterLayer.addChild( monster_.context );
		monster_.addComponent( new TransformComponent( monster_, 200, 200, 0 ) );
		monster_.addComponent( new AnimationComponent( monster_, "assets/motionwelder/monster1" ) );

		var points:Array<Point> = new Array<Point>();
		points[0] = new Point(300, 200);
		points[1] = new Point(300, 300);
		points[2] = new Point(150, 150);
		monster_.setWayPoint(points);
		//monster_.move(400, 400, 2);

		bgMusic_ = Assets.getSound ("assets/audio/bg.mp3");
		bgMusic_.play( 0, 1000 );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
		if( InputManager.getInstance().isKeyOnPress( 38 ) ) {
			// player_.x = player_.context.x;
			player_.y = player_.context.y - PLAYER_VELOCITY;

			if(	player_.currAnimType == ActorAnimType.idleRight ||
				player_.currAnimType == ActorAnimType.walkRight) {
				player_.playAnim( ActorAnimType.walkRight );
			}
			else if(player_.currAnimType == ActorAnimType.idleLeft ||
					player_.currAnimType == ActorAnimType.walkLeft) {
				player_.playAnim( ActorAnimType.walkLeft );
			}
			// floorLayer.y += PLAYER_VELOCITY;
			// obstaclesLayer.y += PLAYER_VELOCITY;
			// fogLayer.y += PLAYER_VELOCITY;
			// enemyCharacterLayer.y += PLAYER_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 40 ) ) {
			player_.y = player_.context.y + PLAYER_VELOCITY;
			if(	player_.currAnimType == ActorAnimType.idleRight ||
				player_.currAnimType == ActorAnimType.walkRight) {
				player_.playAnim( ActorAnimType.walkRight );
			}
			else if(player_.currAnimType == ActorAnimType.idleLeft ||
					player_.currAnimType == ActorAnimType.walkLeft) {
				player_.playAnim( ActorAnimType.walkLeft );
			}
			// floorLayer.y -= PLAYER_VELOCITY;
			// obstaclesLayer.y -= PLAYER_VELOCITY;
			// fogLayer.y -= PLAYER_VELOCITY;
			// enemyCharacterLayer.y -= PLAYER_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 37 ) ) {
			player_.x = player_.context.x - PLAYER_VELOCITY;
			player_.playAnim( ActorAnimType.walkLeft );
			// floorLayer.x += PLAYER_VELOCITY;
			// obstacesLayer.x += PLAYER_VELOCITY;
			// fogLayer.x += PLAYER_VELOCITY;
			// enemyCharacterLayer.x += PLAYER_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 39 ) ) {
			player_.x = player_.context.x + PLAYER_VELOCITY;
			player_.playAnim( ActorAnimType.walkRight );
			// floorLayer.x -= PLAYER_VELOCITY;
			// obstaclesLayer.x -= PLAYER_VELOCITY;
			// fogLayer.x -= PLAYER_VELOCITY;
			// enemyCharacterLayer.x -= PLAYER_VELOCITY;
		}
		if( !InputManager.getInstance().hasKeyPressed() ) {
			if( player_.currAnimType == ActorAnimType.walkRight ) {
				player_.playAnim( ActorAnimType.idleRight );
			}
			if( player_.currAnimType == ActorAnimType.walkLeft ) {
				player_.playAnim( ActorAnimType.idleLeft );
			}
		}
	}
}