package firerice.entities;
import firerice.core.Entity;
import com.eclecticdesignstudio.motion.Actuate;
import flash.geom.Point;
import firerice.common.Global;
import firerice.entities.Actor;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;

class Monster extends Actor {

	var initial_speed : Float = 50;
	var trace_speed : Float = 130;
	var trace_range : Float = 200;

	var target_x : Int;
	var target_y : Int;
	var move_speed : Float;
	var wayPointList : Array<Point>;
	var isTracePlayer : Bool;
	var isTransforming : Bool;

	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id, p_parent );

		target_x = 0;
		target_y = 0;
		isTracePlayer = false;
		isTransforming = false;
		move_speed = initial_speed;
	}

	private function tracePlayer()
	{
		if (isTracePlayer == false)
		{	
			isTracePlayer = true;
			move_speed = trace_speed;

			if (this.currAnimType != ActorAnimType.transform)
			{
				isTransforming = true;
				this.playAnim( ActorAnimType.transform , WrapMode.once );
			}
		}
	}

	private function unTracePlayer()
	{
		if (isTracePlayer == true)
		{
			isTracePlayer = false;
			move_speed = initial_speed;

			target_x = Std.int(wayPointList[0].x);
			target_y = Std.int(wayPointList[0].y);
		}
	}

	private function move (p_x : Int, p_y :Int, p_speed : Float)
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
		
		if (Point.distance(new Point(Global.getInstance().GameCharacter.x, Global.getInstance().GameCharacter.y), new Point(this.x, this.y)) < trace_range)
		{
			this.tracePlayer();
		}
		else
		{
			this.unTracePlayer();
		}
		
		if (isTracePlayer == true)
		{
			target_x = Std.int(Global.getInstance().GameCharacter.x);
			target_y = Std.int(Global.getInstance().GameCharacter.y);
		}
		
		if (target_x != 0)
		{
			if (this.x < target_x)
			{
				if (this.currAnimType != ActorAnimType.walkRight && !isTransforming)
				{
					this.playAnim( ActorAnimType.walkRight );
				}

				if (this.x + Std.int(move_speed * dt) > target_x)
				{
					this.x = target_x;
				}
				else
				{
					this.x += Std.int(move_speed * dt);
				}
			}
			else if (this.x > target_x)
			{
				if (this.currAnimType != ActorAnimType.walkLeft && !isTransforming)
				{
					this.playAnim( ActorAnimType.walkLeft );
				}

				if (this.x - Std.int(move_speed * dt) < target_x)
				{
					this.x = target_x;
				}
				else
				{
					this.x -= Std.int(move_speed * dt);
				}
			}
		}

		if (target_y != 0)
		{
			if (this.y < target_y)
			{
				if (this.y + Std.int(move_speed * dt) > target_y)
				{
					this.y = target_y;
				}
				else
				{
					this.y += Std.int(move_speed * dt);
				}
			}
			else if (this.y > target_y)
			{
				if (this.y - Std.int(move_speed * dt) < target_y)
				{
					this.y = target_y;
				}
				else
				{
					this.y -= Std.int(move_speed * dt);
				}
			}
		}
	}
}