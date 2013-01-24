package firerice.scenes;
import firerice.common.Helper;
import firerice.components.SpriteComponent;
import firerice.core.Entity;
import firerice.interfaces.IEntityCollection;
import firerice.ui.UIBLabel;
import firerice.ui.UIScrollBg;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;
import firerice.core.Scene;
import firerice.game.SpriteFound;
import firerice.types.EPhotoHunt;
import firerice.types.EUserInterface;
import firerice.ui.TouchCollideBox;
import firerice.ui.UIDialogBox;
import minimalcomps.Label;
import minimalcomps.ProgressBar;
import minimalcomps.PushButton;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Rectangle;
import nme.media.SoundTransform;

/**
 * ...
 * @author oggyiu
 */

class SceneGame extends Scene
{
	private static var IMAGE_MARGIN_X : Float = 31;
	private static var IMAGE_MARGIN_Y : Float = 103;
	private static var IMAGE_OFFSET_X : Float = 507;
	private static var TIME_LIMIT : Float = 10;
	private static var SCORE_GAIN : Int = 100;
	private static var SCORE_REDUCE : Int = 40;
	
	public static var ID : String = "sceneGame";
	public var touchCollideBoxes( default, null ) : Array<TouchCollideBox> = null;
	
	var spriteCrosses_ : Array<Sprite> = null;
	var labelRemainHiddenObject_ : Label = null;
	//var labelScore_ : Label = null;
	//var labelLevel_ : Label = null;
	//var progressTimeBar_ : ProgressBar = null;
	//var gameInitTimeRemain_ : Float = 0;
	//var currentGameTimeRemain_ : Float = 0;
	var objectsNeedToFind_ : Int = 0;
	var objectsFound_ : Int = 0;
	var currentLevel_ : Int = 1;
	var currentScore_ : Int = 0;
	var isGameOver_ : Bool = false;
	var isGameWon_ : Bool = false;
	var bgScroll_ : UIScrollBg = null;
	
	//@:macro public static function haha() {
		//trace( "haha" );
		//return null;
	//}
	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );
		
		touchCollideBoxes = new Array<TouchCollideBox>();
		spriteCrosses_ = new Array<Sprite>();
		
		load( currentLevel_ );
		
		var music = Assets.getSound( "assets/audio/music/shuffle_001.mp3" );
		var soundChannel = music.play( 0, 10000 );
		
		var newTransform = soundChannel.soundTransform;
		newTransform.pan = 0;
		newTransform.volume = 0.3;
 
		soundChannel.soundTransform = newTransform;
	}
	
	function reset() : Void {
		while ( this.context.numChildren != 0 ) {
			this.context.removeChildAt( 0 );
		}
		
		touchCollideBoxes.splice( 0, touchCollideBoxes.length );
		//gameInitTimeRemain_ = 0;
		//currentGameTimeRemain_ = 0;
		objectsNeedToFind_ = 0;
		objectsFound_ = 0;
		currentLevel_ = 1;
		currentScore_ = 0;
		isGameOver_  = false;
		isGameWon_ = false;
		
		for ( entity in entities ) {
			entities.remove( entity.id );
		}
	}
	
	function load( level : Int ) : Void {
		reset();
	//#if macro
	//trace( "macro!!!" );
		//SceneGame.haha();
		//#end
		//Helper.assert( false, "fucking hell!" );
		Actuate.tween( this.context, 1, { alpha : 1 } );
		
		bgScroll_ = new UIScrollBg(	"scrollbg",
									this,
									Assets.getBitmapData( "assets/img/bgTile.png" ),
									0,
									0,
									1024,
									768,
									50,
									50 ); 
		//this.context.addChild( bgScroll_.context );
		
		EUserInterface.load( this, "assets/interfaces/game.xml" );
		EPhotoHunt.load( this, "assets/interfaces/stage" + level + ".xml" );
	
		labelRemainHiddenObject_ = new Label( this.context, 48, 24, "", 26 );
		labelRemainHiddenObject_.text = "Object(s) Found : 0 / " + touchCollideBoxes.length;
		
		//labelLevel_ = new Label( this.context, 138, 8, currentLevel_ + "", 26 );
		//labelScore_ = new Label( this.context, 346, 8, "0", 26 );
	
		//progressTimeBar_ = new ProgressBar( this.context, 118, 60 );
		//progressTimeBar_.width = 348;
		//progressTimeBar_.height = 26;
		//progressTimeBar_.value = progressTimeBar_.maximum = 100;
		//progressTimeBar_.backgroundColor = 0xFF0000;
		//progressTimeBar_.barColor = 0x00FF00;
		
		//currentGameTimeRemain_ = gameInitTimeRemain_ = TIME_LIMIT;
		
		objectsNeedToFind_ = touchCollideBoxes.length;
		objectsFound_ = 0;
		
		//new UIDialogBox( this.context, "assets/fonts/kanji.fnt", "assets/fonts/kanji.png" );
		//new UIBLabel( this.context, 0, 0, "wtf!" );
	}
	
	function onCollideRectClicked( e : MouseEvent ) : Void {
		//trace( "onCollideRectClicked" );
		if ( isGameWon_ ) {
			return ;
		}
		
		if ( isGameOver_ ) {
			reset();
			return ;
		}
		
		if ( touchCollideBoxes.length <= 0 ) {
			return ;
		}
		
		var mouseX : Float = e.stageX;
		var mouseY : Float = e.stageY;
		var nothingClicked : Bool = true;
		
		var box : TouchCollideBox = touchCollideBoxes[0];
		var currentIndex : Int = 0;
		while ( box != null ) {
			if ( currentIndex >= touchCollideBoxes.length ) {
				break;
			}
			
			if ( 	hitTest( 	new Rectangle( box.x + IMAGE_MARGIN_X, box.y + IMAGE_MARGIN_Y, box.width, box.height ), new Rectangle( mouseX, mouseY, 1, 1 ) ) ||
					hitTest( 	new Rectangle( box.x + IMAGE_OFFSET_X + IMAGE_MARGIN_X, box.y + IMAGE_MARGIN_Y, box.width, box.height ), new Rectangle( mouseX, mouseY, 1, 1 ) ) ) {
				//var button : PushButton = new PushButton( this.context, box.x + IMAGE_MARGIN_X, box.y + IMAGE_MARGIN_Y, "found" );
				//button.width = box.width;
				//button.height = box.height;
				
				{
					// left sprite found
					var spriteFound : SpriteFound = new SpriteFound(  box.x + IMAGE_MARGIN_X, box.y + IMAGE_MARGIN_Y, box.width, box.height, true );
					this.context.addChild( spriteFound );
				}
				
				{
					// right sprite found
					var spriteFound : SpriteFound = new SpriteFound(  box.x + IMAGE_OFFSET_X + IMAGE_MARGIN_X, box.y + IMAGE_MARGIN_Y, box.width, box.height, true );
					this.context.addChild( spriteFound );
				}
				
				currentScore_ += SCORE_GAIN;
				nothingClicked = false;
				labelRemainHiddenObject_.text = "Object(s) Found : " + (++objectsFound_) + " / " + objectsNeedToFind_;
				touchCollideBoxes.remove( box );
				--currentIndex;
			}
			
			++currentIndex;
			box = touchCollideBoxes[currentIndex];
		}
		
		if ( nothingClicked ) {
			currentScore_ -= SCORE_REDUCE;
			var spriteFound : SpriteFound = new SpriteFound(  mouseX - 32, mouseY - 32, 64, 64, false );
			this.context.addChild( spriteFound );
			spriteCrosses_.push( spriteFound );
			Actuate.tween( spriteFound, 1, { alpha : 0 } ).onComplete( spriteCrossTimeoutHandler, [spriteFound] ).delay(0.5);
			var sound = Assets.getSound ("assets/audio/sound/wrong.mp3");
			sound.play ();
		} else {
			var sound = Assets.getSound ("assets/audio/sound/correct.mp3");
			sound.play ();
		}
		
		if ( touchCollideBoxes.length <= 0 ) {
			isGameWon_ = true;
			handleGameWon();
		}
		
		//labelScore_.text = currentScore_ + "";		
	}
	
	function hitTest( rect1 : Rectangle, rect2 : Rectangle ) {
		if (rect1.x+rect1.width < rect2.x) { return false; }
		if (rect1.x > rect2.x+rect2.width) { return false; }
		if (rect1.y+rect1.height < rect2.y) { return false; }
		if (rect1.y > rect2.y + rect2.height) { return false; }
		
		return true;  
	}
	
	function spriteCrossTimeoutHandler( spriteCross : Sprite ) : Void {
		spriteCrosses_.remove( spriteCross );
		this.context.removeChild( spriteCross );
	}
	
	override private function update_(dt:Float):Void 
	{
		super.update_(dt);
		
		if ( isGameOver_ || isGameWon_ ) {
			return ;
		}
		
		//currentGameTimeRemain_ -= dt;
		
		//if ( currentGameTimeRemain_ < 0 ) {
			//currentGameTimeRemain_ = 0;
			//isGameOver_ = true;
			//handleGameOver();
		//}
		//progressTimeBar_.value = ( currentGameTimeRemain_ / gameInitTimeRemain_ ) * 100;
	}
	
	function handleGameOver() : Void {
		Actuate.tween( this.context, 1, { alpha : 0 } ).onComplete( load, [currentLevel_] ).delay(1);
	}
	
	function handleGameWon() : Void {
		//Actuate.tween( this.context, 1, { alpha : 0 } ).onComplete( load, [++currentLevel_] ).delay(1);
		var entity : Entity = new Entity( "entityYouWon", this );
		entity.addComponent( new SpriteComponent( entity, [ Assets.getBitmapData( "assets/game/youwin.png" ) ] ) );
		entity.context.scaleX = 0;
		entity.context.scaleY = 0;
		Actuate.tween( entity.context, 1, { scaleX : 1, scaleY : 1 } ).onUpdate( onYouWonContextScaleUpdate, [ entity.context ] );
		var sound = Assets.getSound ("assets/audio/sound/youwin.mp3");
		sound.play ();
	}
	
	function onYouWonContextScaleUpdate( context : Sprite ) : Void {
		context.x = ( 1024 - context.width ) / 2;
		context.y = ( 1024 - context.height ) / 2;
	}
}