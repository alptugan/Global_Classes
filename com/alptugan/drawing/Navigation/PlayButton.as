//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing.Navigation
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.alptugan.primitives.Triangle;
	
	public class PlayButton extends Sprite
	{
		private var TriR : Triangle;
		
		private var w : int,h : int,c : uint;
		private var boundry:Boolean;
		private var bound:Sprite;
		private var bW:Number;
		private var bH:Number;
		
		public function PlayButton( w : int,h : int,c : uint,X : int = 0,Y : int = 0 ,boundry:Boolean = false,bW:Number=0,bH:Number=0 )
		{
			super();
			this.w = w;
			this.h = h;
			this.c = c;
			this.x = X;
			this.y = Y;
			this.name = "play";
			
			this.boundry = boundry;
			this.bW = bW;
			this.bH = bH;
			
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			this.mouseChildren = false;
			this.buttonMode = true;
			TriR = new Triangle( "right",this.w,this.h,this.c );
			
			
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
				bound.addChild( TriR );
				
				TriR.x = (bW-w)*0.5;
				TriR.y = (bH-h)*0.5;
			}else{
				addChild( TriR );
			}
			
			
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onRemoved( e : Event ) : void
		{
			TriR.graphics.clear();
			
			
			if (boundry) 
			{
				bound.removeChild( TriR );
				TriR = null;
				
				removeChild(bound);
				bound = null;
			}else{
				removeChild( TriR );
				TriR = null;
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
