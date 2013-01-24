package clipper.entities.fighting.states;

import clipper.core.CProcess;
import nme.Vector;

enum MoveType {
	standNormAtk;
	standSpecAtk;
	crouchNormAtk;
	aerialNormAtk;
}

enum PhysicModel {
	standing;
}

enum ActorStance {
	standing;
}

enum StateInfoType {
	hitDef;
	changeState;
}

class State extends CProcess {
	public var Id ( default, null ) : Int;
	public var animationId ( default, null ) : Int;
	public var actorStance ( default, null ) : ActorStance;
	public var physicModel ( default, null ) : PhysicModel;
	public var velocity ( default, null ) : Vector<Float>;
	public var canControl ( default, null ) : Bool;

	public var stateInfos ( default, null ) : Array<StateInfo>;

	public function new(	p_Id : Int,
							p_animationId : Int,
							p_actorStance : ActorStance,
							p_physicModel : PhysicModel,
							p_canControl : Bool,
							p_stateInfos : Array<StateInfo> ) {
		super();

		Id = p_Id;
		animationId = p_animationId;
		actorStance = p_actorStance;
		physicModel = p_physicModel;
		canControl = p_canControl;
		stateInfos = p_stateInfos;
	}

	override private function _init():Void {
	}

	override private function _disposer():Void {
	}

	override private function _updater( ?p_deltaTime:Int = 0 ):Void {
	}

}

class StateInfo {
	public var type ( default, null ) : StateInfoType;

	public function new( p_type : StateInfoType ) {
		type = p_type;
	}
}

// class StateInfo {
// 	public var Id ( default, null ) : Int;
// 	public var type ( default, null ) : StateInfoType;
// 	public var animationId ( default, null ) : Int;
// 	public var actorStance ( default, null ) : ActorStance;
// 	public var physicModel ( default, null ) : PhysicModel;
// 	public var velocity ( default, null ) : Vector<Float>;

// 	public function new(	p_Id : Int,
// 							p_type : StateInfoType,
// 							p_animationId : Int,
// 							p_actorStance : ActorStance,
// 							p_physicModel : PhysicModel ) {
// 		Id = p_Id;
// 		type = p_type;
// 		animationId = p_animationId;
// 		actorStance = p_actorStance;
// 		physicModel = p_physicModel;
// 	}
// }

class StateInfoHitDef extends StateInfo {
	public var damage ( default, null ) : Float;

	public function new( p_damage : Float ) {
		super( StateInfoType.hitDef );

		damage = p_damage;
	}
}

class StateInfoChangeState extends StateInfo {
	public var targetId ( default, null ) : Int;
	public var canControl ( default, null ) : Bool;

	public function new( p_targetId : Int, p_canControl : Bool ) {
		super( StateInfoType.changeState );

		targetId = p_targetId;
		canControl = p_canControl;
	}
}