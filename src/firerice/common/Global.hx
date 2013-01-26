package firerice.common;

import nme.geom.Point;
import firerice.scenes.SceneGame;
import firerice.entities.Player;

class Global {

	public var GameCharacter : Player;

	public var cameraPos( default, default ) : Point;
	public var sceneGame( default, default ) : SceneGame;

	public function new() {
		cameraPos = new Point( 0, 0 );
	}

	static var s_canInit_ : Bool = false;
	static var s_instance_ : Global = null;
	public static function getInstance() : Global {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new Global();
			s_canInit_ = false;
		}

		return s_instance_;
	}
}