package firerice.core;

import firerice.common.Helper;
import firerice.components.Component;
import firerice.components.SpriteComponent;
import firerice.core.Process;
import firerice.interfaces.IComponentContainer;
import firerice.interfaces.IDisplayable;
import firerice.interfaces.IEntityCollection;
import firerice.types.EEntityType;
import haxe.xml.Fast;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.IEventDispatcher;

/**
 * ...
 * @author oggyiu
 */

class Entity extends Process, implements IEntityCollection, implements IComponentContainer, implements IDisplayable, implements IEventDispatcher
{
	public var context( default, null ) : Sprite = null;
	public var entities( default, null ) : Hash<Entity> = null;
	public var components( default, null ) : Hash<Component> = null;
	public var type( default, null ) : EEntityType;
	public var parent( default, null ) : Dynamic = null;
	public var x( default, setX ) : Float;
	public var y( default, setY ) : Float;
	public var z( default, setZ ) : Float;
	
	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id );
		
		//type = EntityType.unknown;
		parent = p_parent;
		
		if ( context == null ) {
			context = new Sprite();
		}
		
		if ( parent != null ) {
			if ( Std.is( parent, IEntityCollection ) ) {
				parent.addChild( this );
			}
			if ( Std.is( parent, IDisplayable ) ) {
				parent.context.addChild( context );
			}
		}
		
		//this.context.addEventListener( Event.RENDER, onRender );
		//CEntityCollection.setAddChild( this );
		
		entities = new Hash<Entity>();
		components = new Hash<Component>();
	}
	
	// establish the relationship between component
	//function resolved() : Void {
		//for ( component1 in components ) {
			//for ( component2 in components ) {
				//if ( component1 == component2 ) {
					//continue;
				//}
				//
				//component1.resolve( component2 );
			//}
		//}
	//}
	
	override private function update_( dt : Float ) : Void {
		for( component in components ) {
			component.update( dt );
		}
		
		for ( entity in entities ) {
			entity.update( dt );
		}
	}
	
	public function addComponent( component : Component ) : Void {
		#if debug
		if ( components.get( component.id ) != null ) {
			Helper.assert( false, "<Entity::addComponent>, component: " + component.id + " already existed!" );
			return ;
		}
		#end
		
		components.set( component.id, component );
	}
	
	public function hasComponent( componentId : String ) : Bool {
		return components.exists( componentId );
	}
	
	public function getComponent( componentId : String ) : Component {
		return components.get( componentId );
	}
	
	public function addChild( entity : Entity ) : Void {
		#if debug
		Helper.assert( !entities.exists( entity.id ), "entity already existed: " + entity.id );
		#end
		
		entities.set( entity.id, entity );
	}
	
	//public static function strToEntityType( str : String ) : EEntityType {
		//switch( str ) {
			//case TransformComponent.name: return EntityType.transform;
		//}
		//
		//#if debug
		//Helper.assert( false, "<Entity::strToEntityType>, no entity type is found for string : " + str );
		//#end
		//
		//return EntityType.unknown;
	//}
	
	public function addEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void {
	// public function addEventListener(type : String, listener : Dynamic->Void, ?useCapture : Bool = false, ?priority : Int = 0, ?useWeakReference : Bool = false) : Void {
		this.context.addEventListener( type , listener , useCapture , priority , useWeakReference );
	}
	
	public function dispatchEvent(event : Event) : Bool {
		return this.context.dispatchEvent( event );
	}
	
	public function hasEventListener(type : String) : Bool {
		return this.context.hasEventListener( type );
	}

	public function removeEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false) : Void {
	// public function removeEventListener(type : String, listener : Dynamic->Void, ?useCapture : Bool = false) : Void {
		this.context.removeEventListener( type , listener , useCapture );
	}
	
	public function willTrigger(type : String) : Bool {
		return this.context.willTrigger( type );
	}

	function setX( value : Float ) : Float {
		x = value;
		// this.context.x = x;
		return x;
	}
	
	function setY( value : Float ) : Float {
		y = value;
		// this.context.y = y;
		return y;
	}
	
	function setZ( value : Float ) : Float {
		z = value;
		// this.context.z = z;
		return z;
	}
}