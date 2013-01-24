package firerice.components;
import firerice.components.Component;
import firerice.core.Entity;
import firerice.interfaces.IDisplayable;
//import firerice.events.TransformEvent;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class SpriteComponent extends Component, implements IDisplayable
{
	// xml tags
	public static var TEXTURE : String = "texture";
	public static var ID : String = "spriteComponent";
	
	public var context( default, null ) : Sprite;
	public var bitmapCollection( default, null ) : Array<Bitmap>;
	//public var bitmapDataCollection( default, null ) : BitmapData;
	//public var bitmap( default, null ) : Bitmap;
	
	//public var texturePath( default, null ) : String;
	//public var anuPath( default, null ) : String;
	public function new( p_owner : Entity, p_bitmapData : Array<BitmapData> ) 
	{
		id = SpriteComponent.ID;
		super( id, p_owner );
		
		this.context = new Sprite();
		this.bitmapCollection = new Array<Bitmap>();
		
		for ( bitmapData in p_bitmapData ) {
			var bitmap : Bitmap = new Bitmap( bitmapData );
			bitmapCollection.push( bitmap );
			this.context.addChild( bitmap );
		}
		owner.context.addChild( context );
	}
	
	//override public function resolve(component:Component):Void 
	//{
		//super.resolve(component);
		//
		//if ( Std.is( component, SpriteComponent ) ) {
			//return ;
		//}
		//
		//switch( component.id ) {
			//case TransformComponent.ID: {
				//var com : TransformComponent = cast( component, TransformComponent );
				//com.addEventListener( TransformEvent.CHANGE, transformEventHandler );
				//trace( "event listener added" );
				//
				//if ( bitmap != null ) {
					//bitmap.x = com.x;
					//bitmap.y = com.y;
				//}
			//}
		//}
	//}
	
	//function transformEventHandler( event : TransformEvent ) : Void {
		//trace( "transformEventHandler" );
	//}s
}