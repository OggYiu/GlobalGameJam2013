package firerice.components;
import firerice.core.Entity;
import nme.events.KeyboardEvent;
import nme.Lib;

/**
 * ...
 * @author oggyiu
 */

class CommandComponent extends Component
{
	public static var ID : String = "commandComponent.ID";
	public function new( p_owner : Entity, filePath : String ) 
	{
		super( CommandComponent.ID, p_owner );
		
		Lib.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		Lib.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
	}
	
	function onKeyDown( e : KeyboardEvent ) : Void {
		trace( "onKeyDown: " + e.keyCode );
	}
	
	function onKeyUp( e : KeyboardEvent ) : Void {
		trace( "onKeyUp: " + e.keyCode );
		
	}
}