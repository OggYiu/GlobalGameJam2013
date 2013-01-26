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
			
			resourceClasses.set ("assets/img/bgTile2.png", NME_assets_img_bgtile2_png);
			resourceTypes.set ("assets/img/bgTile2.png", "image");
			resourceClasses.set ("assets/img/MAP_001.png", NME_assets_img_map_001_png);
			resourceTypes.set ("assets/img/MAP_001.png", "image");
			resourceClasses.set ("assets/img/MAP_002.png", NME_assets_img_map_002_png);
			resourceTypes.set ("assets/img/MAP_002.png", "image");
			resourceClasses.set ("assets/fonts/kanji.fnt", NME_assets_fonts_kanji_fnt);
			resourceTypes.set ("assets/fonts/kanji.fnt", "binary");
			resourceClasses.set ("assets/fonts/kanji.png", NME_assets_fonts_kanji_png);
			resourceTypes.set ("assets/fonts/kanji.png", "image");
			resourceClasses.set ("assets/fonts/pf_ronda_seven.ttf", NME_assets_fonts_pf_ronda_seven_ttf);
			resourceTypes.set ("assets/fonts/pf_ronda_seven.ttf", "font");
			resourceClasses.set ("assets/interfaces/game.xml", NME_assets_interfaces_game_xml);
			resourceTypes.set ("assets/interfaces/game.xml", "text");
			resourceClasses.set ("assets/interfaces/stage1.xml", NME_assets_interfaces_stage1_xml);
			resourceTypes.set ("assets/interfaces/stage1.xml", "text");
			resourceClasses.set ("assets/interfaces/test.xml", NME_assets_interfaces_test_xml);
			resourceTypes.set ("assets/interfaces/test.xml", "text");
			resourceClasses.set ("assets/motionwelder/boy.anu", NME_assets_motionwelder_boy_anu);
			resourceTypes.set ("assets/motionwelder/boy.anu", "binary");
			resourceClasses.set ("assets/motionwelder/boy.png", NME_assets_motionwelder_boy_png);
			resourceTypes.set ("assets/motionwelder/boy.png", "image");
			resourceClasses.set ("assets/motionwelder/monster1.anu", NME_assets_motionwelder_monster1_anu);
			resourceTypes.set ("assets/motionwelder/monster1.anu", "binary");
			resourceClasses.set ("assets/motionwelder/monster1.png", NME_assets_motionwelder_monster1_png);
			resourceTypes.set ("assets/motionwelder/monster1.png", "image");
			
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