/**
 * Label.as
 * Keith Peters
 * version 0.97
 * 
 * A Label component for displaying a single line of text.
 * 
 * Copyright (c) 2009 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package minimalcomps;

import nme.Assets;
import nme.display.DisplayObjectContainer;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;

// import flash.display.DisplayObjectContainer;
// import flash.text.TextField;
// import flash.text.TextFieldAutoSize;
// import flash.text.TextFormat;

class Label extends Component {
	
	public var autoSize(getAutoSize, setAutoSize) : Bool;
	public var text(getText, setText) : String;
	var _autoSize:Bool;
	var _text:String;
	var _tf:TextField;
	var _size:Int;
	var _color:Int;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this Label.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param text The string to use as the initial text in this component.
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?text:String = "", size:Int = 8, color:Int = 0x000000) {
		_autoSize = true;
		_text = text;
		_size = size;
		_color = color;
		super(parent, xpos, ypos);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		mouseEnabled = false;
		mouseChildren = false;
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_height = 18;

		_tf = new TextField();
		_tf.height = _height;
		_tf.embedFonts = true;
		_tf.selectable = false;
		_tf.mouseEnabled = false;

		var font = Assets.getFont ("assets/fonts/pf_ronda_seven.ttf");
		// var font = Assets.getFont ("assets/fonts/kongtext.ttf");
		var format = new TextFormat (font.fontName, _size, _color);
		_tf.defaultTextFormat = format;

		// _tf.defaultTextFormat = new TextFormat("PFRondaSeven", 8, Style.LABEL_TEXT);
		_tf.text = _text;			
		addChild(_tf);
		draw();
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		_tf.text = _text;
		if(_autoSize) {
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_width = Std.int( _tf.width );
		} else {
			_tf.autoSize = TextFieldAutoSize.NONE;
			_tf.width = _width;
		}
	}
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets the text of this Label.
	 */
	public function setText(t:String):String {
		_text = t;
		invalidate();
		return t;
	}
	public function getText():String {
		return _text;
	}
	
	/**
	 * Gets / sets whether or not this Label will autosize.
	 */
	public function setAutoSize(b:Bool):Bool {
		_autoSize = b;
		return b;
	}
	public function getAutoSize():Bool {
		return _autoSize;
	}
}
