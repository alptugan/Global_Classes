//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.preloader
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.alptugan.text.ABasicTextField;
	
	public class PreloaderUranium extends Sprite
	{
		public var tex : ABasicTextField;
		
		private var Mask : Shape;
		
		private var T : Timer;
		
		private var Ur : Shape;
		
		private var r : Number,c : uint,cCircle : uint;
		
		public function PreloaderUranium( c : uint,cCircle : uint,r : Number )
		{
			this.c = c;
			this.r = r;
			this.cCircle = cCircle;
			addEvent( this,Event.ADDED_TO_STAGE,onAdded );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		public function ShowTitle( str : String = "LOADING",pos : String = "center",bgFill : Boolean = true ) : void
		{
			tex = new ABasicTextField( c,cCircle,bgFill );
			addChild( tex );
			
			tex.Tf.htmlText = str;
			
			switch ( pos )
			{
				case "center":
					tex.y = r;
					tex.x = -tex.width >> 1;
					break;
				
				case "right":
					tex.x = r - 10;
					tex.y = -( r >> 1 ) + 2;
					break;
			}
		
		}
		
		private function onAdded( e : Event ) : void
		{
			Ur = new Shape();
			with ( Ur.graphics )
			{
				beginFill( cCircle );
				drawCircle( 0,0,r >> 1 );
				beginFill( c );
				drawRect( 0,-r >> 1,r >> 1,r >> 1 );
				drawRect( -r >> 1,0,r >> 1,r >> 1 );
				endFill();
			}
			addChild( Ur );
			Mask = new Shape();
			with ( Mask.graphics )
			{
				beginFill( cCircle );
				drawCircle( 0,0,r >> 1 );
				endFill();
			}
			addChild( Mask );
			Ur.mask = Mask;
			
			T = new Timer( 1 );
			addEvent( T,TimerEvent.TIMER,SpinTheShape );
			T.start();
			
			removeEvent( this,Event.ADDED_TO_STAGE,onAdded );
		
		}
		
		private function SpinTheShape( e : TimerEvent ) : void
		{
			var rot : Number = 4;
			Ur.rotation += rot;
		}
		
		private function onRemoved( e : Event ) : void
		{
			T.stop();
			Ur = null;
			Mask = null;
			removeEvent( T,TimerEvent.TIMER,SpinTheShape );
			removeEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function addEvent( _arg1 : EventDispatcher,_arg2 : String,_arg3 : Function ) : void
		{
			_arg1.addEventListener( _arg2,_arg3,false,0,true );
		}
		
		private function removeEvent( _arg1 : EventDispatcher,_arg2 : String,_arg3 : Function ) : void
		{
			_arg1.removeEventListener( _arg2,_arg3 );
		}
	}
}
