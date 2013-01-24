package firerice.interfaces;

import firerice.core.Entity;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

interface IEntityCollection
{
	public var entities( default, null ) : Hash<Entity>;
	
	public function addChild( entity : Entity ) : Void;
//}
//
//class CEntityCollection {
	//public static function setAddChild( entityCollection : IEntityCollection ) : Void {
		//var addChildFunc : Entity -> Void;
		//function f( entity : Entity ) : Void { trace( "CEntityCollection addChild" ); }
		//addChildFunc = f;
		//Reflect.setProperty( entityCollection, "addChild", addChildFunc );
	//}
	//function f( entity : Entity ) : Void { }
}