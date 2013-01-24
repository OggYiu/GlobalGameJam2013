package firerice.components;

import firerice.core.Entity;
/**
 * ...
 * @author oggyiu
 */

class CommandComponent extends Component
{
	public static var ID : String = "commandComponent.ID";
	public function new( p_owner : Entity, filePath : String )
	{
		super( CommandComponent.ID );
	}
	
}