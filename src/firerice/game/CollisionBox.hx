package firerice.game;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.Process;
import firerice.core.InputManager;
import firerice.entities.Actor;
import firerice.entities.Player;
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
import nme.media.Sound;
import nme.geom.Rectangle;
import com.eclecticdesignstudio.motion.Actuate;

class CollisionBox {
	public var owner( default, null ) : Actor;
	public var rect( default, null ) : Rectangle;
	public var dead( default, default ) : Bool = false;

	public function new( p_owner : Actor, p_rect : Rectangle ) : Void {
		owner = p_owner;
		if( owner != null ) {
			rect = new Rectangle( p_rect.x + owner.x, p_rect.y + owner.y, p_rect.width, p_rect.height );
		} else {
			rect = new Rectangle( p_rect.x, p_rect.y, p_rect.width, p_rect.height );
		}

		// trace( "rect.x: " + rect.x + ", rect.y: " + rect.y );
	}

	public function toString() : String {
		var output : String = "";
		output += "x: " + rect.x + ", y: " + rect.y + ", width: " + rect.width + ", height: " + rect.height;
		return output;
	}
}