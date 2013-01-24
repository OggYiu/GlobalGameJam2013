package firerice.ui;
import firerice.interfaces.IDisplayable;
import minimalcomps.Window;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class UIInfoPanel 
{
	var owner_ : IDisplayable = null;
	
	public function new( owner : IDisplayable ) {
		//var window : Window = new Window( owner.context, owner.context.x, owner.context.y, "owner" ); 
		var window : Window = new Window( owner.context, Std.int( owner.context.x ), Std.int( owner.context.y ) );
		var fields : Array<String> = Type.getInstanceFields( Type.getClass( owner ) );
		for ( field in fields ) {
			//trace( "field: " + field );
			//var reflectField : Dynamic = Reflect.field( owner, field );
			//trace( "reflect.field: " + reflectField );
			//trace( "" );
		}
	}
	
}