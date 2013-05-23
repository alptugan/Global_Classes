package com.alptugan.events
{
	import flash.events.Event;
	
	public class LanguageEvent extends Event
	{
		public var _language:String;
		public static const LANGUAGE_SELECTED : String  = "language_selected";
		
		public function LanguageEvent( language:String , type:String, bubbles:Boolean=false, cancelable:Boolean=false):void 
		{ 
			super(type, bubbles, cancelable);
			_language = language;
		}
		
		public function get language():String { return _language; }
		
		public function set language( value:String ):void
		{
			_language = value;
		}
		
		public override function clone():Event 
		{ 
			return new LanguageEvent( language, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LanguageEvent", "language", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
