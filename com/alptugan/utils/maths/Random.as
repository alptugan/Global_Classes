//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.utils.Maths
{
	
	public class Random
	{
		public static function Float( Min : Number,Max : Number ) : Number
		{
			return Min + Math.random() * ( Max - Min );
		}
		
		public static function Integer( Min : int,Max : int ) : int
		{
			return Min + Math.round( Math.random() * ( Max - Min ));
		}
	}
}
