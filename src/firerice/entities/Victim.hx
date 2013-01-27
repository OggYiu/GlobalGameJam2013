package firerice.entities;

class Victim extends Monster {



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