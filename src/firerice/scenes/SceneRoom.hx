package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.types.EUserInterface;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;

/**
 * ...
 * @author oggyiu
 */

class SceneRoom extends Scene
{
	public static var ID : String = "sceneRoom";
	
	public function new( p_parentContext : Sprite ) {
		super( SceneRoom.ID, p_parentContext );
	}
}