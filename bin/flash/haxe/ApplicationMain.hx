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
		
		
		if (inName=="assets/img/background.png")
			 
            return Assets.getBitmapData ("assets/img/background.png");
         
		
		if (inName=="assets/img/bgTile.png")
			 
            return Assets.getBitmapData ("assets/img/bgTile.png");
         
		
		if (inName=="assets/img/bgTile2.png")
			 
            return Assets.getBitmapData ("assets/img/bgTile2.png");
         
		
		if (inName=="assets/img/issac.png")
			 
            return Assets.getBitmapData ("assets/img/issac.png");
         
		
		if (inName=="assets/img/rogueTile.png")
			 
            return Assets.getBitmapData ("assets/img/rogueTile.png");
         
		
		if (inName=="assets/fonts/kanji.fnt")
			 
            return Assets.getBytes ("assets/fonts/kanji.fnt");
         
		
		if (inName=="assets/fonts/kanji.png")
			 
            return Assets.getBitmapData ("assets/fonts/kanji.png");
         
		
		if (inName=="assets/fonts/pf_ronda_seven.ttf")
			 
			 return Assets.getFont ("assets/fonts/pf_ronda_seven.ttf");
		 
		
		if (inName=="assets/game/check.png")
			 
            return Assets.getBitmapData ("assets/game/check.png");
         
		
		if (inName=="assets/game/cross.png")
			 
            return Assets.getBitmapData ("assets/game/cross.png");
         
		
		if (inName=="assets/game/layout.png")
			 
            return Assets.getBitmapData ("assets/game/layout.png");
         
		
		if (inName=="assets/game/leftPic.png")
			 
            return Assets.getBitmapData ("assets/game/leftPic.png");
         
		
		if (inName=="assets/game/monk.png")
			 
            return Assets.getBitmapData ("assets/game/monk.png");
         
		
		if (inName=="assets/game/rightPic.png")
			 
            return Assets.getBitmapData ("assets/game/rightPic.png");
         
		
		if (inName=="assets/game/youwin.png")
			 
            return Assets.getBitmapData ("assets/game/youwin.png");
         
		
		if (inName=="assets/interfaces/game.xml")
			 
			 return Assets.getText ("assets/interfaces/game.xml");
         
		
		if (inName=="assets/interfaces/stage1.xml")
			 
			 return Assets.getText ("assets/interfaces/stage1.xml");
         
		
		if (inName=="assets/interfaces/test.xml")
			 
			 return Assets.getText ("assets/interfaces/test.xml");
         
		
		if (inName=="assets/audio/music/shuffle_001.mp3")
			 
            return Assets.getSound ("assets/audio/music/shuffle_001.mp3");
		 
		
		if (inName=="assets/audio/sound/correct.mp3")
			 
            return Assets.getSound ("assets/audio/sound/correct.mp3");
		 
		
		if (inName=="assets/audio/sound/wrong.mp3")
			 
            return Assets.getSound ("assets/audio/sound/wrong.mp3");
		 
		
		if (inName=="assets/audio/sound/youwin.mp3")
			 
            return Assets.getSound ("assets/audio/sound/youwin.mp3");
		 
		
		if (inName=="assets/audio/music/shuffle_001.mp3")
			 
            return Assets.getSound ("assets/audio/music/shuffle_001.mp3");
		 
		
		if (inName=="assets/motionwelder/characters.anu")
			 
            return Assets.getBytes ("assets/motionwelder/characters.anu");
         
		
		if (inName=="assets/motionwelder/characters.png")
			 
            return Assets.getBitmapData ("assets/motionwelder/characters.png");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}


class NME_assets_img_background_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_img_bgtile_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_img_bgtile2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_img_issac_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_img_roguetile_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fonts_kanji_fnt extends nme.utils.ByteArray { }
class NME_assets_fonts_kanji_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_fonts_pf_ronda_seven_ttf extends nme.text.Font { }
class NME_assets_game_check_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_cross_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_layout_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_leftpic_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_monk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_rightpic_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_youwin_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_interfaces_game_xml extends nme.utils.ByteArray { }
class NME_assets_interfaces_stage1_xml extends nme.utils.ByteArray { }
class NME_assets_interfaces_test_xml extends nme.utils.ByteArray { }
class NME_assets_audio_music_shuffle_001_mp3 extends nme.media.Sound { }
class NME_assets_audio_sound_correct_mp3 extends nme.media.Sound { }
class NME_assets_audio_sound_wrong_mp3 extends nme.media.Sound { }
class NME_assets_audio_sound_youwin_mp3 extends nme.media.Sound { }
class NME_assets_audio_music_shuffle_2 extends nme.media.Sound { }
class NME_assets_motionwelder_characters_anu extends nme.utils.ByteArray { }
class NME_assets_motionwelder_characters_png extends nme.display.BitmapData { public function new () { super (0, 0); } }

