//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Drawing.Navigation
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class PixelUpBtn1 extends Sprite
	{
		private var Cl : uint;
		
		private var UpBtn : Shape;
		
		public function PixelUpBtn1( Color : uint = 0x787777 )
		{
			this.Cl = Color;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			UpBtn = new Shape();
			with ( UpBtn.graphics )
			{
				beginFill( Cl,0 );
				drawRect( -3,-3,15,15 );
				beginFill( Cl );
				drawRect( 0,3,1,2 );
				drawRect( 1,2,1,2 );
				drawRect( 2,1,1,2 );
				drawRect( 3,0,1,2 );
				drawRect( 4,1,1,2 );
				drawRect( 5,2,1,2 );
				drawRect( 6,3,1,2 );
				endFill();
			}
			
			addChild( UpBtn );
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onRemoved( e : Event ) : void
		{
			removeEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function addEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.addEventListener( type,listener,false,0,true );
		}
		
		private function removeEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.removeEventListener( type,listener );
		}
	}
}
