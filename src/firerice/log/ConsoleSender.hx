package firerice.log;

#if flash
import flash.net.LocalConnection;
import flash.events.Event;
import flash.events.StatusEvent;

import haxe.Log;

import firerice.log.RayTrace;

class ConsoleSender {
  var console_connection_ : LocalConnection;
  var backup_trace_func_ : Dynamic = null;
  
  public function new () {
    console_connection_ = new LocalConnection();
    console_connection_.addEventListener( StatusEvent.STATUS, onStatusEventHandler );
    backup_trace_func_ = haxe.Log.trace;
    haxe.Log.trace = sendToConsole;
  }

  function sendToConsole ( v : Dynamic, ?inf : haxe.PosInfos ) {
    console_connection_.send ( RayTrace.CONNECTION_NAME, "log", v, inf );
  }

  function onStatusEventHandler( evt : StatusEvent ) : Void {
    haxe.Log.trace = backup_trace_func_;
  }
}

#else
class ConsoleSender {
  public function new () {
  }
}
#end