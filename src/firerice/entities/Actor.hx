package firerice.entities;
import firerice.common.Global;
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

enum ActorAnimType {
	idleRight;
	idleLeft;
	walkRight;
	walkLeft;
	transform;
	runRight;
	runLeft;
}

class Actor extends Entity {
	public var animComponent( default, null ) : AnimationComponent = null;
	public var currAnimType( default, null ) : ActorAnimType;
	public var currentFrame( default, null ) : MFrame = null;


	var firstUpdate_ : Bool = true;

	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );
	}

	public function playAnim( type : ActorAnimType, ?wrapmode : WrapMode ) : Void {
		if( wrapmode == null ) {
			wrapmode = WrapMode.loop;
		}
		switch( type ) {
			case ActorAnimType.idleRight:
				this.animComponent.animator.play(0, EOrientation.none, wrapmode, false );
			case ActorAnimType.idleLeft:
				this.animComponent.animator.play(1, EOrientation.none, wrapmode, false );
			case ActorAnimType.walkRight:
				this.animComponent.animator.play(2, EOrientation.none, wrapmode, false );
			case ActorAnimType.walkLeft:
				this.animComponent.animator.play(3, EOrientation.none, wrapmode, false );
			case ActorAnimType.transform:
				this.animComponent.animator.play(4, EOrientation.none, wrapmode, false );
			case ActorAnimType.runRight:
				this.animComponent.animator.play(5, EOrientation.none, wrapmode, false );
			case ActorAnimType.runLeft:
				this.animComponent.animator.play(6, EOrientation.none, wrapmode, false );
		}

		currAnimType = type;
	}

	override function update_( dt : Float ) : Void {
		if( firstUpdate_ ) {
			this.animComponent = cast( this.getComponent( AnimationComponent.ID ), AnimationComponent );
			playAnim( ActorAnimType.idleRight );
			firstUpdate_ = false;
		}

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

		this.context.x = this.x - Global.getInstance().cameraPos.x;
		this.context.y = this.y - Global.getInstance().cameraPos.y;
	}
}