package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
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

class SceneTest extends Scene
{
	public static var ID : String = "sceneTest";
	
	var drone_ : Entity = null;
	
	public function new( p_parentContext : Sprite ) {
		super( SceneTest.ID, p_parentContext );
	}
	
	private function startBtnHandler( e : Event ) : Void {
	}
}