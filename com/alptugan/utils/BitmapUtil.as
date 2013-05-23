//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * @author Mark Knol
	 */
	public final class BitmapUtil
	{
		/// Returns a rectangle that defines the area of the display object relative to the coordinate system of the targetCoordinateSpace object.
		public static function getTextFieldBounds( textfield : TextField ) : Rectangle
		{
			const margin : int            = 35;
			
			const filtersList : Array     = cloneFilters( textfield );
			textfield.filters = [];
			
			const hasBorder : Boolean     = textfield.border;
			textfield.border = false;
			
			const hasBackground : Boolean = textfield.background;
			textfield.background = false;
			
			const bitmapdata : BitmapData = new BitmapData( textfield.width + ( margin * 2 ),textfield.height + ( margin * 2 ),true,0 );
			
			const matrix : Matrix         = textfield.transform.matrix.clone();
			matrix.tx = margin;
			matrix.ty = margin;
			
			bitmapdata.draw( textfield,matrix );
			
			var retval : Rectangle        = bitmapdata.getColorBoundsRect( 0xFFFFFFFF,0x000000,false );
			
			retval.x += textfield.x - margin;
			retval.y += textfield.y - margin;
			
			textfield.filters = filtersList;
			
			textfield.border = hasBorder;
			textfield.background = hasBackground;
			
			return retval;
		}
		
		private static function cloneFilters( obj : DisplayObject ) : Array
		{
			var retval : Array = [];
			
			for ( var i : uint = 0;i < obj.filters.length;++i )
			{
				retval.push( obj.filters[ i ]);
			}
			
			return retval;
		}
	}

}
