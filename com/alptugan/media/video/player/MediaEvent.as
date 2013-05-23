//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package  com.alptugan.media.video.player
{
	import flash.events.Event;
	
	public class MediaEvent extends Event
	{
		public static const FINISHED_PLAYING : String = "finished_playing";
		
		public static const FULLY_LOADED : String     = "fully_loaded";
		
		public static const ERROR : String            = "error";
		
		public static const STARTED_PLAYING : String  = "started_playing";
		
		protected var _text : String;
		
		public function get text() : String
		{
			return _text;
		}
		
		public function MediaEvent( type : String,text : String = "" )
		{
			super( type );
			_text = text;
		}
		
		override public function toString() : String
		{
			return "newcommerce.media.MediaEvent";
		}
	}
}