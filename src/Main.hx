package ;

import firerice.core.Kernal;
import firerice.log.ConsoleSender;
import firerice.log.RayTrace;
import haxe.Timer;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.display.StageDisplayState;

/**
 * ...
 * @author oggyiu
 */

class Main extends Sprite 
{
	var lastUpdateTime_ : Float = 0;
	var updated_ : Bool = false;
	var kernal_ : Kernal = null;
	
	public function new() 
	{
		super();

		// #if flash
		// var console_sender_ : ConsoleSender;
  //   	console_sender_ = new ConsoleSender();
	 //    trace ( RayTrace.COMMAND_CLEAR );
	 //    #end

		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		#end
		
		addEventListener( Event.ENTER_FRAME, update );
		Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_BORDER;
		Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		// Lib.current.stage.width = 1024;
		// Lib.current.stage.height = 768;
		
		kernal_ = new Kernal( this );
	}

	private function onAddedToStage(e)
	{
	}
	
	private function update( event : Event ) : Void {
		var dt : Float = 0;
		if ( !updated_ ) {
			updated_ = true;
		} else {
			dt = Timer.stamp() - lastUpdateTime_;
		}
		lastUpdateTime_ = Timer.stamp();

		kernal_.update( dt );
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
