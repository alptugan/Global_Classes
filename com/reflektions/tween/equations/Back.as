/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
**/

package com.reflektions.tween.equations
{
  
  public class Back {

	public static function easeIn (init:Number, diff:Number, t:Number,...elasticity):Number {
		//e is elasticity
		var e:Number = (elasticity[0] == undefined) ? 1.70158 : Number(elasticity[0]) ;
		return init + (diff*(t/=1)*t*((e+1)*t - e));
	}	
	
	public static function easeOut (init:Number, diff:Number, t:Number,...elasticity):Number {
		//e is elasticity
		var e:Number = (elasticity[0] == undefined) ? -1.70158 : -1*Number(elasticity[0]) ;
		return init + (diff*(t/=1)*t*((e+1)*t*t*t*t - e));
	}		
	
  }
}

