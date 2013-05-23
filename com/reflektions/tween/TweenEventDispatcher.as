/**
#
* @author Paul Ortchanian [http://www.reflektions.com]
#
* @version 1.0
#
* Tween Event Dispatcher Class
* @ purpose: Contains custom events model dispatches with parameters passed as object
*/

package com.reflektions.tween{
	import flash.events.Event;

	public class TweenEventDispatcher extends Event {
		
		public static var TWEEN_COMPLETE:String = "tween_complete";	// event dispatched when tween completed
		public static var TWEEN_PROGRESS:String = "tween_progress";	// event dispatched when tween completed

		public var params:Object;
		
		//- CONSTRUCTOR -------------------------------------------------------------------------------------------

		public function TweenEventDispatcher(type:String, params:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			super(type, bubbles, cancelable);
			
			this.params = params;
		}
		

		//- HELPERS -----------------------------------------------------------------------------------------------

		public override function clone():Event{
			
			return new TweenEventDispatcher(type, this.params, bubbles, cancelable);
			
		}

		public override function toString():String{
			
			return formatToString("TweenEventDispatcher", "params", "type", "bubbles", "cancelable");
			
		}
		
		//- END CLASS ---------------------------------------------------------------------------------------------

  }
}
