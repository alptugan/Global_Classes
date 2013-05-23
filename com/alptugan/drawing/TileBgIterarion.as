//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Drawing
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	
	public class TileBgIterarion extends Shape
	{
		private var bmd : BitmapData;
		
		private var mt : Matrix;
		
		public function TileBgIterarion( bmd : BitmapData,pWidth : int,pHeight : int,objH : int,objW : int,wIt : int = 0,hIt : int = 0 )
		{
			this.bmd = bmd;
			setBitmapTile( pWidth,pHeight,objH,objW,wIt,hIt );
		}
		
		public function setBitmapTile( pWidth : int,pHeight : int,objH : int,objW : int,wIt : int = 0,hIt : int = 0 ) : void
		{
			
			for ( var i : int = 0;i < Math.ceil( pHeight / objH ) + 1;i++ )
			{
				with ( graphics )
				{
					mt = new Matrix( 1,0,0,1,i * ( wIt ),hIt );
					beginBitmapFill( bmd,mt );
					moveTo( -i * ( objW * 0.5 ),objH * i );
					lineTo( pWidth,objH * i );
					lineTo( pWidth,objH * ( i + 1 ));
					lineTo( -i * ( objW * 0.5 ),objH * ( i + 1 ));
					lineTo( -i * ( objW * 0.5 ),objH * i );
					endFill();
				}
			}
		
		/*with (graphics)
		{
			mt = new Matrix(1,0,0,1,0,0);
			beginBitmapFill(bmd,mt);
			moveTo(0, 0);
			lineTo(pWidth, 0);
			lineTo(pWidth, objH);
			lineTo(0, objH);
			lineTo(0, 0);
			endFill();
		}
		
		with (graphics)
		{
			mt = new Matrix(1,0,0,1,40,0);
			beginBitmapFill(bmd,mt);
			moveTo(-40, objH);
			lineTo(pWidth, objH);
			lineTo(pWidth, objH*2);
			lineTo(-40, objH*2);
			lineTo(-40, objH);
			endFill();
		}*/
		
		}
		
		public function setSize( pWidth : int,pHeight : int,objH : int,objW : int,wIt : int = 0,hIt : int = 0 ) : void
		{
			setBitmapTile( pWidth,pHeight,objH,objW,wIt,hIt );
		}
	}
}
