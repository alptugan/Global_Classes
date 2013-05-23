/***************************************************************************************************
 * Website: www.alptugan.com
 * Blog   : blog.alptugan.com
 * Email  : info@alptugan.com
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp
 * 
 * 07.08.2011
 ***************************************************************************************************/
package com.alptugan.utils
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	
	/*
	example usage: Lets say myObject is a Sprite and you want to see its actual regions..
	var myObject : Sprite = new Sprite();
	addChild(myObject);
	myObject.addChild(new Bounds(myObject));
  */
	public class Bounds extends Shape
	{
		
		private static var
			w : Number = 0,
			h : Number = 0;
		
		private var X : Number,
			Y : Number,
			obj : DisplayObject;
		
		public function Bounds( obj : DisplayObject,X : Number = 0,Y : Number = 0 )
		{
			this.obj = obj;
			this.X = X;
			this.Y = Y;
			addEventListener( Event.ADDED_TO_STAGE,onAdded,false,0,true );
		
		}
		
		private function onAdded( e : Event ) : void
		{
			update( w,h );
			if ( X != 0 && Y != 0 )
			{
				this.x = X;
				this.y = Y;
			}
			else
			{
				/*this.x = obj.x;
				this.y = obj.y;*/
			}
			
			w = obj.width;
			h = obj.height;
			update( w,h );
			removeEventListener( Event.ADDED_TO_STAGE,onAdded );
		}
		
		/**
		 *
		 * Call this function when display object is resized...
		 *
		 * @param w current width of the DO
		 * @param h current height of the DO
		 *
		 */
		private function update( w : Number,h : Number ) : void
		{
			
			with ( graphics )
			{
				clear();
				lineStyle( 1,0xed0244,1 );
				drawRect( 0,0,w,h );
			}
		}
	}
}
