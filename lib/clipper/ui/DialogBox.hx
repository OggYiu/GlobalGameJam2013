package clipper.ui;

import awe6.interfaces.IKernel;
import awe6.core.Context;

import nme.text.Font;
import nme.text.TextFormat;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.geom.Matrix;

import clipper.entities.MovableEntity;
import clipper.entities.TiledSprite;
import minimalcomps.Label;

class DialogBox extends MovableEntity {
	public function new(	p_kernel : IKernel,
							dialogAssetsFolderPath : String,
							// font : Font,
							width : Int,
							height : Int ) {
							// textOffsetX : Int,
							// textOffsetY : Int ) {
		var cornerTLBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "tlCorner.png" );
		var cornerTRBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "trCorner.png" );
		var cornerBRBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "brCorner.png" );
		var cornerBLBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "blCorner.png" );
		var borderTBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "tBorder.png" );
		var borderRBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "rBorder.png" );
		var borderBBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "bBorder.png" );
		var borderLBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "lBorder.png" );
		var fillBitmapData : BitmapData = Assets.getBitmapData( dialogAssetsFolderPath + "fill.png" );

		// draw(	source:IBitmapDrawable, matrix:Matrix = null,
		// 		colorTransform:flash.geom:ColorTransform = null,
		// 		blendMode:String = null, clipRect:Rectangle = null,
		// 		smoothing:Boolean = false):void
		var finalBitmapData : BitmapData = new BitmapData( width, height );
		// draw tl corner
		finalBitmapData.draw( cornerTLBitmapData );

		// draw tr corner
		finalBitmapData.draw( cornerTRBitmapData, new Matrix( 1, 0, 0, 1, width - cornerTRBitmapData.width, 0 ) );

		// draw bl corner
		finalBitmapData.draw( cornerBLBitmapData, new Matrix( 1, 0, 0, 1, 0, height - cornerBRBitmapData.height ) );

		// draw br corner
		finalBitmapData.draw( cornerBRBitmapData, new Matrix( 1, 0, 0, 1, width - cornerBLBitmapData.width, height - cornerBLBitmapData.height ) );

		// draw top border
		var topBorderBitmapData : BitmapData = TiledSprite.createTiledBitmapData(	borderTBitmapData,
																					width - cornerTLBitmapData.width - cornerTRBitmapData.width,
																					borderTBitmapData.height );
		finalBitmapData.draw( topBorderBitmapData, new Matrix( 1, 0, 0, 1, cornerTLBitmapData.width, 0 ) );

		// draw right border
		var rightBorderBitmapData : BitmapData = TiledSprite.createTiledBitmapData(	borderRBitmapData,
																					borderRBitmapData.width,
																					height - cornerTRBitmapData.height - cornerBRBitmapData.height );
		finalBitmapData.draw( rightBorderBitmapData, new Matrix( 1, 0, 0, 1, width - borderRBitmapData.width, cornerTRBitmapData.height ) );

		// draw bottom border
		var bottomBorderBitmapData : BitmapData = TiledSprite.createTiledBitmapData(	borderBBitmapData,
																						width - cornerBLBitmapData.width - cornerBRBitmapData.width,
																						borderBBitmapData.height );
		finalBitmapData.draw( bottomBorderBitmapData, new Matrix( 1, 0, 0, 1, cornerBLBitmapData.width, height - cornerBLBitmapData.height ) );

		// draw left border
		var leftBorderBitmapData : BitmapData = TiledSprite.createTiledBitmapData(	borderLBitmapData,
																					borderLBitmapData.width,
																					height - cornerTLBitmapData.height - cornerBLBitmapData.height );
		finalBitmapData.draw( leftBorderBitmapData, new Matrix( 1, 0, 0, 1, 0, cornerTLBitmapData.height ) );

		// fill center by images
		var centerBitmapData : BitmapData = TiledSprite.createTiledBitmapData(	fillBitmapData,
																				width - cornerTLBitmapData.width - cornerTRBitmapData.width,
																				height - cornerTLBitmapData.height - cornerBLBitmapData.height );
		finalBitmapData.draw( centerBitmapData, new Matrix( 1, 0, 0, 1, cornerTLBitmapData.width, cornerTLBitmapData.height ) );

		var context : Context = new Context();
		context.addChild( new Bitmap( finalBitmapData ) );
		super( p_kernel, context );

		// create font
		// var label : Label = new Label( context, textOffsetX, textOffsetY, "hello world!", 20, 0x000000 );
	}
}