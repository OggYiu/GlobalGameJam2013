package clipper.entities;

import awe6.core.Entity;
import awe6.core.Context;
import awe6.interfaces.IKernel;

import clipper.share.TransformComponent;
import clipper.share.TilePosition;

import awe6.core.View;

class MovableEntity extends ClipperEntity {
	var transform_ : TransformComponent;
	// var context_ : Context;
	// var tilePos_ : TilePosition;
	// var worldPosDirty_ : Bool;
	// var tilePosDirty_ : Bool;
	// var brain_ : Brain;
	// var brainRegulator_ : Regulator;

	public var x( getX, setX ) : Float;
	public var y( getY, setY ) : Float;
	public var dirX( getDirX, setDirX ) : Float;
	public var dirY( getDirY, setDirY ) : Float;
	public var transform( getTransform, null ) : TransformComponent;
	public var direction( getDirection, null ) : Dynamic;
	// var context_ : Context;
	// public var tilePos( getTilePos, null ) : TilePosition;

	// public function new( cols:Int, rows:Int, tileSize:Int, p_kernel:IKernel, ?p_id:String, ?p_context:Context ) {
	public function new( p_kernel:IKernel, ?p_context:Context ) {
		// context_ = p_context;
		// context_ = p_context;
		super( p_kernel, p_context );

		transform_ = new TransformComponent();
		// tilePos_ = new TilePosition( cols, rows, tileSize );
		// brain_ = new Brain( this, p_kernel );
		// brainRegulator_ = new Regulator(1);

		// worldPosDirty_ = false;
		// tilePosDirty_ = false;
	}

	override function _updater( ?p_deltaTime:Int = 0 ):Void {
		// if( tilePosDirty_ ) {
		// 	tilePosDirty_ = false;

		// 	var position : Dynamic = { x:0, y:0, z:0 };
		// 	transform_.getPosition( position );
		// 	tilePos_.setWithScreenPosition( position.x, position.y );
		// }

		// if( worldPosDirty_ ) {
		// 	worldPosDirty_ = false;

		// 	transform_.setWithTilePosition( tilePos_ );
		// }

		// if( brainRegulator_.isReady() ) {
		// 	brain_.update( p_deltaTime );
		// }
	}


	// public function MoveTo( tilePos:TilePosition ) : Void {
	// 	tilePos_ = tilePos;
	// }

	// set and get
	public function setPosition( x:Float, y:Float ) : Void {
		transform_.x = x;
		transform_.y = y;
		transform_.z = 0;
		var view : View = cast( this.view, View );
		view.context.x = x;
		view.context.y = y;
		// (View)this.view
		// worldPosDirty_ = false;
		// tilePosDirty_ = true;
	}

	// public function setTilePosition( x:Int, y:Int ) : Void {
	// 	tilePos_.x = x;
	// 	tilePos_.y = y;

	// 	worldPosDirty_ = true;
	// 	tilePosDirty_ = false;
	// }

	function getTransform() : TransformComponent {
		return transform_;
	}

	function getX() : Float {
		return transform_.x;
	}

	function setX( value : Float ) : Float {
		transform_.x = value;
		var view : View = cast( this.view, View );
		view.context.x = x;
		return transform_.x;
	}

	function getY() : Float {
		return transform_.y;
	}

	function setY( value : Float ) : Float {
		transform_.y = value;
		var view : View = cast( this.view, View );
		view.context.y = y;
		return transform_.y;
	}
	
	function getDirX() : Float {
		return transform_.dirX;
	}

	function setDirX( value : Float ) : Float {
		transform_.dirX = value;
		return transform_.dirX;
	}

	function getDirY() : Float {
		return transform_.dirY;
	}

	function setDirY( value : Float ) : Float {
		transform_.dirY = value;
		return transform_.dirY;
	}

	function getDirection() : Dynamic {
		var direction : Dynamic = transform_.dir;
		return direction;
	}
	// function getTilePos() : TilePosition {
	// 	return tilePos_;
	// }
}