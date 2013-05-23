package  src.com.azinliklarittifaki.gallery.control
{
	import flash.events.Event;
	
	/**
	 * @author alp tugan
	 */
	public class ControllerEvent extends Event
	{
		/** 
		 * 
		 */
		public static const CLICKED:String = "ControllerEvent.CLICKED";
		
		private var _action:String;
		
		public function ControllerEvent(type:String, action:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._action = action;
		}
		
		public function get action():String
		{
			return this._action;
		}
		
		override public function clone():Event 
		{ 
			return new ControllerEvent(this.type, this._action, this.bubbles, this.cancelable);
		} 
		
		override public function toString():String 
		{ 
			return formatToString("ControllerEvent", "type", "action", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
