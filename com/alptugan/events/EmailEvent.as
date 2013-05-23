//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	
	public class EmailEvent extends Event
	{
		public static const EMAIL_SENT : String  = "emailSent";
		
		public static const EMAIL_ERROR : String = "InvalidEmail";
		
		public var customMessage : String        = "";
		
		public function EmailEvent( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
