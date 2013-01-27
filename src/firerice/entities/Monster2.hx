package firerice.entities;

class Monster2 extends Monster 
{
	override function tracePlayer()
	{
		if (isTracePlayer == false)
		{	
			isTracePlayer = true;
			move_speed = move_speed * -1;
		}
	}

	override function update_( dt : Float ) : Void 
	{
		super.update_( dt );
	}
}