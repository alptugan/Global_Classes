/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
**/

package com.reflektions.tween.equations
{
  
  public class Exp {

	public static function easeIn (init:Number, diff:Number, t:Number):Number {
		return (t==0) ? init :  init + (diff * Math.pow(2, 10 * (t/1 - 1)));
	}	
	public static function easeOut (init:Number, diff:Number, t:Number):Number {
		return (t==1) ? init+diff : init + (diff * (-Math.pow(2, -10 * t/1) + 1));
	}	
	
  }
}