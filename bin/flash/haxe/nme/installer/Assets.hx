package nme.installer;


import nme.display.BitmapData;
import nme.media.Sound;
import nme.net.URLRequest;
import nme.text.Font;
import nme.utils.ByteArray;
import ApplicationMain;


/**
 * ...
 * @author Joshua Granick
 */

class Assets {

	
	public static var cachedBitmapData:Hash<BitmapData> = new Hash<BitmapData>();
	
	private static var initialized:Bool = false;
	private static var resourceClasses:Hash <Dynamic> = new Hash <Dynamic> ();
	private static var resourceTypes:Hash <String> = new Hash <String> ();
	
	
	private static function initialize ():Void {
		
		if (!initialized) {
			
			resourceClasses.set ("assets/img/background.png", NME_assets_img_background_png);
			resourceTypes.set ("assets/img/background.png", "image");
			resourceClasses.set ("assets/img/bgTile.png", NME_assets_img_bgtile_png);
			resourceTypes.set ("assets/img/bgTile.png", "image");
			resourceClasses.set ("assets/img/bgTile2.png", NME_assets_img_bgtile2_png);
			resourceTypes.set ("assets/img/bgTile2.png", "image");
			resourceClasses.set ("assets/img/issac.png", NME_assets_img_issac_png);
			resourceTypes.set ("assets/img/issac.png", "image");
			resourceClasses.set ("assets/img/rogueTile.png", NME_assets_img_roguetile_png);
			resourceTypes.set ("assets/img/rogueTile.png", "image");
			resourceClasses.set ("assets/fonts/kanji.fnt", NME_assets_fonts_kanji_fnt);
			resourceTypes.set ("assets/fonts/kanji.fnt", "binary");
			resourceClasses.set ("assets/fonts/kanji.png", NME_assets_fonts_kanji_png);
			resourceTypes.set ("assets/fonts/kanji.png", "image");
			resourceClasses.set ("assets/fonts/pf_ronda_seven.ttf", NME_assets_fonts_pf_ronda_seven_ttf);
			resourceTypes.set ("assets/fonts/pf_ronda_seven.ttf", "font");
			resourceClasses.set ("assets/game/check.png", NME_assets_game_check_png);
			resourceTypes.set ("assets/game/check.png", "image");
			resourceClasses.set ("assets/game/cross.png", NME_assets_game_cross_png);
			resourceTypes.set ("assets/game/cross.png", "image");
			resourceClasses.set ("assets/game/layout.png", NME_assets_game_layout_png);
			resourceTypes.set ("assets/game/layout.png", "image");
			resourceClasses.set ("assets/game/leftPic.png", NME_assets_game_leftpic_png);
			resourceTypes.set ("assets/game/leftPic.png", "image");
			resourceClasses.set ("assets/game/monk.png", NME_assets_game_monk_png);
			resourceTypes.set ("assets/game/monk.png", "image");
			resourceClasses.set ("assets/game/rightPic.png", NME_assets_game_rightpic_png);
			resourceTypes.set ("assets/game/rightPic.png", "image");
			resourceClasses.set ("assets/game/youwin.png", NME_assets_game_youwin_png);
			resourceTypes.set ("assets/game/youwin.png", "image");
			resourceClasses.set ("assets/interfaces/game.xml", NME_assets_interfaces_game_xml);
			resourceTypes.set ("assets/interfaces/game.xml", "text");
			resourceClasses.set ("assets/interfaces/stage1.xml", NME_assets_interfaces_stage1_xml);
			resourceTypes.set ("assets/interfaces/stage1.xml", "text");
			resourceClasses.set ("assets/interfaces/test.xml", NME_assets_interfaces_test_xml);
			resourceTypes.set ("assets/interfaces/test.xml", "text");
			resourceClasses.set ("assets/audio/music/shuffle_001.mp3", NME_assets_audio_music_shuffle_001_mp3);
			resourceTypes.set ("assets/audio/music/shuffle_001.mp3", "music");
			resourceClasses.set ("assets/audio/sound/correct.mp3", NME_assets_audio_sound_correct_mp3);
			resourceTypes.set ("assets/audio/sound/correct.mp3", "music");
			resourceClasses.set ("assets/audio/sound/wrong.mp3", NME_assets_audio_sound_wrong_mp3);
			resourceTypes.set ("assets/audio/sound/wrong.mp3", "music");
			resourceClasses.set ("assets/audio/sound/youwin.mp3", NME_assets_audio_sound_youwin_mp3);
			resourceTypes.set ("assets/audio/sound/youwin.mp3", "music");
			resourceClasses.set ("assets/audio/music/shuffle_001.mp3", NME_assets_audio_music_shuffle_2);
			resourceTypes.set ("assets/audio/music/shuffle_001.mp3", "music");
			resourceClasses.set ("assets/motionwelder/characters.anu", NME_assets_motionwelder_characters_anu);
			resourceTypes.set ("assets/motionwelder/characters.anu", "binary");
			resourceClasses.set ("assets/motionwelder/characters.png", NME_assets_motionwelder_characters_png);
			resourceTypes.set ("assets/motionwelder/characters.png", "image");
			
			initialized = true;
			
		}
		
	}
	
	
	public static function getBitmapData (id:String, useCache:Bool = true):BitmapData {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "image") {
			
			if (useCache && cachedBitmapData.exists (id)) {
				
				return cachedBitmapData.get (id);
				
			} else {
				
				var data = cast (Type.createInstance (resourceClasses.get (id), []), BitmapData);
				
				if (useCache) {
					
					cachedBitmapData.set (id, data);
					
				}
				
				return data;
				
			}
			
		} else {
			
			trace ("[nme.Assets] There is no BitmapData asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getBytes (id:String):ByteArray {
		
		initialize ();
		
		if (resourceClasses.exists (id)) {
			
			return Type.createInstance (resourceClasses.get (id), []);
			
		} else {
			
			trace ("[nme.Assets] There is no ByteArray asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getFont (id:String):Font {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "font") {
			
			return cast (Type.createInstance (resourceClasses.get (id), []), Font);
			
		} else {
			
			trace ("[nme.Assets] There is no Font asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getSound (id:String):Sound {
		
		initialize ();
		
		if (resourceTypes.exists (id)) {
			
			if (resourceTypes.get (id) == "sound" || resourceTypes.get (id) == "music") {
				
				return cast (Type.createInstance (resourceClasses.get (id), []), Sound);
				
			}
			
		}
		
		trace ("[nme.Assets] There is no Sound asset with an ID of \"" + id + "\"");
		
		return null;
		
	}
	
	
	public static function getText (id:String):String {
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
	}
	
	
}