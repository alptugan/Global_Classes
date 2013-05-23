//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class AccordionMenuEvent extends Event
	{
		public static const CONTENT_ADDED_TO_STAGE : String = "contentAddedToStage";
		
		public static const MENU_ADDED_TO_STAGE : String    = "menuAddedToStage";
		
		public var Id : String                              = "",preId : int;
		
		public var menuType : String                        = "";
		
		public var name : String                            = "";
		
		public var subname : String                         = "";
		
		public var subId :int;
		public var mainId:int;
		
		//public static const AUDIO_CHANGED:String = "change";
		public var subsubname : String                      = "";
		
		public function AccordionMenuEvent( type : String,bubbles : Boolean = false,cancelable : Boolean = true )
		{
			super( type,bubbles,cancelable );
		}
	}
}
