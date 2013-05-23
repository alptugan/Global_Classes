//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing.CustomShapes
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class SoundIcon extends Sprite
	{
		private var Ico : Shape;
		
		private var c : uint;
		
		private var w : int = 2;
		
		public function SoundIcon( c : uint,X : int = 0,Y : int = 0,Name : String = "SoundIco" )
		{
			super();
			this.mouseChildren = false;
			this.buttonMode = true;
			this.x = X;
			this.y = Y;
			this.c = c;
			this.name = Name;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			removeEvent( this,Event.ADDED_TO_STAGE,init );
			Ico = new Shape();
			Ico.graphics.clear();
			with ( Ico.graphics )
			{
				
				beginFill( this.c );
				drawRect( 0,4,w,6 );
				drawRect( w + 1,3,1,8 );
				drawRect( w + 2,2,1,10 );
				drawRect( w + 3,1,1,12 );
				drawRect( w + 4,1,1,12 );
				endFill();
			}
			
			addChild( Ico );
		}
		
		private function onRemoved( e : Event ) : void
		{
			Ico.graphics.clear();
			removeChild( Ico );
			Ico = null;
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
