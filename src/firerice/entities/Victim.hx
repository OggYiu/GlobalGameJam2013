package firerice.entities;

import firerice.entities.Actor;

class Victim extends Monster {
	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );
		isEnemy = true; 

		playerType = ActorEntityType.victim;
	}

	override function tracePlayer()
	{
		if (isTracePlayer == false)
		{	
			isTracePlayer = true;
			move_speed = move_speed * -1;
		}
	}

	override function unTracePlayer()
	{
		if (isTracePlayer == true)
		{
			isTracePlayer = false;
			move_speed = initial_speed;

			target_x = Std.int(wayPointList[0].x);
			target_y = Std.int(wayPointList[0].y);
		}
	}

}