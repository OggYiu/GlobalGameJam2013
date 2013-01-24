package firerice.ui;
import nme.display.Stage;
import nme.events.EventDispatcher;
import nme.events.MouseEvent;
import nme.Lib;

/**
 * ...
 * @author oggyiu
 */

class TouchCollideBox extends EventDispatcher
{
	public var x( default, default ) : Float;
	public var y( default, default ) : Float;
	public var width( default, default ) : Int;
	public var height( default, default ) : Int;
	
	public function new( p_x : Float, p_y : Float, p_width : Int, p_height : Int, target : Dynamic, handler : String ) 
	{
		super();
		
		x = p_x;
		y = p_y;
		width = p_width;
		height = p_height;
		
		var handlerFunc : Dynamic = Reflect.field( target, handler );
		//trace( "touch collide box created, target: " + target + ", handler: " + handler + ", handlerFunc: " + handlerFunc );
		if(handlerFunc != null)
			Lib.stage.addEventListener(MouseEvent.CLICK, handlerFunc);
	}
	
}