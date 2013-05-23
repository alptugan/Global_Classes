//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 *
	 * @author alptugan
	 *
	 */
	public class ListManagerEvent extends Event
	{
		public static const ITEM_CLICKED : String = "listclicked";
		
		public var Id : int;
		
		public var Source : String                = "";
		
		public var SubTitle : String              = "";
		
		public var Title : String                 = "";
		
		public function ListManagerEvent( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
