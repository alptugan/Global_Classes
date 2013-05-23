/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
**/

package com.reflektions.tween.equations
{
  
  public class Sin {

	public static function easeIn (init:Number, diff:Number, t:Number):Number {
		return init  + diff -(diff * Math.cos(t/1 * (Math.PI/2)));
	}	
	public static function easeOut (init:Number, diff:Number, t:Number):Number {
		return init + (diff * Math.sin(t/1 * (Math.PI/2)));
	}	
	public static function easeInOut (init:Number, diff:Number, t:Number):Number {
		return init-(diff/2 *(Math.cos(Math.PI*t/1) - 1));
	}
	
  }
}