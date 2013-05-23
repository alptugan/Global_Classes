//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.display
{
	import flash.display.Shape;
	
	public class CreateMask
	{
		public static var maske : Shape;
		
		public static function Create( _x : Number,_y : Number,_w : Number,_h : Number ) : Shape
		{
			maske = new Shape();
			maske.graphics.beginFill( 0xff0000,0.6 );
			maske.graphics.drawRect( 0,0,_w,_h );
			maske.graphics.endFill();
			maske.x = _x;
			maske.y = _y;
			return maske;
		}
		
		public static function CreateRound( _x : Number,_y : Number,_r : Number ) : Shape
		{
			maske = new Shape();
			maske.graphics.beginFill( 0x000000,0.6 );
			maske.graphics.drawCircle( _x,_y,_r );
			maske.graphics.endFill();
			maske.x = _x;
			maske.y = _y;
			return maske;
		}
		
		public static function update( _x : int,_y : int,_w : int,_h : int ) : void
		{
			maske.graphics.clear();
			maske.graphics.beginFill( 0x000000,0.6 );
			maske.graphics.drawRect( 0,0,_w,_h );
			maske.graphics.endFill();
			maske.x = _x;
			maske.y = _y;
		}
	}
}
