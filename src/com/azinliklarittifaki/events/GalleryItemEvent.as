// Generated with http://projects.stroep.nl/ValueObjectGenerator/ 
package src.com.azinliklarittifaki.events
{
	import flash.events.Event;

	/**
	 * @author alp tugan
	*/
	public class GalleryItemEvent extends Event
	{
		/** 
		 * 
		 */
		public static const LOADING_ONSTART:String = "GalleryItemEvent.loading_onstart";
		/** 
		 * 
		 */
		public static const LOADING_ONPROGRESS:String = "GalleryItemEvent.loading_onprogress";
		/** 
		 * 
		 */
		public static const LOADING_ONCOMPLETE:String = "GalleryItemEvent.loading_oncomplete";

		private var _id:String;
		
		public function GalleryItemEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
			this._id = id;
		}

		public function get id():String
		{
			return this._id;
		}

		public function set id( value:String ):void
		{
			this._id = value;
		}

		override public function clone():Event 
		{ 
			return new GalleryItemEvent(this.type, this.bubbles, this.cancelable);
		} 

		override public function toString():String 
		{ 
			return formatToString("GalleryItemEvent", "type", "id", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
