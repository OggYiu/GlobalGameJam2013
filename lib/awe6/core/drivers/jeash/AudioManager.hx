/*
 *                        _____ 
 *     _____      _____  / ___/
 *    /__   | /| /   _ \/ __ \ 
 *   / _  / |/ |/ /  __  /_/ / 
 *   \___/|__/|__/\___/\____/  
 *    awe6 is game, inverted
 * 
 * Copyright (c) 2010, Robert Fell, awe6.org
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

package awe6.core.drivers.jeash;
import awe6.core.drivers.AAudioManager;
import awe6.interfaces.EAudioChannel;
import awe6.interfaces.IKernel;
import jeash.events.Event;
import jeash.media.Sound;
import jeash.media.SoundChannel;
import jeash.media.SoundTransform;

/**
 * This AudioManager class provides jeash target overrides.
 * @author	Robert Fell
 */
class AudioManager extends AAudioManager
{

	override private function _driverSoundFactory( p_id:String, ?p_audioChannelType:EAudioChannel, ?p_loops:Int = 1, ?p_startTime:Int = 0, ?p_volume:Float = 1, ?p_pan:Float = 0, ?p_onCompleteCallback:Void->Void ):_AHelperSound
	{
		return new _HelperSound( _kernel, p_id, _packageId, p_audioChannelType, p_loops, p_startTime, p_volume, p_pan, p_onCompleteCallback );
	}

	override private function _driverSetIsMute( ?p_value:Bool ):Void
	{
		for ( i in _sounds )
		{
			if ( untyped i._soundChannel == null )
			{
				continue;
			}
			if ( untyped i._soundChannel.jeashAudio == null )
			{
				continue;
			}
			untyped i._soundChannel.jeashAudio.muted = p_value;
		}
	}	
	
}

class _HelperSound extends _AHelperSound
{
	private var _sound:Sound;
	private var _soundChannel:SoundChannel;
	
	public function new( p_kernel:IKernel, p_id:String, p_packageId:String, ?p_audioChannelType:EAudioChannel, ?p_loops:Int = 1, ?p_startTime:Int = 0, ?p_volume:Float = 1, ?p_pan:Float = 0, ?p_onCompleteCallback:Void->Void )
	{
		// needed else some float signatures misinterpreted as ints ... should replicate and report to mailing list
		super( p_kernel, p_id, p_packageId, p_audioChannelType, p_loops, p_startTime, p_volume, p_pan, p_onCompleteCallback );	
	}
	
	override private function _driverInit():Void
	{
		_sound = _kernel.assets.getAsset( id, _packageId );
		if ( _sound == null )
		{
			return dispose();
		}
		_soundChannel = _sound.play( _startTime, _loops );
		if ( _soundChannel == null )
		{
			return dispose(); // perhaps sounds are flooded?
		}
		untyped _soundChannel.jeashAudio.muted = _kernel.audio.isMute;
		_soundChannel.addEventListener( Event.SOUND_COMPLETE, _onSoundComplete );
		_driverTransform();
		return;
	}
	
	override private function _driverTransform( ?p_asRelative:Bool = false ):Void
	{
		if ( _soundChannel == null )
		{
			return;
		}
		if ( p_asRelative )
		{
			_volume *= _soundChannel.soundTransform.volume;
			_pan *= _soundChannel.soundTransform.pan;
		}
		var soundTransform:SoundTransform = new SoundTransform( _volume, _pan );
		_soundChannel.soundTransform = soundTransform;
		untyped _soundChannel.jeashAudio.volume = _volume;
	}

	override private function _driverStop():Void
	{
		if ( _soundChannel == null )
		{
			return;
		}
		_soundChannel.stop();
	}
	
	private function _onSoundComplete( p_event:Event ):Void
	{
		if ( _onCompleteCallback != null )
		{
			Reflect.callMethod( this, _onCompleteCallback, [] );
		}
		dispose();
	}
	
	override private function _driverDisposer():Void
	{
		if ( _soundChannel != null )
		{
			stop();
			_soundChannel.removeEventListener( Event.SOUND_COMPLETE, _onSoundComplete );
		}
	}
}