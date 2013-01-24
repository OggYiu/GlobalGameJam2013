package firerice.core;
import nme.events.EventDispatcher;
import nme.events.IEventDispatcher;

/**
 * ...
 * @author oggyiu
 */

class Process
{
	var disposed_ : Bool = false;
	
	public var id( default, null ) : String = "";
	
	//public var args( default, null ) : Dynamic;
	
	public function new( p_id : String ) {
		id = p_id;
	}
	
	public function update( dt : Float ) : Void {
		update_( dt );
	}
	
	// please override this function
	private function update_( dt : Float ) : Void {
	}
	
	public function dispose() : Void {
		if ( !disposed_ ) {
			dispose_();
			disposed_ = true;
		}
	}
	private function dispose_() : Void {
	}
}