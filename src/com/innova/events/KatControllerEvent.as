// Generated with http://projects.stroep.nl/ValueObjectGenerator/ 
package src.com.innova.events
{
	import flash.events.Event;

	/**
	 * @author alp tugan
	*/
	public class KatControllerEvent extends Event
	{
		/** 
		 * 
		 */
		public static const DEVAM_CLICK:String = "KatControllerEvent.devam_click";
		/** 
		 * 
		 */
		public static const TEMIZLE_CLICK:String = "KatControllerEvent.temizle_click";
		/** 
		 * 
		 */
		public static const GERI_CLICK:String = "KatControllerEvent.geri_click";

		private var _katNo:String;
		
		public function KatControllerEvent(type:String, katNo:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._katNo = katNo;
		}

		public function get katNo():String
		{
			return this._katNo;
		}

		public function set katNo( value:String ):void
		{
			this._katNo = value;
		}

		override public function clone():Event 
		{ 
			return new KatControllerEvent(this.type, this._katNo, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("KatControllerEvent", "type", "katNo", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
