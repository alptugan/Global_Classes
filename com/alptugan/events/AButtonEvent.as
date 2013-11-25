package com.alptugan.events
{
	import flash.events.Event;
	
	/**
	 * @author alptugan Nov,25,2013
	 */
	public class AButtonEvent extends Event
	{
		/** 
		 * 
		 */
		public static const BUTTON_CLICKED:String = "AButtonEvent.BUTTON_CLICKED";
		
		private var _inputName:String;
		private var _inputSurname:String;
		private var _inputEmail:String;
		private var _inputTel:String;
		
		public function AButtonEvent(type:String, inputName:String, inputSurname:String, inputEmail:String, inputTel:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			_inputName = inputName;
			_inputSurname = inputSurname;
			_inputEmail = inputEmail;
			_inputTel = inputTel;
		}
		
		public function get inputName():String
		{
			return _inputName;
		}
		
		public function set inputName( value:String ):void
		{
			_inputName = value;
		}
		
		public function get inputSurname():String
		{
			return _inputSurname;
		}
		
		public function get inputEmail():String
		{
			return _inputEmail;
		}
		
		public function get inputTel():String
		{
			return _inputTel;
		}
		
		override public function clone():Event 
		{ 
			return new AButtonEvent(type, _inputName, _inputSurname, _inputEmail, _inputTel, bubbles, cancelable);
		} 
		
		override public function toString():String 
		{ 
			return formatToString("AButtonEvent", "type", "inputName", "inputSurname", "inputEmail", "inputTel", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
