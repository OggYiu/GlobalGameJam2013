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
import firerice.entities.Monster2;
import firerice.entities.Victim;
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
// import minimalcomps.VSlider;
import minimalcomps.ProgressBar;

/**
 * ...
 * @author oggyiu
 */

class SceneGame extends Scene
{
	public static var ID : String = "sceneGame";

	var scrollBg_ : UIScrollBg = null;
	var player_ : Player = null;

	//var monster_ : Monster = null;
	var monsterList : Array<Monster> = null;

	var bgMusic_ : Sound = null;
	var bgChannel_ : nme.media.SoundChannel = null;

	var isGameOver_ : Bool = false;

	public var blackWhiteMap( default, null ) : BitmapData = null;
	public var floorLayer( default, null ) : Sprite = null;
	public var playerCharacterLayer( default, null ) : Sprite = null;
	public var enemyCharacterLayer( default, null ) : Sprite = null;
	public var obstaclesLayer( default, null ) : Sprite = null;
	public var fogLayer( default, null ) : Sprite = null;
	public var interfaceLayer( default, null ) : Sprite = null;
	public var gameWon( default, default ) : Bool = false;

	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );

		Global.getInstance().sceneGame = this;
		
		blackWhiteMap = Assets.getBitmapData( "assets/img/MAP_BW.png" );

		floorLayer = new Sprite();
		playerCharacterLayer = new Sprite();
		enemyCharacterLayer = new Sprite();
		obstaclesLayer = new Sprite();
		fogLayer = new Sprite();
		interfaceLayer = new Sprite();
		monsterList = new Array<Monster>();

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
		this.context.addChild( interfaceLayer );
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
		Global.getInstance().GameCharacter = player_;

		if (Global.getInstance().currentLevel == 1)
		{
			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1700, 1200);
			points[1] = new Point(1700, 1400);
			points[2] = new Point(1600, 1400);
			this.createMonster(1600, 1200, points, "assets/motionwelder/npc_boy2");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(100, 350);
			points[1] = new Point(200, 450);
			points[2] = new Point(200, 550);
			this.createMonster(150, 350, points, "assets/motionwelder/npc_boy3");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(300, 1350);
			points[1] = new Point(400, 1250);
			points[2] = new Point(450, 1150);
			this.createVictim(350, 1200, points, "assets/motionwelder/npc_boy");
		}
		else if (Global.getInstance().currentLevel == 2)
		{
			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(100, 400);
			points[1] = new Point(200, 300);
			points[2] = new Point(100, 500);
			this.createMonster(200, 250, points, "assets/motionwelder/npc_boy");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1000, 1350);
			points[1] = new Point(1200, 1450);
			points[2] = new Point(1200, 1550);
			this.createMonster(1150, 1350, points, "assets/motionwelder/npc_boy3");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(500, 1350);
			points[1] = new Point(600, 1450);
			points[2] = new Point(400, 1550);
			this.createMonster(550, 1350, points, "assets/motionwelder/npc_boy3");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1000, 350);
			points[1] = new Point(1200, 450);
			points[2] = new Point(1200, 550);
			this.createMonster(1150, 350, points, "assets/motionwelder/npc_boy4");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(100, 1350);
			points[1] = new Point(200, 1450);
			points[2] = new Point(200, 1550);
			this.createMonster(150, 1350, points, "assets/motionwelder/npc_boy5");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1200, 1250);
			points[1] = new Point(1220, 1300);
			points[2] = new Point(1250, 1250);
			this.createMonster(1100, 1150, points, "assets/motionwelder/npc_boy");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1300, 1350);
			points[1] = new Point(1400, 1250);
			points[2] = new Point(1450, 1150);
			this.createVictim(1350, 1200, points, "assets/motionwelder/npc_boy2");
		}
		else if (Global.getInstance().currentLevel == 3)
		{
			/*
			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(280, 280);
			points[1] = new Point(200, 400);
			points[2] = new Point(150, 250);
			this.createMonster2(250, 250, points, "assets/motionwelder/npc_boy");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(620, 700);
			points[1] = new Point(530, 710);
			points[2] = new Point(650, 650);
			this.createMonster(700, 700, points, "assets/motionwelder/npc_boy2");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(950, 750);
			points[1] = new Point(850, 800);
			points[2] = new Point(900, 700);
			this.createMonster(900, 600, points, "assets/motionwelder/npc_boy3");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(950, 1550);
			points[1] = new Point(850, 1800);
			points[2] = new Point(900, 1700);
			this.createMonster(900, 1600, points, "assets/motionwelder/npc_boy4");
			*/

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(880, 380);
			points[1] = new Point(700, 400);
			points[2] = new Point(850, 350);
			this.createMonster(820, 450, points, "assets/motionwelder/npc_boy");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1180, 1480);
			points[1] = new Point(1100, 1300);
			points[2] = new Point(1050, 1450);
			this.createMonster(1120, 1350, points, "assets/motionwelder/npc_boy");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(700, 750);
			points[1] = new Point(850, 800);
			points[2] = new Point(750, 850);
			this.createMonster(750, 850, points, "assets/motionwelder/npc_boy2");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1700, 250);
			points[1] = new Point(1850, 300);
			points[2] = new Point(1750, 250);
			this.createMonster2(1750, 280, points, "assets/motionwelder/npc_boy2");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(200, 650);
			points[1] = new Point(250, 700);
			points[2] = new Point(250, 750);
			this.createMonster2(250, 650, points, "assets/motionwelder/npc_boy3");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1800, 650);
			points[1] = new Point(1750, 700);
			points[2] = new Point(1850, 750);
			this.createMonster2(1750, 650, points, "assets/motionwelder/npc_boy3");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1880, 880);
			points[1] = new Point(1700, 900);
			points[2] = new Point(1850, 850);
			this.createMonster(1820, 950, points, "assets/motionwelder/npc_boy4");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1280, 1280);
			points[1] = new Point(1300, 1300);
			points[2] = new Point(1450, 1450);
			this.createMonster(1220, 1250, points, "assets/motionwelder/npc_boy4");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(280, 1880);
			points[1] = new Point(370, 1900);
			points[2] = new Point(250, 1850);
			this.createMonster(220, 1950, points, "assets/motionwelder/npc_boy5");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1280, 1880);
			points[1] = new Point(1370, 1900);
			points[2] = new Point(1250, 1850);
			this.createMonster(1220, 1950, points, "assets/motionwelder/npc_boy5");

			var points:Array<Point> = new Array<Point>();
			points[0] = new Point(1700, 780);
			points[1] = new Point(1600, 720);
			points[1] = new Point(1500, 800);
			this.createVictim(1550, 850, points, "assets/motionwelder/npc_boy3");
		}

		bgMusic_ = Assets.getSound ("assets/audio/ambient.mp3");
		bgChannel_ = bgMusic_.play( 0, 10000 );
		// bgChannel.soundTransform.volume = 0.0;

		HeartBeat.getInstance().play();
		CollisionManager.getInstance().target = this;
		CollisionManager.getInstance().handler = onCollide;

		var maskLayer = new Sprite();
		maskLayer.addChild( new Bitmap( Assets.getBitmapData( "assets/img/LIGHT.png" ) ) );
		maskLayer.x = 0;
		maskLayer.y = -150;
		this.context.addChild(maskLayer);

		// interface
		// var heartBar : ProgressBar = new ProgressBar( this.interfaceLayer, 80, 40 );
		// heartBar.width = 800;
		// heartBar.height = 20;


		// var barHeight : Float = 400;
		// var slider : VSlider = new VSlider( this.interfaceLayer, 40, 100 );
		// slider.width = 20;
		// slider.height = barHeight;
		// slider.value = ;
	}

	private function createMonster2(p_x : Int, p_y : Int, p_wayPoints : Array<Point>, animationFilePath)
	{
		var monster_ = new Monster2("monster" + monsterList.length + 1);
		this.addChild( monster_ );
		enemyCharacterLayer.addChild( monster_.context );
		monster_.context.x = monster_.x = p_x;
		monster_.context.y = monster_.y = p_y;
		monster_.addComponent( new AnimationComponent( monster_, animationFilePath,  "assets/motionwelder/npc_boy") );
		monster_.setWayPoint(p_wayPoints);
		monsterList.push(monster_);
	}

	private function createMonster(p_x : Int, p_y : Int, p_wayPoints : Array<Point>, animationFilePath)
	{
		var monster_ = new Monster("monster" + monsterList.length + 1);
		this.addChild( monster_ );
		enemyCharacterLayer.addChild( monster_.context );
		monster_.context.x = monster_.x = p_x;
		monster_.context.y = monster_.y = p_y;
		monster_.addComponent( new AnimationComponent( monster_, animationFilePath, "assets/motionwelder/npc_boy") );
		monster_.setWayPoint(p_wayPoints);
		monsterList.push(monster_);
	}

	private function createVictim(p_x : Int, p_y : Int, p_wayPoints : Array<Point>, animationFilePath)
	{
		var victim_ = new Victim("victim" + monsterList.length + 1);
		this.addChild( victim_ );
		enemyCharacterLayer.addChild( victim_.context );
		victim_.context.x = victim_.x = p_x;
		victim_.context.y = victim_.y = p_y;
		victim_.addComponent( new AnimationComponent( victim_, animationFilePath, "assets/motionwelder/npc_boy" ) );
		victim_.setWayPoint(p_wayPoints);
		monsterList.push(victim_);
		Global.getInstance().victim = victim_;
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
		HeartBeat.getInstance().update( dt );
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
		boxA.dead = true;
		boxB.dead = true;

		var value : Int = Std.int( Math.random() * 4 );
		trace( value );
		var sound : Sound = null;
		if( value <= 0 || value > 4 ) {
			value = 1;
		}

		HeartBeat.getInstance().stop();
		bgChannel_.stop();

		if( !this.gameWon ) {
			sound = Assets.getSound( "assets/audio/dead" + value + ".mp3" );
		} else {
			sound = Assets.getSound( "assets/audio/girlLaugh.mp3" );
			++Global.getInstance().currentLevel;
		}
		sound.play();
	}

	override function dispose_() : Void {
		super.dispose_();

		Global.getInstance().cameraPos.x = 0;
		Global.getInstance().cameraPos.y = 0;
		HeartBeat.getInstance().frequence = 1;
	}

	function onGameOver() : Void {
		this.gameWon = false;
		CollisionManager.getInstance().reset();
		Global.getInstance().sceneGame = null;
		Kernal.getInstance().changeScene( SceneRoom.ID );
	}
}
