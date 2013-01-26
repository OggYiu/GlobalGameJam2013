package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
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

/**
 * ...
 * @author oggyiu
 */

class SceneYiuTest extends Scene
{
	public static var ID : String = "sceneYiuTest";

	var monster_ : Monster = null;

	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );

		monster_ = new Monster( "monster1", this );
		monster_.addComponent( new TransformComponent( monster_, 300, 300, 0 ) );
		monster_.addComponent( new AnimationComponent( monster_, "assets/motionwelder/monster1" ) );
		// var anim : AnimationComponent = cast( monster_.getComponent( AnimationComponent.ID ), AnimationComponent );
		// anim.animator.setEventReceiver(	this, animationCompleteHandler, animationEventHandler );
		// anim.animator.play( 0, EOrientation.none, WrapMode.loop, true );
	}


	// function animationCompleteHandler(	animationSet : MAnimationSet,
	// 									clipId : Int) : Void {
	// 	// trace( "<MGameEntity::AnimationCompleteHandler>" );
	// }

	// function animationEventHandler(	animationSet : MAnimationSet,
	// 								animation : MAnimation,
	// 								frame : MFrame,
	// 								unknown : Int ) : Void {
	// 	// trace( "<MGameEntity::AnimationEventHandler>" );
	// 	// trace( "monster_" + monster_ );
	// 	trace( "monster_.context: " + monster_.context );
	// 	trace( "monster_.context.getChildAt(0): " + monster_.context.getChildAt(0) );
	// 	var targetBitmap : Bitmap = cast( monster_.context.getChildAt(0), Bitmap );
	// 	targetBitmap.bitmapData = frame.frameImages[0].bitmapdata;
	// 	targetBitmap.x = frame.frameImages[0].xPos;
	// 	targetBitmap.y = frame.frameImages[0].yPos;

	// 	// trace( "<MGameEntity::AnimationEventHandler>, contextBitmap_.bitmapData: " + contextBitmap_.bitmapData );
	// }

}