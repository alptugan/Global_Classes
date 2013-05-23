/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
**/

package com.reflektions.tween.equations
{
  
  public class Shubring {

	public static function easeInOut (init:Number, diff:Number, t:Number):Number {
		
		var p1pass:Number= 2*(t+(0.5-t)*Math.abs(0.5-t))-0.5;
		var p2pass:Number= 2*(p1pass+(0.5-p1pass)*Math.abs(0.5-p1pass))-0.5;
		var pAvg:Number=(p1pass+p2pass)/2;
		
		return init + (diff*pAvg);
	}	
	
  }
}