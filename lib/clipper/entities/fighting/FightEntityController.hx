package clipper.entities.fighting;

import awe6.interfaces.IKernel;
import awe6.core.Process;
import awe6.Types.EKey;

import clipper.entities.FightEntity;
import clipper.share.motionwelder.MReader.WrapMode;
import clipper.share.motionwelder.MReader;
import clipper.share.motionwelder.MReader.Orientation;

class FightEntityController extends Process {
	var owner_ : FightEntity;

	public function new( p_kernel : IKernel, owner : FightEntity ) {
		super( p_kernel );
		owner_ = owner;
	}

	override private function _updater( ?p_deltaTime:Int = 0 ) : Void {
							// id : Int,
							// orientation : Orientation,
							// wrapMode : WrapMode,
							// overrideCurr : Bool,
							// targetCallbackObj : Dynamic = null,
							// animationCompleteDelegate : AnimationCompleteDelegate = null,
							// animationEventDelegate : AnimationEventDelegate = null ) : Void {

		var direction : Dynamic = { x:0, y:0, z:0 };
		owner_.transform.getDirection( direction );
		var targetAnimName : String = "";

		if( !_kernel.inputs.keyboard.isAnyKeyDown() && !owner_.isAttacking ) {
			if( direction.x > 0 ) {
				targetAnimName = "r_idle";
			} else {
				targetAnimName = "l_idle";
			}
			owner_.playAnimWithName(targetAnimName,
									Orientation.none,
									WrapMode.once,
									false,
									this );
		}
		else {
			var next_x : Float = owner_.x;
			var next_y : Float = owner_.y;
			if( _kernel.inputs.keyboard.getIsKeyDown( EKey.RIGHT ) && !owner_.isAttacking ) {
				// trace( "<Intro::_updater>, keyback" );
				owner_.playAnimWithName( "r_walk", Orientation.none, WrapMode.loop, false );
				next_x += p_deltaTime / 10;
			}
			if( _kernel.inputs.keyboard.getIsKeyDown( EKey.LEFT ) && !owner_.isAttacking ) {
				// trace(20 "<Intro::_updater>, keyback" );
				owner_.playAnimWithName( "l_walk", Orientation.flipH, WrapMode.loop, false );
				next_x -= p_deltaTime / 10;
			}
			if( _kernel.inputs.keyboard.getIsKeyDown( EKey.UP ) && !owner_.isAttacking ) {
				if( direction.x > 0 ) {
					targetAnimName = "r_walk";
				} else {
					targetAnimName = "l_walk";
				}
				owner_.playAnimWithName( targetAnimName, Orientation.none, WrapMode.loop, false );
				next_y -= p_deltaTime / 10;
			}
			if( _kernel.inputs.keyboard.getIsKeyDown( EKey.DOWN ) && !owner_.isAttacking ) {
				if( direction.x > 0 ) {
					targetAnimName = "r_walk";
				} else {
					targetAnimName = "l_walk";
				}
				owner_.playAnimWithName( targetAnimName, Orientation.none, WrapMode.loop, false );
				next_y += p_deltaTime / 10;
			}
			if( _kernel.inputs.keyboard.getIsKeyDown( EKey.SPACE ) && !owner_.isAttacking ) {
				// trace( "<Intro::_updater>, keyback" );
				if( direction.x > 0 ) {
					targetAnimName = "r_left_punch";
				} else {
					targetAnimName = "l_left_punch";
				}
				owner_.playAnimWithName( targetAnimName, Orientation.none, WrapMode.once, false, this, AttackCompleteHandler );
				owner_.isAttacking = true;
			}
			owner_.setPosition( next_x, next_y );
		}
	}

	function AttackCompleteHandler(	animationSet : MAnimationSet,
									clipId : Int) : Void {
		owner_.isAttacking = false;
	}
}