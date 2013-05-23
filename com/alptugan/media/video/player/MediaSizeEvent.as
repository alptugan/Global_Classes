//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package  com.alptugan.media.video.player
{
	import flash.events.Event;
	
	public class MediaSizeEvent extends Event
	{
		public static const SIZE : String = "media_size";
		
		protected var _height : Number;
		
		public function get height() : Number
		{
			return _height;
		}
		
		protected var _width : Number;
		
		public function get width() : Number
		{
			return _width;
		}
		
		public function MediaSizeEvent( type : String,width : Number,height : Number )
		{
			super( type );
			_width = width;
			_height = height;
		}
	}
}