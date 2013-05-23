//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	
	public class FontLoaderEvent extends Event
	{
		public static const FONTS_LOADED : String   = "fontsLoaded";
		
		public static const FONTS_PROGRESS : String = "fontsLoading";
		
		public var customMessage : String           = "";
		
		public var percent : int;
		
		public function FontLoaderEvent( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
