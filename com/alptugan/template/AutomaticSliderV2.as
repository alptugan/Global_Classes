//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Template
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import aze.motion.easing.Expo;
	import aze.motion.eaze;
	
	public class AutomaticSliderV2 extends Sprite
	{
		public var _Obj : Array;
		
		public var _delay : Number;
		
		public var _fadeInTime : Number;
		
		public var _fadeOutTime : Number;
		
		public var timer : Timer;
		
		private var SlideTimer : Timer;
		
		private var _fadingVal : Number;
		
		private var i : int = -1;
		
		public function AutomaticSliderV2() : void
		{
		
		}
		
		public function Loop( Obj : Array,fadingVal : Number = 1,delay : Number = 0,fadeInTime : Number = 0.5,fadeOutTime : Number = 3 ) : void
		{
			_fadeInTime = fadeInTime;
			_delay = delay * 1000;
			_Obj = Obj;
			_fadeOutTime = fadeOutTime;
			_fadingVal = fadingVal * 1000;
			
			timer = new Timer( _delay,1 );
			timer.addEventListener( "timer",StartFading );
			timer.start();
		}
		
		private function StartFading( e : Event ) : void
		{
			timer.stop();
			timer.removeEventListener( "timer",StartFading );
			SlideTimer = new Timer( _fadingVal );
			SlideTimer.addEventListener( "timer",move );
			SlideTimer.start();
		}
		
		private function move( e : Event ) : void
		{
			i < _Obj.length - 1 ? i++ : i = 0;
			
			//timer.stop();
			eaze( _Obj[ i ]).to( _fadeInTime,{ alpha: 1 }).easing( Expo.easeOut ).onComplete( RemoveObj,i );
		}
		
		private function RemoveObj( _i : int ) : void
		{
			//timer.start();
			eaze( _Obj[ _i ]).to( _fadeOutTime,{ alpha: 0 }).easing( Expo.easeOut );
		}
	}
}
