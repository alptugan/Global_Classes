package com.alptugan.events
{
	import flash.events.Event;

	public class LoadXMLEvent extends Event
	{
		/** 
		 * 
		 */
		public static const XML_LOADED:String = "LoadXMLEvent.loaded";
		public static const XML_ERROR:String = "LoadXMLEvent.error";
		
		private var _xmlContent:XML;
		private var _name:String;
		
		public function LoadXMLEvent(type:String, xmlContent:XML, name:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._xmlContent = xmlContent;
			this._name = name;
		}
		
		public function get xmlContent():XML
		{
			return this._xmlContent;
		}
		
		public function get name():String
		{
			return this._name;
		}
		
		override public function clone():Event 
		{ 
			return new LoadXMLEvent(this.type, this._xmlContent, this._name, this.bubbles, this.cancelable);
		} 
		
		override public function toString():String 
		{ 
			return formatToString("LoadXMLEvent", "type", "xmlContent", "name", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}