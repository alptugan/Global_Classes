/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
**/

package com.reflektions.tween.equations
{
  
  public class Quintic {

	public static function easeIn (init:Number, diff:Number, t:Number):Number {
		return init + (diff*(t/=1)*t*t);
	}	
	public static function easeOut (init:Number, diff:Number, t:Number):Number {
		return init + (diff*(t/=1)*t*t + 1);
	}
	
  }
}