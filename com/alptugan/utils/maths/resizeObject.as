package com.alptugan.utils.maths
{
	public class resizeObject
	{
		public static function resizeToWidth( obj : Object,maxW : Number ) : Object
		{
			//orgW = Math.ceil( orgW );
			maxW = Math.floor( maxW );
			
			var ratio:Number = obj.height/obj.width;
			
			
			if (obj.width>maxW) {
				obj.width = maxW;
				obj.height = Math.round(obj.width*ratio);
			}else{
				/*obj.width = maxW;
				obj.height = Math.round(obj.width*ratio);*/
			}
			
			
			
			return obj;
		}
		
		public static function resizeToWidth2( obj : Object,maxW : Number ) : Object
		{
			//orgW = Math.ceil( orgW );
			maxW = Math.floor( maxW );
			
			var ratio:Number = obj.height/obj.width;
			
			obj.width = maxW;
			obj.height = Math.round(obj.width*ratio);
			
			if (obj.width < maxW) {
				
			}
			
			
			return obj;
		}
	}
}