package firerice.core;

import haxe.macro.Context;
import haxe.macro.Expr;
import firerice.common.Helper;
import firerice.core.InputManager;
import firerice.scenes.SceneTest;
import firerice.scenes.SceneGame;
import firerice.scenes.SceneYiuTest;
import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.Lib;

class Kernal extends Process {
	public var currentScene( default, null ) : Scene = null;

	var sceneRegistry_ : Hash<Class<Scene>> = null;
	var canvas_ : Sprite = null;
	public var screenWidth( default, default ) : Float;
	public var screenHeight( default, default ) : Float;
	
	public function new( canvas : Sprite ) {
		//Helper.assert( s_canInit_, "you cannot init the class in this way!" );
		Helper.assert( s_instance_ == null, "there is only one kernal!" );
		
		s_instance_ = this;
		super( null );
		
		screenWidth = Lib.stage.width;
		screenHeight = Lib.stage.height;

		canvas_ = canvas;
		sceneRegistry_ = new Hash<Class<Scene>>();
		registerScene( SceneTest.ID, SceneTest );
		registerScene( SceneGame.ID, SceneGame );
		registerScene( SceneYiuTest.ID, SceneYiuTest );

		InputManager.getInstance();
		
		Lib.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		Lib.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		// var startSceneId : String = SceneTest.ID;
		// var startSceneId : String = SceneYiuTest.ID;
		var startSceneId : String = SceneGame.ID;
		changeScene( startSceneId );
	}

	public function changeScene( sceneId : String ) : Void {
		var targetClassType : Class<Scene> = sceneRegistry_.get( sceneId );
		Helper.assert( targetClassType != null, "class not found, sceneId: " + sceneId );
		
		//trace( "creating scene: " + sceneId );
		var scene : Scene = Type.createInstance( targetClassType, [ canvas_ ] );
		trace( "scene created: " + scene );
		
		if ( currentScene != null ) {
			currentScene.dispose();
		}
		currentScene = scene;
	}
	
	function refreshCurrentScene() : Void {
		Helper.assert( currentScene != null, "current scene is null" );
		changeScene( currentScene.id );
	}
	
	override private function update_(dt:Float):Void 
	{
		super.update_(dt);
		if ( currentScene != null ) {
			currentScene.update( dt );
		}
	}
	
	public function registerScene( id : String, classType : Class<Scene> ) : Void {
		Helper.assert( sceneRegistry_.get( id ) == null, "class already existed, id: " + id + ", classType: " + classType );
		sceneRegistry_.set( id, classType );
	}
	
	//static var s_canInit_ : Bool = false;
	static var s_instance_ : Kernal = null;
	public static function getInstance() : Kernal {
		//if ( s_instance_ == null ) {
			//s_canInit_ = true;
			//s_instance_ = new Kernal();
			//s_canInit_ = false;
		//}
		
		return s_instance_;
	}

	function onMouseMove(event:MouseEvent) : Void {
		if ( currentScene != null ) {
			currentScene.onMouseMove( event );
		}
	} 

	function onMouseUp(event:MouseEvent) : Void {
		if ( currentScene != null ) {
			currentScene.onMouseUp( event );
		}
	} 

	function onMouseDown(event:MouseEvent) : Void {
		if ( currentScene != null ) {
			currentScene.onMouseDown( event );
		}
	} 
}