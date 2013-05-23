package src.com.galea.events
{
	import flash.events.Event;
	
	public class MyCustomEvent extends Event
	{
		public static const SAY_HELLO:String = "say_hello";
		public static const SAY_HELLO_TO:String = "say_hello_to";
		
		private var _firstName:String;
		
		public function MyCustomEvent(type:String, firstname:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this._firstName = firstname;
		} 
		public function get firstName():String { return _firstName; }
	}
}