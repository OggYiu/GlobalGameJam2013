package firerice.core;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.common.Helper;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.entities.Monster;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import nme.Assets;
import nme.Lib;
import nme.geom.Point;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;

class InputManager {
	public var keymap( default, null ) : Hash<Bool> = null;
	public var mousePos( default, null ) : Point = null;
	public var mouseDown( default, null ) : Bool = false;

	public function new() {
		keymap = new Hash<Bool>();
		
		mousePos = new Point( 0, 0 );

		Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		Lib.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
		Lib.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp );
	}

	
	function onKeyDown(event:KeyboardEvent) : Void {
		// trace( "keycode : " + event.keyCode );
		keymap.set( event.keyCode + "", true );
	} 

	function onKeyUp(event:KeyboardEvent) : Void {
		keymap.set( event.keyCode + "", false );
	}

	function onMouseMove( event : MouseEvent ) : Void {
		// mousePos = new Point( event.mousePos.x, event.mousePos.y 
		mousePos.x = event.stageX;
		mousePos.y = event.stageY;
	}

	function onMouseDown( event : MouseEvent ) : Void {
		mouseDown = true;
	}

	function onMouseUp( event : MouseEvent ) : Void {
		mouseDown = false;
	}

	public function isKeyOnPress( keycode : Int ) : Bool {
		return keymap.get( keycode + "" );
	}

	public function hasKeyPressed() : Bool {
		for( elem in keymap ) {
			// trace( "elem: " + elem );
			// if( keymap.get( key ) ) {
			// 	return true;
			// }

			if( elem ) {
				return true;
			}
		}

		return false;
	}

	static var s_canInit_ : Bool = false;
	static var s_instance_ : InputManager = null;
	public static function getInstance() : InputManager {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new InputManager();
			s_canInit_ = false;
		}

		return s_instance_;
	}

}