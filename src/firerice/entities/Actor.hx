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
}

class Actor extends Entity {
	public var animComponent( default, null ) : AnimationComponent = null;
	public var currAnimType( default, null ) : ActorAnimType;

	var firstUpdate_ : Bool = true;

	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );
	}

	public function playAnim( type : ActorAnimType ) : Void {
		switch( type ) {
			case ActorAnimType.idleRight:
				this.animComponent.animator.play(0, EOrientation.none, WrapMode.loop, false );
			case ActorAnimType.idleLeft:
				this.animComponent.animator.play(1, EOrientation.none, WrapMode.loop, false );
			case ActorAnimType.walkRight:
				this.animComponent.animator.play(2, EOrientation.none, WrapMode.loop, false );
			case ActorAnimType.walkLeft:
				this.animComponent.animator.play(3, EOrientation.none, WrapMode.loop, false );
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
	}
}