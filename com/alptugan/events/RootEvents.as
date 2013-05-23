package com.alptugan.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class RootEvents extends Event
	{
		public static const ON_RESIZE : String = "on_resize";
		public static const ON_ADDED_TO_STAGE : String = "on_addded_to_stage";
		
		public var sW : int,
		sH : int;
		
		public function RootEvents( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}