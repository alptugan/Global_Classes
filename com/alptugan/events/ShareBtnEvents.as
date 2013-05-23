//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class ShareBtnEvents extends Event
	{
		public static const ON_CLICK : String = "on_click";
		
		public var getSocialNetName : String  = "";
		
		public function ShareBtnEvents( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
