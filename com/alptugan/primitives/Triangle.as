//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.primitives
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Triangle extends Sprite
	{
		private var Tri : Sprite;
		
		private var color : uint;
		
		private var h : int;
		
		private var str : String;
		
		private var w : int;
		
		public function Triangle( _str : String = "left",
			_w : Number = 4,
			_h : Number = 6,
			_color : uint = 0xffffff )
		{
			w = _w;
			h = _h;
			str = _str;
			color = _color;
			addEventListener( Event.ADDED_TO_STAGE,init );
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,init );
			switch ( str )
			{
				case "left":
					DrawTriangleLeft();
					break;
				
				case "right":
					DrawTriangleRight();
					break;
				
				case "up":
					DrawTriangleUp();
					break;
				
				case "down":
					DrawTriangleDown();
					break;
			}
		}
		
		private function DrawTriangleRight() : void
		{
			Tri = new Sprite();
			Tri.graphics.beginFill( color );
			Tri.graphics.moveTo( 0,0 );
			Tri.graphics.lineTo( w,h >> 1 );
			Tri.graphics.lineTo( 0,h );
			Tri.graphics.lineTo( 0,0 );
			Tri.graphics.endFill();
			addChild( Tri );
		}
		
		private function DrawTriangleLeft() : void
		{
			Tri = new Sprite();
			Tri.graphics.beginFill( color );
			Tri.graphics.moveTo( 0,h >> 1 );
			Tri.graphics.lineTo( w,0 );
			Tri.graphics.lineTo( w,h );
			Tri.graphics.lineTo( 0,h >> 1 );
			Tri.graphics.endFill();
			addChild( Tri );
		
		}
		
		private function DrawTriangleDown() : void
		{
			Tri = new Sprite();
			Tri.graphics.beginFill( color );
			Tri.graphics.moveTo( 0,0 );
			Tri.graphics.lineTo( w,0 );
			Tri.graphics.lineTo( w >> 1,h );
			Tri.graphics.lineTo( 0,0 );
			Tri.graphics.endFill();
			addChild( Tri );
		
		}
		
		private function DrawTriangleUp() : void
		{
			Tri = new Sprite();
			Tri.graphics.beginFill( color );
			Tri.graphics.moveTo( w >> 1,0 );
			Tri.graphics.lineTo( w,h );
			Tri.graphics.lineTo( 0,h );
			Tri.graphics.lineTo( w >> 1,0 );
			Tri.graphics.endFill();
			addChild( Tri );
		
		}
		
		private function EqualSide() : void
		{
			Tri = new Sprite();
			Tri.graphics.beginFill( color );
			Tri.graphics.moveTo( h >> 1,0 );
			Tri.graphics.lineTo( h,h );
			Tri.graphics.lineTo( 0,h );
			Tri.graphics.lineTo( h >> 1,0 );
			Tri.graphics.endFill();
			addChild( Tri );
		}
	}
}
