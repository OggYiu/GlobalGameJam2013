package firerice.entities;
import firerice.core.Entity;
import com.eclecticdesignstudio.motion.Actuate;
import flash.geom.Point;
import firerice.common.Global;
import firerice.entities.Actor;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;

class Monster2 extends Monster 
{
	var transform_range : Float = 120;

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

		if (Point.distance(new Point(Global.getInstance().GameCharacter.x, Global.getInstance().GameCharacter.y), new Point(this.x, this.y)) < transform_range)
		{
			if (this.currAnimType != ActorAnimType.transform && !isTransfored)
			{
				isTransforming = true;
				this.animComponent.target = this;
				this.animComponent.completeHandler = completeHandler;
				this.playAnim( ActorAnimType.transform , WrapMode.once );
				move_speed = trace_speed;
			}
		}
	}
}