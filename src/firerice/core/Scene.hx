package firerice.core;

import firerice.common.Helper;
import firerice.core.Entity;
//import firerice.events.TransformEvent;
import firerice.interfaces.IDisplayable;
import firerice.interfaces.IEntityCollection;
import minimalcomps.Label;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;

/**
 * ...
 * @author oggyiu
 */

class Scene extends Process, implements IEntityCollection, implements IDisplayable
{
	public var entities( default, null ) : Hash<Entity> = null;
	public var context( default, null ) : Sprite = null;
	var parentContext_ : Sprite = null;
	
	public function new( p_id : String, p_parentContext : Sprite ) {
		super( p_id );
		
		// init
		entities = new Hash<Entity>();
		context = new Sprite();
		parentContext_ = p_parentContext;
		parentContext_.addChild( context );
		new Label( context, 0, 0, p_id );
		
		//var entity : Entity = new Entity( "testEntity", this );
	}
	
	public function addChild( entity : Entity ) : Void {
		#if debug
		Helper.assert( !entities.exists( entity.id ), "entity already existed: " + entity.id );
		#end
		
		entities.set( entity.id, entity );
	}
	
	override private function update_( dt : Float ) : Void {
		for ( entity in entities ) {
			entity.update( dt );
		}
	}
	
	override private function dispose_():Void 
	{
		super.dispose_();
		
		parentContext_.removeChild( context );
	}

	public function onKeyDown(event:KeyboardEvent) : Void {
	} 

	public function onKeyUp(event:KeyboardEvent) : Void {
	} 

	public function onMouseMove(event:MouseEvent) : Void {
	} 

	public function onMouseUp(event:MouseEvent) : Void {
	} 

	public function onMouseDown(event:MouseEvent) : Void {
	} 
}