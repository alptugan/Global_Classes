//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Primitives
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 *
	 * @author Alp Tugan // blog.alptugan.com // www.alptugan.com
	 */
	public class Cross extends Sprite
	{
		/**
		 *
		 * @default
		 */
		public var bdCross : Shape;
		
		/**
		 *
		 * @default
		 */
		public var bmd : BitmapData;
		
		private var Alpha : Number;
		
		private var Color : uint;
		
		private var Gap : int;
		
		private var Length : int;
		
		private var Thickness : int;
		
		/**
		 *
		 * @param _Thickness
		 * @param _Length
		 * @param _Gap
		 * @param _Color
		 * @param _Alpha
		 */
		public function Cross( _Thickness : int = 1,_Length : int = 11,_Gap : int = 20,_Color : uint = 0x000000,_Alpha : Number = 1 )
		{
			Length = _Length;
			Thickness = _Thickness;
			Color = _Color;
			Alpha = _Alpha;
			Gap = _Gap + Length;
			
			addEventListener( Event.ADDED_TO_STAGE,init );
			addEventListener( Event.REMOVED_FROM_STAGE,Destroy );
		}
		
		/**
		 *
		 * @param pWidth
		 * @param pHeight
		 */
		public function setBitmapTile( pWidth : Number = 0,pHeight : Number = 0 ) : void
		{
			with ( graphics )
			{
				clear();
				beginBitmapFill( bmd );
				moveTo( 0,0 );
				lineTo( pWidth,0 );
				lineTo( pWidth,pHeight );
				lineTo( 0,pHeight );
				lineTo( 0,0 );
				endFill();
			}
		
		}
		
		/**
		 *
		 * @param pWidth
		 * @param pHeight
		 */
		public function setSize( pWidth : Number,pHeight : Number ) : void
		{
			setBitmapTile( pWidth,pHeight );
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,init );
			bdCross = new Shape();
			
			with ( bdCross )
			{
				
				//graphics.lineStyle( Thickness,Color,Alpha,true );
				graphics.beginFill( Color,Alpha );
				graphics.drawRect( 0,( Length - Thickness ) >> 1,Length,Thickness );
				graphics.endFill();
				graphics.beginFill( Color,Alpha );
				graphics.drawRect(( Length - Thickness ) >> 1,0,Thickness,Length );
				graphics.endFill();
			}
			
			addChild( bdCross );
			bmd = new BitmapData( Gap,Gap );
			bmd.draw( bdCross );
		
		}
		
		private function Destroy( e : Event ) : void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE,Destroy );
		}
	}
}
