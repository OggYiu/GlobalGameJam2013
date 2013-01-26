package firerice.game;
import firerice.components.AnimationComponent;
import firerice.components.SpriteComponent;
import firerice.components.CommandComponent;
import firerice.common.Global;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.core.Process;
import firerice.core.InputManager;
import firerice.entities.Actor;
import firerice.entities.Player;
import firerice.entities.Monster;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import firerice.interfaces.IDisplayable;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.media.Sound;
import nme.geom.Rectangle;
import nme.geom.Point;
import com.eclecticdesignstudio.motion.Actuate;

class CollisionManager extends Process, implements IDisplayable {
	public var collisionBoxes( default, null ) : Array<CollisionBox> = null;
	public var context( default, null ) : Sprite;
	public var target( default, default ) : Dynamic = null;
	public var handler( default, default ) : CollisionBox -> CollisionBox -> Void = null;

	var lastSize_ : Int = 0;

	public function new() {
		super( "collisionManager" );
		collisionBoxes = new Array<CollisionBox>();
		context = new Sprite();
		target = null;
		handler = null;
	}

	public function addCollisionBox( collisionBox : CollisionBox ) : Void {
		collisionBoxes.push( collisionBox );
	}

	public function removeCollisionBox( p_owner : Actor ) : Void {
		var index : Int = 0;
		var box : CollisionBox;
		while( index < collisionBoxes.length ) {
			box = collisionBoxes[index];
			if( box.owner == p_owner ) {
				collisionBoxes.remove( box );
				--index;
			}

			++index;
		}

		// collisionBoxs.push( collisionBox );
	}

	public function reset() : Void {
		this.target = null;
		this.handler = null;
		collisionBoxes.splice( 0, collisionBoxes.length );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		// if( lastSize_ != collisionBoxes.length ) {
			// trace( "hello!!!" ) ;
			this.context.graphics.clear();
			this.context.graphics.lineStyle( 3, 0xFF0000 );
			lastSize_ = collisionBoxes.length;

			var cameraPos : Point = Global.getInstance().cameraPos;
			// trace( "cameraPos: " + cameraPos );
			for( box in collisionBoxes ) {
				if( box.dead ) {
					continue;
				}
				// trace( "box: " + box );
				this.context.graphics.moveTo(	box.rect.x - cameraPos.x,
												box.rect.y - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x + box.rect.width - cameraPos.x,
												box.rect.y - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x + box.rect.width - cameraPos.x,
												box.rect.y + box.rect.height - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x - cameraPos.x,
												box.rect.y + box.rect.height - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x - cameraPos.x,
												box.rect.y - cameraPos.y );
			}
		// }

		for( boxA in collisionBoxes ) {
			for( boxB in collisionBoxes ) {
				if( boxA == boxB ) {
					continue;
				}
				if( boxA.dead || boxB.dead ) {
					continue;
				}
				if( boxA.owner == boxB.owner ) {
					continue;
				}

				if( hitTest(	boxA.rect.x, boxA.rect.y, boxA.rect.width, boxA.rect.height,
								boxB.rect.x, boxB.rect.y, boxB.rect.width, boxB.rect.height ) ) {
					if( target != null && handler != null ) {
						Reflect.callMethod( target, handler, [ boxA, boxB ] );
					}
				}
			}
		}
	}

	// function hitTest( boxA : CollisionBox, boxB : CollisionBox ) : Bool {
 //  		return !(	( boxA.rect.x ) > ( boxB.rect.x + boxB.rect.width ) || 
	// 	           	( boxA.rect.x + boxA.rect.width ) < boxB.rect.x || 
	// 	           	( boxA.rect.y ) > ( boxB.rect.y + boxB.rect.height ) ||
	// 	           	( boxA.rect.y + boxA.rect.height ) < ( boxB.rect.y ));
	// }
	function hitTest( x_1 : Float, y_1 : Float, width_1 : Float, height_1 : Float, x_2 : Float, y_2 : Float, width_2 : Float, height_2 : Float ) : Bool {
		return !(x_1 > x_2+width_2 || x_1+width_1 < x_2 || y_1 > y_2+height_2 || y_1+height_1 < y_2);
	}

	static var s_canInit_ : Bool = false;
	static var s_instance_ : CollisionManager = null;
	public static function getInstance() : CollisionManager {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new CollisionManager();
			s_canInit_ = false;
		}

		return s_instance_;
	}
}