package com.alptugan.events
{
	import flash.events.Event;

	/**
	 * @author alp tugan
	*/
	public class FilikaCalibrationEvent extends Event
	{
		/** 
		 * 
		 */
		public static const CHANGE:String = "FilikaCalibrationEvent.change";

		private var _value:Number;
		private var _name:String;
		
		public function FilikaCalibrationEvent(type:String, value:Number, name:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._value = value;
			this._name = name;
		}

		public function get value():Number
		{
			return this._value;
		}

		public function get name():String
		{
			return this._name;
		}

		override public function clone():Event 
		{ 
			return new FilikaCalibrationEvent(this.type, this._value, this._name, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("FilikaCalibrationEvent", "type", "value", "name", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
