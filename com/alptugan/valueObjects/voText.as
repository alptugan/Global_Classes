// Generated with http://projects.stroep.nl/ValueObjectGenerator/ 

package com.alptugan.valueObjects
{
	/**
	 * @author alp tugan
	*/
	public final class voText
	{
		public var text:String;
		public var color:uint;
		public var w:int;
		public var h:int;
		public var alpha:Number;
		public var fontName:String;
		public var fontSize:Number;
		public var align:String;
		
		public function voText(text:String = "", align:String="left",color:uint = 0, w:int = 100, h:int = 100, alpha:Number = 1, fontName:String = "", fontSize:Number = 12):void 
		{ 
			this.text = text;
			this.color = color;
			this.w = w;
			this.h = h;
			this.alpha = alpha;
			this.fontName = fontName;
			this.fontSize = fontSize;
			this.align    = align;
		}

	}
}