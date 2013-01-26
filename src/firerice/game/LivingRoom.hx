package firerice.game;
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

class LivingRoom extends Entity
{
	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );

		this.context.addChild( new Bitmap( Assets.getBitmapData( "assets/img/MAP_001.png" ) ) );
		this.context.addChild( new Bitmap( Assets.getBitmapData( "assets/img/MAP_002.png" ) ) );
	}
}