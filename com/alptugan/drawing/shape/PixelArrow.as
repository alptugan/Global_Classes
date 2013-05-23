//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing.shape
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.casalib.display.CasaSprite;
	
	public class PixelArrow extends CasaSprite
	{
		private var c : uint;
		private var bg: Object;
		private var ok:Shape = new Shape();
		private var box:Shape;
		private var direction:String;
		private var size:int;
		
		public function PixelArrow( size:int=1, c : uint = 0xffffff,direction:String = "right", bg:Object = null )
		{
			this.c = c;
			this.direction = direction;
			this.name = direction;
			this.buttonMode = true;
			this.size = size;
			bg != null ? this.bg = bg : void;
			addEventListener(Event.ADDED_TO_STAGE,init );
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init );
			
			if(bg)
			{
				box  = new Shape();
				with ( box.graphics )
				{
					beginFill( bg.color,1 );
					drawRect( 0,0,bg.size,bg.size );
					endFill();
				}
				addChild(box);
			}
			
			with ( ok.graphics )
			{
				beginFill( c,1 );
				switch(direction)
				{
					case "down":
						drawRect( 0,0,1,1 );
						drawRect( 1,1,1,1 );
						drawRect( 2,2,1,1 );
						drawRect( 3,1,1,1 );
						drawRect( 4,0,1,1 );
						break;
					
					
					case "up":
						drawRect( 2,0,1,1 );
						drawRect( 1,1,1,1 );
						drawRect( 0,2,1,1 );
						drawRect( 3,1,1,1 );
						drawRect( 4,2,1,1 );
						break;
					
					case "right":
						drawRect( 0,0,size,size );
						drawRect( size,size,size,size );
						drawRect( size*2,size*2,size,size );
						drawRect( size,size*3,size,size );
						drawRect( 0,size*4,size,size );
						/*drawRect( 0,0,1,1 );
						drawRect( 1,1,1,1 );
						drawRect( 2,2,1,1 );
						drawRect( 1,3,1,1 );
						drawRect( 0,4,1,1 );*/
						break;
					
					case "left":
						drawRect( 0,2,1,1 );
						drawRect( 1,1,1,1 );
						drawRect( 2,0,1,1 );
						drawRect( 1,3,1,1 );
						drawRect( 2,4,1,1 );
						break;
				}
				
				endFill();
			}
			addChild(ok);
			
			
			if(box)
			{
				ok.x = (box.width - ok.width) >> 1;
				ok.y = (box.height - ok.height) >> 1;
			}
			
		}
		
		private function onRemoved( e : Event ) : void
		{
			this.graphics.clear();
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved );
		}
	}
}
