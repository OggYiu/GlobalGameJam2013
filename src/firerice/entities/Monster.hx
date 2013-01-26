package firerice.entities;
import firerice.core.Entity;
import com.eclecticdesignstudio.motion.Actuate;
import flash.geom.Point;

class Monster extends Actor {

	var target_x : Int;
	var target_y : Int;
	var move_speed : Float = 2;
	var wayPointList : Array<Point>;

	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );
	}

	public function move (p_x : Int, p_y :Int, p_speed : Float)
	{
		target_x = p_x;
		target_y = p_y;
		move_speed = p_speed;
	}

	public function setWayPoint( p_pointAry : Array<Point> )
	{
		wayPointList = p_pointAry;
		target_x = Std.int(wayPointList[0].x);
		target_y = Std.int(wayPointList[0].y);
	}

	override function update_( dt : Float ) : Void 
	{
		super.update_( dt );

		if (wayPointList != null)
		{
			var index = 0;
			while (index < wayPointList.length)
			{
				if (this.x == wayPointList[index].x && this.y == wayPointList[index].y)
				{
					// trace(index);

					if (index == wayPointList.length - 1)
					{
						target_x = Std.int(wayPointList[0].x);
						target_y = Std.int(wayPointList[0].y);
					}
					else
					{
						target_x = Std.int(wayPointList[index+1].x);
						target_y = Std.int(wayPointList[index+1].y);
					}
				}

				index++;
			}
		}
		
		if (this.x < target_x)
		{
			this.x += move_speed;
		}
		else if (this.x > target_x)
		{
			this.x -= move_speed;
		}

		if (this.y < target_y)
		{
			this.y += move_speed;
		}
		else if (this.y > target_y)
		{
			this.y -= move_speed;
		}
	}
}