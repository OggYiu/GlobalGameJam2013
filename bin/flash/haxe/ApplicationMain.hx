import Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new NMEPreloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		
		haxe.Log.trace = flashTrace; // null
		

		if (call_real)
			begin ();
	}

	
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;

        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
		}
		else
		{
			nme.Lib.current.addChild(cast (Type.createInstance(Main, []), nme.display.DisplayObject));	
		}
		
	}

	static function onEnter (_) {
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="assets/img/bgTile2.png")
			 
            return Assets.getBitmapData ("assets/img/bgTile2.png");
         
		
		if (inName=="assets/img/MAP_001.png")
			 
            return Assets.getBitmapData ("assets/img/MAP_001.png");
         
		
		if (inName=="assets/fonts/kanji.fnt")
			 
            return Assets.getBytes ("assets/fonts/kanji.fnt");
         
		
		if (inName=="assets/fonts/kanji.png")
			 
            return Assets.getBitmapData ("assets/fonts/kanji.png");
         
		
		if (inName=="assets/fonts/pf_ronda_seven.ttf")
			 
			 return Assets.getFont ("assets/fonts/pf_ronda_seven.ttf");
		 
		
		if (inName=="assets/interfaces/game.xml")
			 
			 return Assets.getText ("assets/interfaces/game.xml");
         
		
		if (inName=="assets/interfaces/stage1.xml")
			 
			 return Assets.getText ("assets/interfaces/stage1.xml");
         
		
		if (inName=="assets/interfaces/test.xml")
			 
			 return Assets.getText ("assets/interfaces/test.xml");
         
		
		if (inName=="assets/motionwelder/monster1.anu")
			 
            return Assets.getBytes ("assets/motionwelder/monster1.anu");
         
		
		if (inName=="assets/motionwelder/monster1.png")
			 
            return Assets.getBitmapData ("assets/motionwelder/monster1.png");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}


class NME_assets_img_bgtile2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_img_map_001_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fonts_kanji_fnt extends nme.utils.ByteArray { }
class NME_assets_fonts_kanji_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fonts_pf_ronda_seven_ttf extends nme.text.Font { }
class NME_assets_interfaces_game_xml extends nme.utils.ByteArray { }
class NME_assets_interfaces_stage1_xml extends nme.utils.ByteArray { }
class NME_assets_interfaces_test_xml extends nme.utils.ByteArray { }
class NME_assets_motionwelder_monster1_anu extends nme.utils.ByteArray { }
class NME_assets_motionwelder_monster1_png extends nme.display.BitmapData { public function new () { super (0, 0); } }

