//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	
	import org.casalib.display.CasaShape;
	
	public class TileBackground extends CasaShape
	{
		private var bmd : BitmapData;
		private var pWidth:int;
		private var pHeight:int;
		
		public function TileBackground( bmd : BitmapData,pWidth : int,pHeight : int )
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded,false,0,true);
			this.bmd = bmd;
			this.pWidth = pWidth;
			this.pHeight = pHeight;

		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			setSize( pWidth,pHeight );
			
		}
		
		public function setBitmapTile( pWidth : int,pHeight : int ) : void
		{
			with ( this.graphics )
			{
				clear();
				beginBitmapFill( bmd);
				drawRect(0, 0, pWidth, pHeight);
				endFill();
				
			}
			
		}
		
		public function setSize( pW : int,pH : int ) : void
		{
			with ( this.graphics )
			{
				clear();
				beginBitmapFill( bmd);
				drawRect(0, 0, pW, pH);
				endFill();
				
			}
		}
	}
}
