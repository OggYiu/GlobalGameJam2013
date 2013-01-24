package firerice.scenes;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
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
		
		{
			//var entity : Entity = new Entity( {	id : "first_entity",
												//canvas : canvas,
												//xml : Xml.parse(	"<actor type=\"\">" + 
																		//"<transformComponent>" +
																			//"<position x=\"100\" y=\"0\" z=\"0\"/>" +
																		//"</transformComponent>" +
																		//"<renderComponent>" +
																			//"<texture>assets/img/issac.png</texture>" +			// you can put texture or
																		//"</renderComponent>" +
																	//"</actor>" )} );
			//addChild( entity );
			
			//EUserInterface.load( this, "assets/interfaces/test.xml" );
		}
		
		drone_ = new Entity( "drone", this );
		//var l_context : Sprite = new Sprite();
		//l_context.addChild( new Bitmap( Assets.getBitmapData( "assets/game/monk.png" ) ) );
		//drone_.addComponent( new SpriteComponent( drone_, [ Assets.getBitmapData( "assets/game/monk.png" ) ] ) );
		drone_.addComponent( new TransformComponent ( drone_, 100, 100, 0 ) );
		drone_.addComponent( new AnimationComponent( drone_, "assets/motionwelder/characters" ) );
		//trace( "result : " + drone_.context.x );
	}
	
	private function startBtnHandler( e : Event ) : Void {
	}
}