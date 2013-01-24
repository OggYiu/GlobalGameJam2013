package clipper.share;

import clipper.game.GameEntity;
import clipper.share.MSpriteData;
import clipper.share.motionwelder.MReader;

import awe6.interfaces.IKernel;
import awe6.core.Context;

class GameEntityFactor {
	static var s_instance_ : GameEntityFactor = null;
	static var s_can_init_ : Bool = false;

	public static function getInstance() : GameEntityFactor {
		if( s_instance_ == null ) {
			s_can_init_ = true;
			s_instance_ = new GameEntityFactor();
			s_can_init_ = false;
		}

		return s_instance_;
	} 

	public function new() {
		if( !s_can_init_ ) {
			throw "you cannot have two instance of a singleton class!";
		}
	}

	public function CreateWithMSpriteData( kernel : IKernel, drawImageInfo : DrawImageInfo ) : GameEntity {
		var context : Context = new Context();
		context.addChild( drawImageInfo.bitmap );
		var gameEntity : GameEntity = new GameEntity( kernel, context );
		return gameEntity;
	}
}