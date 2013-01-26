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
import nme.geom.Rectangle;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;

/**
 * ...
 * @author oggyiu
 */

class SceneRoom extends Scene
{
	public static var ID : String = "sceneRoom";

	public var blackWhiteMap( default, null ) : BitmapData = null;
	public var floorLayer( default, null ) : Sprite = null;

	var exit_ : Bool = false;
	var player_ : Player = null;
	public function new( p_parentContext : Sprite ) {
		super( SceneRoom.ID, p_parentContext );

		floorLayer = new Sprite();
		this.context.addChild( floorLayer );

		blackWhiteMap = Assets.getBitmapData( "assets/img/ROOM_BW.png" );

		var bitmap : Bitmap = new Bitmap( Assets.getBitmapData( "assets/img/ROOM_01.png" ) );
		floorLayer.addChild( bitmap );
		this.context.addChild( floorLayer );
		// bitmap.x = ( 1024 - bitmap.width ) / 2;
		// bitmap.y = ( 768 - bitmap.height ) / 2;

		player_ = new Player( "player");
		this.addChild( player_ );
		this.context.addChild( player_.context );
		player_.context.x = player_.x = 512;
		player_.context.y = player_.y = 389;
		// player_.addComponent( new TransformComponent( player_, 512, 389, 0 ) );
		player_.addComponent( new AnimationComponent( player_, "assets/motionwelder/girl" ) );
		Global.getInstance().GameCharacter = player_;

		this.context.addChild( CollisionManager.getInstance().context );
		CollisionManager.getInstance().addCollisionBox( new CollisionBox( null, new Rectangle( 415, 772, 175, 18 ) ) );
		CollisionManager.getInstance().target = this;
		CollisionManager.getInstance().handler = onCollide;

		// test
		// var bitmap : Bitmap = new Bitmap( blackWhiteMap );
		// bitmap.alpha = 0.5;
		// this.context.addChild( bitmap );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( exit_ ) {
			return ;
		}
		
		var modX : Float = 0;
		var modY : Float = 0;
		var targetPos : Float = 0;
		var backupPosX : Float = player_.x;
		var backupPosY : Float = player_.y;
		if( InputManager.getInstance().isKeyOnPress( 38 ) ) {
			player_.y = player_.y - Player.PLAYER_VELOCITY * dt;
			modY -= Player.PLAYER_VELOCITY * dt;

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
			modY += Player.PLAYER_VELOCITY * dt;
			player_.y = player_.y + Player.PLAYER_VELOCITY * dt;

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
			modX -= Player.PLAYER_VELOCITY * dt;
			player_.x = player_.x - Player.PLAYER_VELOCITY * dt;
			player_.playAnim( ActorAnimType.walkLeft );
		}
		if( InputManager.getInstance().isKeyOnPress( 39 ) ) {
			modX += Player.PLAYER_VELOCITY * dt;
			player_.x = player_.x + Player.PLAYER_VELOCITY * dt;
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

		// this.context.alpha = 0.0;
		// Actuate.tween( this.context, 1, { alpha : 1 } );
	}

	function onCollide( boxA : CollisionBox, boxB : CollisionBox ) : Void {
		exit_ = true;
		Actuate.tween( this.context, 1, { alpha : 0 } ).onComplete( onGameOver );
		boxA.dead = true;
		boxB.dead = true;
	}

	override function dispose_() : Void {
		super.dispose_();

		Global.getInstance().cameraPos.x = 0;
		Global.getInstance().cameraPos.y = 0;
	}

	function blackWhiteMapHitTest( p_x : Float, p_y : Float, p_width : Float, p_height : Float ) : Bool {
		for( x in Std.int(p_x) ... Std.int( p_width + p_x ) ) {
			for( y in Std.int(p_y) ... Std.int( p_height + p_y ) ) {

				// trace( "x: " + x + ", y: " + y + ", value: " + this.blackWhiteMap.getPixel( x, y ) );
				if( this.blackWhiteMap.getPixel( x, y ) == 0 ) {
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
	}

	function onGameOver() : Void {
		CollisionManager.getInstance().reset();
		Kernal.getInstance().changeScene( SceneGame.ID );
	}

}