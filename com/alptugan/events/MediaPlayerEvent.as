//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class MediaPlayerEvent extends Event
	{
		public static const INTERFACE_LOADED : String = "interfaceLoaded";
		
		public static const AUDIO_CHANGED : String    = "change";
		
		public var Id : int;
		
		public var Source : String                    = "";
		
		public var SubTitle : String                  = "";
		
		public var Title : String                     = "";
		
		public function MediaPlayerEvent( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
