package firerice.entities;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.components.CommandComponent;
import firerice.core.Process;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.InputManager;
import firerice.entities.Monster;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import firerice.game.LivingRoom;
import firerice.interfaces.IDisplayable;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;

/**
 * ...
 * @author oggyiu
 */

class Steer extends Process, implements IDisplayable {
	public var context( default, null ) : Sprite;
	public var owner( default, null ) : Actor;
	public var radius( default, null ) : Float;
	public var offsetX( default, null ) : Float;
	public var offsetY( default, null ) : Float;

	public function new( p_owner : Actor, p_radius : Float, p_offsetX : Float, p_offsetY : Float ) {
		super( "steer" );

		this.owner = p_owner;
		this.radius = p_radius;
		this.context = new Sprite();
		this.offsetX = p_offsetX;
		this.offsetY = p_offsetY;

		redraw();
	}

	function redraw() : Void {
		this.context.graphics.clear();
		this.context.graphics.beginFill( 0xFF0000);
		this.context.graphics.drawCircle( this.offsetX, this.offsetY, this.radius );
		this.context.graphics.endFill();
	}
}