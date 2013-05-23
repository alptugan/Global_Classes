//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Drawing.CustomShapes
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class CircleMarker extends Sprite
	{
		private var Marker : Shape;
		
		private var c : uint;
		
		private var r : int;
		
		public function CircleMarker( r : int,c : uint )
		{
			this.r = r;
			this.c = c;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			Marker = new Shape();
			with ( Marker.graphics )
			{
				lineStyle( r * 0.2,c );
				drawCircle( 0,0,r );
				lineStyle( 0,0,0 );
				beginFill( c );
				drawCircle( 0,0,this.r * 0.7 );
				endFill();
				
			}
			
			addChild( Marker );
			this.cacheAsBitmap = true;
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onRemoved( e : Event ) : void
		{
			Marker.graphics.clear();
			removeChild( Marker );
			Marker = null;
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
