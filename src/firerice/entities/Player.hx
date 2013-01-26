package firerice.entities;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.InputManager;
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
	public var currentFrame( default, null ) : MFrame = null;

	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( currentFrame != animComponent.animator.currentFrame ) {
			currentFrame = animComponent.animator.currentFrame;
			CollisionManager.getInstance().removeCollisionBox( this );

			if( animComponent.animator.currentFrame.colliders.length > 0 ) {
				// trace( "animComponent.animator.currentFrame.colliders.length > 0!" );
				for( box in animComponent.animator.currentFrame.colliders ) {
					CollisionManager.getInstance().addCollisionBox( new CollisionBox( this, box ) );
				}
			} else {
			}
		}
	}
}