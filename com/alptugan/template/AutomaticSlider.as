//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Template
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import aze.motion.easing.Expo;
	import aze.motion.eaze;
	
	public class AutomaticSlider extends Sprite
	{
		public var _Obj : DisplayObject;
		
		public var _SingleHeight : Number;
		
		public var _delay : Number;
		
		public var _fadeInTime : Number;
		
		public var _fadeOutTime : Number;
		
		public var _movement : Number;
		
		public var timer : Timer;
		
		private var SlideTimer : Timer;
		
		private var _ObjArr : Array = new Array();
		
		private var _fadingVal : Number;
		
		private var _i : int        = -1;
		
		public function AutomaticSlider() : void
		{
		
		}
		
		public function Loop( Obj : DisplayObject,ObjArr : Array,movement : Number,fadingVal : Number = 1,delay : Number = 0,fadeInTime : Number = 0.5,fadeOutTime : Number = 3 ) : void
		{
			_fadeInTime = fadeInTime;
			_delay = delay * 1000;
			_Obj = Obj;
			_fadeOutTime = fadeOutTime;
			_fadingVal = fadingVal * 1000;
			_movement = movement;
			
			timer = new Timer( _delay,1 );
			timer.addEventListener( "timer",StartFading );
			timer.start();
			_ObjArr = ObjArr;
			//trace("obje" + _ObjArr.length);
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
			eaze( _Obj ).to( 0.5,{ y: _Obj.y - _movement })
				.easing( Expo.easeOut )
				//.onUpdate(CheckPos);
				.onComplete( RemoveItem );
		}
		
		private function RemoveItem() : void
		{
			_i < _ObjArr.length - 1 ? _i++ : _i = 0;
			
			//_ObjArr[_i].alpha = 0;
			_ObjArr[ _i ].y = ( _ObjArr[ _i ].y + 5 ) + _Obj.height;
		}
		
		private function CheckPos() : void
		{
			if ( _Obj.y < -_Obj.height + _SingleHeight - 8 )
				eaze( _Obj ).to( 0.5,{ y: 0 }).easing( Expo.easeOut );
		}
	}
}
