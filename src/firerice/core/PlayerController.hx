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

class PlayerController {
	public function new() {
	}

	static var s_canInit_ : Bool = false;
	static var s_instance_ : PlayerController = null;
	public static function getInstance() : PlayerController {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new PlayerController();
			s_canInit_ = false;
		}

		return s_instance_;
	}
}