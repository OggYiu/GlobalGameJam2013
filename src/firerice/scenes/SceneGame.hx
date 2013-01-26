package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.components.CommandComponent;
import firerice.common.Global;
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
import firerice.game.HeartBeat;
import firerice.game.CollisionBox;
import firerice.game.CollisionManager;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.media.Sound;
import nme.geom.Point;

/**
 * ...
 * @author oggyiu
 */

class SceneGame extends Scene
{
	public static var ID : String = "sceneGame";
	static var PLAYER_VELOCITY : Float = 8;

	var player_ : Player = null;

	var monster_ : Monster = null;
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
		this.context.addChild( obstaclesLayer );
		this.context.addChild( playerCharacterLayer );
		this.context.addChild( enemyCharacterLayer );
		this.context.addChild( fogLayer );
		this.context.addChild( CollisionManager.getInstance().context );

		floorLayer.addChild( new Bitmap( Assets.getBitmapData( "assets/img/MAP_001.png" ) ) );
		obstaclesLayer.addChild( new Bitmap( Assets.getBitmapData( "assets/img/MAP_002.png" ) ) );

		player_ = new Player( "player");
		this.addChild( player_ );
		playerCharacterLayer.addChild( player_.context );
		player_.context.x = player_.x = 512;
		player_.context.y = player_.y = 389;
		// player_.addComponent( new TransformComponent( player_, 512, 389, 0 ) );
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

		bgMusic_ = Assets.getSound ("assets/audio/bg.mp3");
		bgMusic_.play( 0, 1000 );

		HeartBeat.getInstance();
		CollisionManager.getInstance().target = this;
		CollisionManager.getInstance().handler = onCollide;
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
		var modX : Float = 0;
		var modY : Float = 0;
		if( InputManager.getInstance().isKeyOnPress( 38 ) ) {
			modY -= PLAYER_VELOCITY;
			// player_.x = player_.context.x;
			player_.y = player_.y - PLAYER_VELOCITY;
			// player_.y += PLAYER_VELOCITY;

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
			modY += PLAYER_VELOCITY;
			player_.y = player_.y + PLAYER_VELOCITY;
			// player_.y -= PLAYER_VELOCITY;
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
			modX -= PLAYER_VELOCITY;
			player_.x = player_.x - PLAYER_VELOCITY;
			// player_.x += PLAYER_VELOCITY;
			player_.playAnim( ActorAnimType.walkLeft );
			// floorLayer.x += PLAYER_VELOCITY;
			// obstacesLayer.x += PLAYER_VELOCITY;
			// fogLayer.x += PLAYER_VELOCITY;
			// enemyCharacterLayer.x += PLAYER_VELOCITY;
		}
		if( InputManager.getInstance().isKeyOnPress( 39 ) ) {
			modX += PLAYER_VELOCITY;
			player_.x = player_.x + PLAYER_VELOCITY;
			// player_.x -= PLAYER_VELOCITY;
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

		moveCamera( modX, modY );
		CollisionManager.getInstance().update( dt );
	}

	function moveCamera( modX : Float, modY : Float ) : Void {
		Global.getInstance().cameraPos.x += modX;
		Global.getInstance().cameraPos.y += modY;
		floorLayer.x = floorLayer.x - modX * 2;
		floorLayer.y = floorLayer.y - modY * 2;

		obstaclesLayer.x = obstaclesLayer.x - modX * 2;
		obstaclesLayer.y = obstaclesLayer.y - modY * 2;
	}

	function onCollide( boxA : CollisionBox, boxB : CollisionBox ) : Void {
		trace( "onCollide : " + boxA + ", b: " + boxB );
	}
}
