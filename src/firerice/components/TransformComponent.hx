package firerice.components;
import firerice.core.Entity;
//import firerice.events.TransformEvent;
import nme.events.Event;

/**
 * ...
 * @author oggyiu
 */

class TransformComponent extends Component
{
	public static var ID : String = "transformComponent";
	public var x( default, setX ) : Float;
	public var y( default, setY ) : Float;
	public var z( default, setZ ) : Float;

	//var invalidate_ : Bool = false;
	
	public function new( p_owner : Entity, p_x :Float, p_y :Float, p_z :Float ) 
	{
		//trace( "in new" );
		id = p_owner.id + ":component:" + TransformComponent.ID;
		
		super( id, p_owner );
		
		x = p_x;
		y = p_y;
		z = p_z;
	}
	
	function setX( value : Float ) : Float {
		x = value;
		this.owner.context.x = x;
		//trace( "changed: " + this.owner.context.x ); 
		//this.owner.addEventListener( Event.ENTER_FRAME, onInvalidate );
		return x;
	}
	
	function setY( value : Float ) : Float {
		y = value;
		this.owner.context.y = y;
		//this.owner.addEventListener( Event.ENTER_FRAME, onInvalidate );
		return y;
	}
	
	function setZ( value : Float ) : Float {
		z = value;
		//this.owner.addEventListener( Event.ENTER_FRAME, onInvalidate );	
		return z;
	}
	
	//function onInvalidate(event:Event) {
		//trace( "in onInvalidate" );
		//this.owner.removeEventListener(Event.ENTER_FRAME, onInvalidate);
		//this.dispatchEvent( new Event( TransformEvent.CHANGE ) );
		//trace( "x: " + x );
		//trace( "owner.context.x: " + owner.context.x );
		//owner.context.x = x;
		//owner.context.y = y;
	//}
}