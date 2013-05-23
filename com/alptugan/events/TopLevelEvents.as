//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class TopLevelEvents extends Event
	{
		public static const ON_RESIZE : String = "on_resize";
		
		public var sW : int,
			sH : int;
		
		public function TopLevelEvents( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
