package firerice.types;
import firerice.core.Scene;
import firerice.common.Helper;
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

class EUserInterface
{
	static var SPRITE : String = "sprite";
	static var BUTTON : String = "button";
	static var CHECKBOX : String = "checkBox";
	static var LABEL : String = "label";
	static var PANEL : String = "panel";
	static var PROGRESSBAR : String = "progressBar";
	static var HBOX : String = "hbox";
	static var HSLIDER : String = "hslider";
	static var HUISLIDER : String = "huislider";
	static var INDICATORLIGHT : String = "indicatorLight";
	
	public function new() 
	{
	}
	
	public static function load( target : Scene, xmlPath : String ) : Void {
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
			/*
			<scene id="sceneLogo">
				<sprite id="background" x="50" y="100" img="assets/img/background.png"></sprite>
				<button id="startGameBtn" x="0" y="20" text="hello world!" targetId="sceneLogo" handler="startBtnClicked"></button>
				<panel id="mainPanel" x="50" y="50"></panel>
				<label id="label" canvasId="spriteLogo" x="20" y="20" text="label text" size="8", colo="0x000000" parent="mainPanel"></label>	
				<checkBox id="checkBox1" x="0" y="0" text="checkBox1!!!" targetId="sceneLogo" handler="checkBoxClickedHandler"></checkBox>
			</scene>
			*/
			//trace( "creating " + elem.nodeName );
			switch( elem.nodeName ) {
				case EUserInterface.SPRITE: {
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
				case EUserInterface.BUTTON: {
					// format : <button	id="startBtn"
					//					x="20" y="20"
					//					text=""
					//					targetId="parent"
					//					handler="startBtnHandler"></button>
					var text : String = elem.get( "text" );
					var targetId : String = elem.get( "targetId" );
					var handler : String = elem.get( "handler" );
					
					componentCreated = new PushButton( parentCanvas, x, y, text, Reflect.field( target, handler ) );
				}
				case EUserInterface.CHECKBOX: {
					var text : String = elem.get( "text" );
					var targetId : String = elem.get( "targetId" );
					var handler : String = elem.get( "handler" );
					
					componentCreated = new CheckBox( parentCanvas, x, y, text, Reflect.field( target, handler ) );
				}
				case EUserInterface.LABEL: {
					//< label	id = "label"
							//canvasId = "spriteLogo"
							//x = "20" y = "20"
							//text = "label text"
							//size = "8",
							//color = "0x000000"
							//parent = "mainPanel" >
					//</label>	
					var text : String = elem.get( "text" );
					var size : Int = Std.parseInt( elem.get( "size" ) );
					var color : Int = Std.parseInt( elem.get( "color" ) );
					
					//trace( "parentCanvas: " + parentCanvas );
					//trace( "creating label : " + text + ", x: " + x + ", y: " + y + ", size: " + size + ", color: " + color );
					componentCreated = new Label( parentCanvas, x, y, text, size, color );
					//new Label( parentCanvas, 200, 0, "yoyoyo", 8, 0xFF0000 );
				}
				case EUserInterface.PANEL: {
					//<panel id="mainPanel" x="50" y="50"></panel>
					componentCreated = new Panel( parentCanvas, x, y );
				}
				case EUserInterface.PROGRESSBAR: {
					var width : Int = Std.parseInt( elem.get( "width" ) );
					var height : Int = Std.parseInt( elem.get( "height" ) );
					
					componentCreated = new ProgressBar( parentCanvas, x, y );
					componentCreated.width = width;
					componentCreated.height = height;
				}
				case EUserInterface.HBOX: {
					componentCreated = new HBox( parentCanvas, x, y );
				}
				case EUserInterface.HSLIDER: {
					var targetId : String = elem.get( "targetId" );
					var handler : String = elem.get( "handler" );
					
					componentCreated = new HSlider( parentCanvas, x, y, Reflect.field( target, handler ) );
					//public function new(?parent:Dynamic=null, ?xpos:Int=0, ?ypos:Int=0, ?defaultHandler:Dynamic = null) {
				}
				case EUserInterface.HUISLIDER: {
					var text : String = elem.get( "text" );
					var targetId : String = elem.get( "targetId" );
					var handler : String = elem.get( "handler" );
					
					componentCreated = new HUISlider( parentCanvas, x, y, text, Reflect.field( target, handler ) );
				}
				case EUserInterface.INDICATORLIGHT: {
					var text : String = elem.get( "text" );
					var color : Int = Std.parseInt( elem.get( "color" ) );
					
					componentCreated = new IndicatorLight( parentCanvas, x, y, color, text );
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