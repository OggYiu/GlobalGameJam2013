package firerice.components;
import firerice.core.Entity;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.core.motionwelder.MSpriteData;
import firerice.core.motionwelder.MSpriteLoader;
import firerice.core.motionwelder.ResourceLoader;
import firerice.interfaces.IDisplayable;
import firerice.types.EOrientation;
import nme.display.Bitmap;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class AnimationComponent extends Component, implements IDisplayable
{
	public static var ID : String = "animationComponent";
	
	public var animator( default, null ) : MAnimationSet;
	public var context( default, null ) : Sprite;
	var contextBitmap_ : Bitmap = null;
	
	public function new( p_owner : Entity, p_animationFilePath : String ) {
		super( AnimationComponent.ID, p_owner );
		
		this.context = new Sprite();
		contextBitmap_ = new Bitmap();
		this.context.addChild( contextBitmap_ );
		this.owner.context.addChild( this.context );
		
		var spriteData : MSpriteData;
		spriteData = MSpriteLoader.getInstance().loadMSprite( p_animationFilePath, true, ResourceLoader.getInstance() );
		this.animator = MReader.read( spriteData );
		this.animator.setEventReceiver( this, AnimationCompleteHandler, AnimationEventHandler );
		this.animator.play(0, EOrientation.none, WrapMode.single, true );
		//this.animator.targetCallbackObj = this;
		//this.animator.animationCompleteDelegate = AnimationCompleteHandler;
		//this.animator.animationEventDelegate = AnimationEventHandler;
		
		//var bitmap : Bitmap = new Bitmap();
		//bitmap.bitmapData = this.animator.currentFrame.frameImages[0].bitmapdata;
		//this.context.addChild( bitmap );
	}
	//public function createEntity( type : EntityType, x: Int, y : Int, dirX : Int, dirY : Int ) : GameEntity {
		//var newEntity : GameEntity = null;
		//var animDef : MAnimationDefine = new MAnimationDefine();
		//var animId : Int = 0;
//
		//var spriteData : MSpriteData;
		//spriteData = MSpriteLoader.getInstance().loadMSprite( "characters", true, ResourceLoader.getInstance() );
		//animationSet_ = MReader.read( spriteData );
		//
		//switch( type ) {
			//case EntityType.footman:
				//animId = 0;
			//case EntityType.whiteWizard:
				//animId = 4;
		//}
//
		//animDef.addAnim( "r_walk", animId++ );
		//animDef.addAnim( "l_walk", animId++ );
		//animDef.addAnim( "f_walk", animId++ );
		//animDef.addAnim( "b_walk", animId++ );
//
		//newEntity = new GameEntity(	_kernel,
									//animationSet_,
									//animDef,
									//this );
		//newEntity.x = x * TILE_SIZE + TILE_SIZE / 2;
		//newEntity.y = y * TILE_SIZE + TILE_SIZE / 2;
		//newEntity.dirX = dirX;
		//newEntity.dirY = dirY;
//
		//return newEntity;
	//}
	
	override private function update_(dt:Float):Void 
	{
		super.update_(dt);
		this.animator.update( dt );
	}
	
	function AnimationCompleteHandler(	animationSet : MAnimationSet,
										clipId : Int) : Void {
		 //trace( "<MGameEntity::AnimationCompleteHandler>" );
	}

	function AnimationEventHandler(	animationSet : MAnimationSet,
									animation : MAnimation,
									frame : MFrame,
									unknown : Int ) : Void {
		// trace( "<MGameEntity::AnimationEventHandler>" );
		contextBitmap_.bitmapData = frame.frameImages[0].bitmapdata;
		contextBitmap_.x = frame.frameImages[0].xPos;
		contextBitmap_.y = frame.frameImages[0].yPos;

		 //trace( "<MGameEntity::AnimationEventHandler>, contextBitmap_.bitmapData: " + contextBitmap_.bitmapData );
	}
}