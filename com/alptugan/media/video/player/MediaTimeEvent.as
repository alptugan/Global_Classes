//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package  com.alptugan.media.video.player
{
	import flash.events.Event;
	
	/**
	* ...
	* @author Martin Legris ( http://blog.martinlegris.com )
	*/
	public class MediaTimeEvent extends Event
	{
		public static const TIME : String     = "media_time";
		
		public static const DURATION : String = "media_duration";
		
		protected var _loaded : Number;
		
		public function get loaded() : Number
		{
			return _loaded;
		}
		
		protected var _time : Number;
		
		public function get time() : Number
		{
			return _time;
		}
		
		public function MediaTimeEvent( type : String,time : Number,loaded : Number = -1 )
		{
			super( type );
			_time = time;
			_loaded = loaded;
		}
	}
}