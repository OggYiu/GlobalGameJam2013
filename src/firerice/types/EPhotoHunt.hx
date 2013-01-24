package firerice.types;

/**
 * ...
 * @author oggyiu
 */

import firerice.core.Scene;
import firerice.common.Helper;
import firerice.scenes.SceneGame;
import firerice.ui.TouchCollideBox;
import minimalcomps.CheckBox;
import minimalcomps.Component;
import minimalcomps.HBox;
import minimalcomps.HSlider;
import minimalcomps.HUISlider;
import minimalcomps.IndicatorLight;
import minimalcomps.Label;
import minimalcomps.ProgressBar;
import minimalcomps.PushButton;
import minimalcomps.Panel;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class EPhotoHunt
{
	static var SPRITE : String = "sprite";
	
	public function new() 
	{
	}
	
	public static function load( target : SceneGame, xmlPath : String ) : Void {
		var spriteCreated : Hash<Sprite> = new Hash<Sprite>();
		var componentsCreated : Hash<Component> = new Hash<Component>();
		var xml : Xml = Xml.parse( Assets.getText( xmlPath ) );
		var elements = xml.elements().next().elements();
		while ( elements.hasNext() ) {
			var componentCreated : Component = null;
			var elem = elements.next();
			var id : String = elem.get( "id" );
			var x : Int = Std.parseInt( elem.get( "x" ) );
			var y : Int = Std.parseInt( elem.get( "y" ) );
			var canvasId : String = elem.get( "canvasId" );
			var parentComponentId : String = elem.get( "parentComponentId" );
			var parentCanvas : Sprite = canvasId != null? spriteCreated.get( canvasId ) : target.context; 
			var parentComponent : Component = componentsCreated.get( parentComponentId ); 
			
			//trace( "creating " + elem.nodeName );
			switch( elem.nodeName ) {
				case EPhotoHunt.SPRITE: {
					// format : <sprite	id="background"
					//					x="50" y="100"
					//					img="assets/img/background.png"></sprite>
					var bitmapData : BitmapData = Assets.getBitmapData( elem.get( "img" ) );
					var bitmap : Bitmap = new Bitmap( bitmapData );
					bitmap.x = x;
					bitmap.y = y;
					var sprite = new Sprite();
					sprite.addChild( bitmap );
					parentCanvas.addChild( sprite );
					spriteCreated.set( id, sprite );
				}
				case "touchCollideBox": {
					//<touchCollideBox x="0" y="577" width="52" height="33" handler="onCollideRectClicked"></touchCollideBox>
					var targetId : String = elem.get( "targetId" );
					var handler : String = elem.get( "handler" );
					var width : Int = Std.parseInt( elem.get( "width" ) );
					var height : Int = Std.parseInt( elem.get( "height" ) );
					
					target.touchCollideBoxes.push( new TouchCollideBox( x, y, width, height, target, handler ) );
				}
				default: Helper.assert( false, "invalid type found: " + elem.nodeName );
			}
			
			if ( componentCreated != null ) {
				//trace( "id: " + id );
				//trace( "parentComponent: " + parentComponent );
				//trace( "parentComponentId: " + parentComponentId );
				if ( parentComponent != null ) {
					trace( "componentCreated: " + componentCreated + ", added to parentComponent" ); 
					parentComponent.addChild( componentCreated );
				}
				componentCreated.id = id;
				
				componentsCreated.set( id, componentCreated );
			}
		}
	}
}