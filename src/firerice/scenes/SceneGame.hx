package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.common.Global;
import firerice.core.Kernal;
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
import firerice.ui.UIScrollBg;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.media.Sound;
import nme.geom.Point;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;

/**
 * ...
 * @author oggyiu
 */

class SceneGame extends Scene
{
	public static var ID : String = "sceneGame";
	static var PLAYER_VELOCITY : Float = 300;

	var scrollBg_ : UIScrollBg = null;
	var player_ : Player = null;
	var monster_ : Monster = null;
	var bgMusic_ : Sound = null;
	var isGameOver_ : Bool = false;

	public var blackWhiteMap( default, null ) : BitmapData = null;
	public var floorLayer( default, null ) : Sprite = null;
	public var playerCharacterLayer( default, null ) : Sprite = null;
	public var enemyCharacterLayer( default, null ) : Sprite = null;
	public var obstaclesLayer( default, null ) : Sprite = null;
	public var fogLayer( default, null ) : Sprite = null;

	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );

		Global.getInstance().sceneGame = this;
		
		blackWhiteMap = Assets.getBitmapData( "assets/img/MAP_BW.png" );

		floorLayer = new Sprite();
		playerCharacterLayer = new Sprite();
		enemyCharacterLayer = new Sprite();
		obstaclesLayer = new Sprite();
		fogLayer = new Sprite();

		// scrollBg_ = new UIScrollBg("scrollBg",
		// 							this,
		// 							Assets.getBitmapData( "assets/img/eyeTile.png" ),
		// 							0,
		// 							0,
		// 							1024,
		// 							768,
		// 							20,
		// 							20 );

		this.context.addChild( floorLayer );
		this.context.addChild( obstaclesLayer );
		// obstaclesLayer.addChild( new Bitmap( blackWhiteMap ) );
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
		player_.addComponent( new AnimationComponent( player_, "assets/motionwelder/girl" ) );

		monster_ = new Monster( "monster1");
		monster_.x = 300;
		monster_.y = 300;
		this.addChild( monster_ );
		enemyCharacterLayer.addChild( monster_.context );
		// monster_.addComponent( new TransformComponent( monster_, 200, 200, 0 ) );
		monster_.addComponent( new AnimationComponent( monster_, "assets/motionwelder/monster1" ) );

		var points:Array<Point> = new Array<Point>();
		points[0] = new Point(300, 200);
		points[1] = new Point(300, 300);
		points[2] = new Point(150, 150);
		monster_.setWayPoint(points);

		bgMusic_ = Assets.getSound ("assets/audio/ambient.mp3");
		var bgChannel : nme.media.SoundChannel = bgMusic_.play( 0, 10000 );
		// bgChannel.soundTransform.volume = 0.0;


		HeartBeat.getInstance();
		CollisionManager.getInstance().target = this;
		CollisionManager.getInstance().handler = onCollide;
	}

	override function update_( dt : Float ) : Void {
		if( isGameOver_ ) {
			return ;
		}

		super.update_( dt );
		var modX : Float = 0;
		var modY : Float = 0;
		var targetPos : Float = 0;
		var backupPosX : Float = player_.x;
		var backupPosY : Float = player_.y;
		if( InputManager.getInstance().isKeyOnPress( 38 ) ) {
			player_.y = player_.y - PLAYER_VELOCITY * dt;
			modY -= PLAYER_VELOCITY * dt;

			if(	player_.currAnimType == ActorAnimType.idleRight ||
				player_.currAnimType == ActorAnimType.walkRight) {
				player_.playAnim( ActorAnimType.walkRight );
			}
			else if(player_.currAnimType == ActorAnimType.idleLeft ||
					player_.currAnimType == ActorAnimType.walkLeft) {
				player_.playAnim( ActorAnimType.walkLeft );
			}
		}
		if( InputManager.getInstance().isKeyOnPress( 40 ) ) {
			modY += PLAYER_VELOCITY * dt;
			player_.y = player_.y + PLAYER_VELOCITY * dt;

			if(	player_.currAnimType == ActorAnimType.idleRight ||
				player_.currAnimType == ActorAnimType.walkRight) {
				player_.playAnim( ActorAnimType.walkRight );
			}
			else if(player_.currAnimType == ActorAnimType.idleLeft ||
					player_.currAnimType == ActorAnimType.walkLeft) {
				player_.playAnim( ActorAnimType.walkLeft );
			}
		}
		if( InputManager.getInstance().isKeyOnPress( 37 ) ) {
			modX -= PLAYER_VELOCITY * dt;
			player_.x = player_.x - PLAYER_VELOCITY * dt;
			player_.playAnim( ActorAnimType.walkLeft );
		}
		if( InputManager.getInstance().isKeyOnPress( 39 ) ) {
			modX += PLAYER_VELOCITY * dt;
			player_.x = player_.x + PLAYER_VELOCITY * dt;
			player_.playAnim( ActorAnimType.walkRight );
		}
		if( !InputManager.getInstance().hasKeyPressed() ) {
			if( player_.currAnimType == ActorAnimType.walkRight ) {
				player_.playAnim( ActorAnimType.idleRight );
			}
			if( player_.currAnimType == ActorAnimType.walkLeft ) {
				player_.playAnim( ActorAnimType.idleLeft );
			}
		}

		// check collision box
		if( player_.currentFrame.colliders.length > 0 ) {
			var rect : nme.geom.Rectangle = player_.currentFrame.colliders[0];
			if( blackWhiteMapHitTest( player_.x + rect.x, player_.y + rect.y, rect.width, rect.height ) ) {
				player_.x = backupPosX;
				player_.y = backupPosY;
				modX = 0;
				modY = 0;
			}
		}

		moveCamera( modX, modY );
		CollisionManager.getInstance().update( dt );
		monster_.context.x = monster_.x - Global.getInstance().cameraPos.x;
		monster_.context.y = monster_.y - Global.getInstance().cameraPos.y;

		// scrollBg_.update( dt );

		// if( InputManager.getInstance().mouseDown ) {
		// 	blackWhiteMapHitTest(	InputManager.getInstance().mousePos.x, InputManager.getInstance().mousePos.y,
		// 							10, 10 );
		// }
	}

	function blackWhiteMapHitTest( p_x : Float, p_y : Float, p_width : Float, p_height : Float ) : Bool {
		for( x in Std.int(p_x) ... Std.int( p_width + p_x ) ) {
			for( y in Std.int(p_y) ... Std.int( p_height + p_y ) ) {

				// trace( "x: " + x + ", y: " + y + ", value: " + this.blackWhiteMap.getPixel( x, y ) );
				if( this.blackWhiteMap.getPixel( x, y ) == 0 ) {
					// trace( "true:" );
					return true;
				}
			}
		}
		return false;
	}

	function moveCamera( modX : Float, modY : Float ) : Void {
		Global.getInstance().cameraPos.x += modX;
		Global.getInstance().cameraPos.y += modY;

		floorLayer.x = floorLayer.x - modX;
		floorLayer.y = floorLayer.y - modY;
		obstaclesLayer.x = obstaclesLayer.x - modX;
		obstaclesLayer.y = obstaclesLayer.y - modY;
	}

	function onCollide( boxA : CollisionBox, boxB : CollisionBox ) : Void {
		isGameOver_ = true;
		Actuate.tween( this.context, 1, { alpha : 0 } ).onComplete( onGameOver );
	}

	function onGameOver() : Void {
		Global.getInstance().sceneGame = null;
		Kernal.getInstance().changeScene( SceneRoom.ID );
	}
}
