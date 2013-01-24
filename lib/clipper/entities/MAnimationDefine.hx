package clipper.entities;

import clipper.share.Debug;

class MAnimationDefine {
	var animNameMap_ : Hash<Int>;

	public function new() {
		animNameMap_ = new Hash<Int>();
	}

	public function addAnim( name : String, index : Int ) : Bool {
		Debug.Assert( !isExist( name ), "<MAnimationDefine::getIndex>, anim name : " + name + " already exist!" );
		animNameMap_.set( name, index );
		return true;
	}

	public function isExist( name : String ) : Bool {
		return animNameMap_.exists( name );
	}

	public function getIndex( name : String ) : Int {
		Debug.Assert( isExist( name ), "<MAnimationDefine::getIndex>, anim name : " + name + " dont exist!" );
		return animNameMap_.get( name );
	}
}