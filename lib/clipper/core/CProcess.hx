package clipper.core;

import awe6.interfaces.EMessage;
import awe6.interfaces.IEntity;
import awe6.interfaces.IKernel;
import awe6.interfaces.IProcess;
import awe6.interfaces.ITools;

class CProcess {
	public var isActive( default, _set_isActive ):Bool;
	public var isDisposed( default, null ):Bool;
	
	private var _updates:Int;

	public function new() {
		_init();
	}
	
	private function _init():Void
	{
		isActive = true;
		isDisposed = false;
	}
	
	public inline function dispose():Void
	{
		if ( isDisposed )
		{
			return;
		}
		else
		{
			isDisposed = true;
			isActive = false;
			_disposer();
			return;
		}
	}
	
	public inline function update( ?p_deltaTime:Int = 0 ):Void
	{
		if ( !isActive || isDisposed )
		{
			return;
		}
		else
		{
			_updater( p_deltaTime );
			return;
		}
	}
	
	private function _disposer():Void {
		// override me
	}

	private function _updater( ?p_deltaTime:Int = 0 ):Void
	{
		// override me
	}
	
	private function _set_isActive( p_value:Bool ):Bool
	{
		if ( isDisposed )
		{
			isActive = false;
			return false;
		}
		return isActive;
	}
	
}
