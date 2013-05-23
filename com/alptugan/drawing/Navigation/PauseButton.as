//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing.Navigation
{
	import com.alptugan.primitives.Triangle;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class PauseButton extends Sprite
	{
		public var bar : Shape;
		private var bound : Sprite;
		private var boundry:Boolean;
		
		private var w : int,h : int,c : uint,bW:Number,bH:Number;
		
		public function PauseButton( w : int,h : int,c : uint,X : int = 0,Y : int = 0,boundry:Boolean = false,bW:Number=0,bH:Number=0 )
		{
			super();
			this.w = w;
			this.h = h;
			this.c = c;
			this.x = X;
			this.y = Y;
			
			this.boundry = boundry;
			this.bW = bW;
			this.bH = bH;
			
			this.name = "pause";
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			this.mouseChildren = false;
			this.buttonMode = true;
			
			bar = new Shape();
			with ( bar.graphics )
			{
				beginFill( c,1 );
				drawRect( 0,0,w >> 2,h );
				beginFill( c,0 );
				drawRect(( w >> 2 ),0,w >> 2,h );
				beginFill( c,1 );
				drawRect(( w >> 2 ) * 2,0,w >> 2,h );
				endFill();
			}
			
			if(boundry)
			{
				bound = new Sprite();
				with ( bound.graphics )
				{
					beginFill( c,0 );
					drawRect( 0,0,bW,bH );
					endFill();
				}
				addChild( bound );
				bound.addChild(bar);
				
				bar.x = (bW-w)*0.5;
				bar.y = (bH-h)*0.5;
			}else{
				addChild( bar );
			}
			
			
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onRemoved( e : Event ) : void
		{
			bar.graphics.clear();
			
			
			if (boundry) 
			{
				bound.removeChild( bar );
				bar = null;
				removeChild(bound);
				bound = null;
			}else{
				removeChild( bar );
				bar = null;
			}
			
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
