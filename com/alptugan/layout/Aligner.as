

/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : Aligner.as
 * Release Date : Dec 6, 2011
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/

/** USAGE */
/*
Aligner.alignCenter();


*/
package com.alptugan.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class Aligner
	{
		public function Aligner()
		{
		}
		
		public static function alignCenter(obj1:Object,obj2:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (obj2.width - obj1.width) >> 1;
			obj1.y = marginY + (obj2.height - obj1.height) >> 1;
		}
		
		public static function alignToCenterOf(obj1:Object,obj2:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = (marginX + obj2.x) + (obj2.width >> 1) - (obj1.width >> 1);
			obj1.y = (marginY + obj2.y) + (obj2.height >> 1) - (obj1.height >> 1);
		}
		
		public static function alignToCenterTopToBounds(obj1:Object,W:int,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (W - obj1.width) >> 1;
			obj1.y = marginY;
		}
		
		public static function alignLeft(obj1:Object,obj2:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX ;
			obj1.y = marginY + (obj2.height - obj1.height) >> 1;
		}
		
		
		public static function alignRight(obj1:Object,obj2:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (obj2.width - obj1.width);
			obj1.y = marginY + (obj2.height - obj1.height) >> 1;
		}
		
		
		public static function alignTopRightToBounds(obj1:DisplayObject, parentW:int,parentH:int,marginX:int,marginY:int):void
		{
			obj1.x = marginX + (parentW - obj1.width);
			obj1.y = marginY;
		}
		
		public static function alignMiddleRightToBounds(obj1:Object,objW:Number,objH:Number,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (objW - obj1.width);
			obj1.y = marginY + (objH - obj1.height) >> 1;
		}
		
		public static function alignMiddleLeftToBounds(obj1:Object,obj2Height:Number,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX ;
			obj1.y = marginY + (obj2Height - obj1.height) >> 1;
		}
		
		public static function alignMiddleVerticalToBounds(obj1:Object,obj2Height:Number, marginY:int = 0):void
		{
			obj1.y = marginY + (obj2Height - obj1.height) >> 1;
		}
		
		public static function alignMiddleHorizontalToBounds(obj1:Object,obj2Width:Number, marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (obj2Width - obj1.width) >> 1;
			obj1.y = marginY;
		}
		
		
		public static function alignToRight(obj1:Object,obj2:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (obj2.width - obj1.width);
			obj1.y = marginY;
		}
		
		public static function alignBottomLeftToBounds(obj1:Object,obj2Height:Number, marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX;
			obj1.y = marginY + (obj2Height - obj1.height);
		}
		
		public static function alignBottomMiddleToBounds(obj1:Object,obj2Width:Number,obj2Height:Number, marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (obj2Width - obj1.width) >> 1;
			obj1.y = marginY + (obj2Height - obj1.height);
		}
		
		public static function alignCenterMiddleToBounds(obj1:Object, obj2Width:Number,obj2Height:Number,marginX:int = 0, marginY:int = 0):void
		{
			obj1.x = marginX + (obj2Width - obj1.width) >> 1;
			obj1.y = marginY + (obj2Height - obj1.height)  >> 1;
		}
		
		
		/**
		 * 
		 * DISTRIBUTES ARRAY OF ITEMS ON GRID POSITION
		 * 
		 * @param arr        = Array of images
		 * @param startX     = starting position of items on x axes
		 * @param startY     = starting position of items on y axes
		 * @param totalRows  = number of rows
		 * @param totalCols  = number of columns
		 * @param hGap       = horizontal gap between items
		 * @param vGap       = vertical gap betweem items
		 * 
		 */
		public static function generateBoard(obj:DisplayObject,startX:Number,startY:Number,totalRows:Number,totalCols:Number,hGap:int,vGap:int):void {
			
			
			obj.x = startX + (hGap + obj.width) * Math.floor( totalRows / totalCols );
			obj.y = startY + (vGap + obj.height) * (totalCols % totalCols );
		}
		
		
	}
}