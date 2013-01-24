package firerice.ui;
import nme.Assets;
import nme.display.Sprite;
import pxBitmapFont.PxBitmapFont;
import pxBitmapFont.PxTextAlign;
import pxBitmapFont.PxTextField;

/**
 * ...
 * @author oggyiu
 */

class UIDialogBox 
{
	public function new( parentContext : Sprite, fntFile : String, pngFile : String ) 
	{
		var textBytes = Assets.getText( fntFile );
		var XMLData = Xml.parse(textBytes);
		var font2:PxBitmapFont = new PxBitmapFont().loadAngelCode(Assets.getBitmapData("assets/fonts/kanji.png"), XMLData);
		// var font2:PxBitmapFont = new PxBitmapFont().loadPixelizer(Assets.getBitmapData("assets/fonts/kanji.png"), "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?,.:;\"'$%&()-+=/");

		var tf : PxTextField = new PxTextField(font2);
		tf.text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?,.:;\"'$%&()-+=/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?,.:;\"'$%&()-+=/\nabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?,.:;\"'$%&()-+=/";
		tf.color = 0x000000;
		// tf.background = true;
		// tf.background = false;
		tf.fixedWidth = false;
		tf.multiLine = true;
		tf.backgroundColor = 0xffffff;
		// tf.shadow = true;
		tf.shadow = false;
		//tf.setWidth(100);
		tf.alignment = PxTextAlign.LEFT;
		tf.lineSpacing = 5;
		tf.fontScale = 4.0;
		tf.padding = 0;
		tf.scaleX = tf.scaleY = 1;
		//tf.setAlpha(0.5);
		 
		parentContext.addChild( tf );
	}
	
}