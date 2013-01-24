package clipper.entities.fighting;

import awe6.interfaces.IKernel;

import clipper.share.motionwelder.MReader;
import clipper.share.Debug;
import clipper.share.StateMachine;

enum FightState {
	standing;
	crouching;
	walking;
	jumpStart;
	jumpUpwards;
	jumpDownward;
	jumpLanding;
	runJumpStart;
	runJumpUpwards;
	runJumpDownward;
	runJumpLanding;
	runForward;
	runStop;
	guard;
	guardingHit;
	standHitLight;
	standHitHeavy;
	airHit;
	airFall;
	lieDownHit;
	hittingGroundFromFall;
	lieDown;
	getUpFromLieDown;
}

class FightEntity extends AnimatedEntity {
	// var isAttacking_ : Bool = false;
	// public var isAttacking( getIsAttacking, setIsAttacking ) : Bool;

	var stateMachine_ : StateMachine;
	public function new(	p_kernel:IKernel,
							animationSet : MAnimationSet,
							animDef : MAnimationDefine ) {
		super( p_kernel, animationSet, animDef );
	}

	override private function _init():Void {
		super._init();

		stateMachine_ = new StateMachine();
	}

	override private function _updater( ?p_deltaTime:Int = 0 ):Void  {
		super._updater( p_deltaTime );

		stateMachine_.update();
	}

	override private function _disposer():Void {
		stateMachine_.dispose();
		stateMachine_ = null;
	}
}