/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
**/

package com.reflektions.tween.equations
{
  
  public class Circular {

	public static function easeIn (init:Number, diff:Number, t:Number):Number {
		return init -(diff * (Math.sqrt(1 - (t/=1)*t) - 1));
	}	
	
  }
}