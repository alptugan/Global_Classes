//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing.Navigation
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class TrackerBarButton extends Sprite
	{
		private var HolderRect : Shape;
		
		private var Rect : Shape;
		
		private var w : int,h : int,ew : int,eh : int,c : uint;
		
		public function TrackerBarButton( w : int,h : int,ew : int,eh : int,c : uint,X : int = 0,Y : int = 0,name : String = "" )
		{
			super();
			this.w = w;
			this.h = h;
			this.c = c;
			this.x = X;
			this.y = Y;
			this.ew = ew;
			this.eh = eh;
			this.name = name;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			this.mouseChildren = false;
			this.buttonMode = true;
			if ( h < 6 )
			{
				HolderRect = new Shape();
				with ( HolderRect.graphics )
				{
					beginFill( this.c,0 );
					drawRoundRect( 0,0,this.w,6,this.ew,this.eh );
					endFill();
				}
				addChild( HolderRect );
					//this.y = this.y - (HolderRect.height >> 1);
			}
			
			Rect = new Shape();
			with ( Rect.graphics )
			{
				beginFill( this.c );
				drawRoundRect( 0,0,this.w,this.h,this.ew,this.eh );
				endFill();
			}
			addChild( Rect );
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onRemoved( e : Event ) : void
		{
			if ( HolderRect )
			{
				HolderRect.graphics.clear();
				removeChild( HolderRect );
				HolderRect = null;
			}
			
			Rect.graphics.clear();
			removeChild( Rect );
			Rect = null;
			
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
