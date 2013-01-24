package firerice.log;

import nme.display.Sprite;
#if flash
import flash.events.Event;
import flash.events.StatusEvent;
import flash.events.MouseEvent;
import flash.errors.ArgumentError;
import flash.net.LocalConnection;

// import flash.display.Sprite;
import nme.text.TextField;
import nme.Lib;
import nme.display.StageAlign;
import nme.display.StageScaleMode;

import minimalcomps.PushButton;
import minimalcomps.Label;
import minimalcomps.Text;
import minimalcomps.InputText;
import minimalcomps.Panel;
import minimalcomps.VSlider;
import minimalcomps.Style;

/**
 * @version 4.1.0
 * @author saumya
 */

class RayTrace extends Sprite {
	// commands
	public static var COMMAND_CLEAR : String = "rayTraceCommand:clear";

	public static var CONNECTION_NAME : String = "_RayTrace_V4.1.0_";

	private var lc:LocalConnection;
	//
	private var logNumber:Int;
	private var logMessage:String;
	//
	private var t:TextField;
	private var connectionNameText:InputText;
	private var isInAdvancedMode:Bool;
	private var channelInfo:Label;
	//
	private var shouldScroll:Bool;
	//
	private var p:Panel;
	private var vs:VSlider;
	
	public function new() 
	{
		super();
		this.init();
		onStart( null );
	}
	public function init():Void
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		// Style.setStyle(Style.LIGHT);

		var container:Sprite = new Sprite();
		addChild(container);
		container.scaleX = container.scaleY = 1.0;
		this.p=new Panel(this, 0, 0);
		p.setSize(640,400);
		p.setColor(0xAAAAAA);
		this.vs=new VSlider(this.p, 630, 0,onUserSlide);
		this.vs.setSize(15,400);
		this.vs.setSliderParams(0,590,590);
		var clearBtn:PushButton=new PushButton(this,0,410,'clear',onClear);
		clearBtn.setSize(50,20);
		//chanel info
		this.channelInfo=new Label(this,70,415,'Connection name : ' + CONNECTION_NAME );
		//
		// clearBtn.addEventListener(MouseEvent.CLICK, onClear);
		//test button
		var testBtn:PushButton=new PushButton(this,645,0,'test');
		testBtn.setSize(40,20);
		testBtn.visible=false;//test button
		testBtn.addEventListener(MouseEvent.CLICK, onTest);
		//
		this.logNumber = 0;
		this.logMessage = '';
		//

    	this.t = new TextField();
		// this.t=new TextField(this,10,10,'Hello Text');
		//this.t=new Text(p,50,50,'Hello Text');
		this.t.x = 20;
		this.t.y = 20;
    	this.t.width = 610;
    	this.t.height = 380;
		// this.t.setSize(610,380);
		this.t.text='RayTrace V4.1.0';
		this.addChild ( this.t );
		//
		var btnStart:PushButton=new PushButton(this,555,415,'Start');
		var btnStop:PushButton=new PushButton(this,600,415,'Stop');
		btnStart.setSize(40,20);
		btnStop.setSize(40,20);
		//
		btnStart.addEventListener(MouseEvent.CLICK, onStart);
		btnStop.addEventListener(MouseEvent.CLICK, onStop);
		//
		var btnAdvancedSettings:PushButton=new PushButton(this,250,415,'Advanced');
		btnAdvancedSettings.setSize(50,20);
		btnAdvancedSettings.addEventListener(MouseEvent.CLICK, onAdvancedSetting);
		this.connectionNameText=new InputText(this,310,415,CONNECTION_NAME);
		this.connectionNameText.setSize(200,20);
		this.connectionNameText.visible=false;
		this.isInAdvancedMode=false;
		//
		this.lc = new LocalConnection();
		this.lc.allowDomain('*');
		this.lc.client = this;
		//this.lc.addEventListener(flash.events.StatusEvent.STATUS, onStatusUpdate);
		/*
		//connect
		this.lc = new LocalConnection();
		this.lc.client = this;
		//this.lc.send('_RayTrace_V1.0.0_', 'log', message);
		this.lc.connect('_RayTrace_V2.0.0_');
		//
		//this.lc.send('_RayTrace_V1.0.0_','log','hello');
		*/
	}
	
	private function onStatusUpdate(e:StatusEvent):Void 
	{
		this.log('status: level='+ e.level);
	}
	
	private function onAdvancedSetting(e:MouseEvent):Void
	{
		this.isInAdvancedMode=(! this.isInAdvancedMode);
		this.connectionNameText.visible=(! this.connectionNameText.visible);
		this.channelInfo.visible=(! this.channelInfo.visible);
	}
	
	private function onStop(e:MouseEvent):Void 
	{
		this.lc.close();
		this.log('Logger Stopped.');
	}
	
	private function onStart(e:MouseEvent):Void 
	{
		//connect
		//this.lc = new LocalConnection();
		//this.lc.client = this;
		var connectionName:String='';
		if(this.isInAdvancedMode==true)
		{
			connectionName=this.connectionNameText.text;
		}else{
			connectionName=CONNECTION_NAME;
		}
		//this.lc.connect(connectionName);
		try{
			this.lc.connect(connectionName);
			this.log(connectionName);
			this.log('Logger Started.');
		}catch(e:ArgumentError)
		{
			this.log(e.toString());
			this.log('Already Running ! What you want to do ?!');
		}
	}
	
	private function onTest(e:MouseEvent):Void 
	{
		//this.log('hello : max scroll='+this.t.maxScrollV);
		this.log('onTest : checking');
	}
	
	private function onClear(e:MouseEvent):Void 
	{
		this.logNumber = 0;
		this.logMessage = CONNECTION_NAME;
		this.t.text = this.logMessage;
	}
	private function onUserSlide(e:Event):Void{
		//this.log(this.vs.getValue()+'');
		// var tf:TextField=this.t.getTextField();
		var tf:TextField=this.t;
		var min:Int=0;
		var max:Int=tf.maxScrollV;
		var percent:Float=(max/400)*(this.vs.getValue());
		var n:Int=Math.round(percent);
		tf.scrollV=n;
	}
	
	public function log ( v : Dynamic, ?inf : haxe.PosInfos ) : Void {
		var msgReceived : String = v.toString();
		if( msgReceived.toLowerCase() == RayTrace.COMMAND_CLEAR.toLowerCase() ) {
			this.t.text = "";
		} else {
			var s:String = this.t.text;
			var message:String = this.logNumber + ": " + inf.fileName + " " + inf.methodName + "()" + " line: " + inf.lineNumber + " " + v.toString();
			this.logNumber++;
			//this.logMessage = message + '\n' + this.logNumber + ' : ' + s;
			this.t.text = s + '\n' + message;
			/*
			var tf:TextField=this.t.getTextField();
			this.vs.setValue(tf.maxScrollV);
			 */
			 //TODO: Fix the scroll position
		}
	}
}

#else
class RayTrace  extends Sprite {
	public function new() {
		super();
	}
}
#end