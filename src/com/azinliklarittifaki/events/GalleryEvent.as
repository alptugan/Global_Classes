package src.com.azinliklarittifaki.events
{
	import flash.events.Event;
	
	/**
	 * @author alp tugan
	 */
	public class GalleryEvent extends Event
	{
		/** 
		 * 
		 */
		public static const IMAGE_ONCOMPLETE:String = "GalleryEvent.IMAGE_ONCOMPLETE";
		/** 
		 * 
		 */
		public static const IMAGE_ONSTART:String = "GalleryEvent.IMAGE_ONSTART";
		
		
		public function GalleryEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{ 
			return new GalleryEvent(this.type, this.bubbles, this.cancelable);
		} 
		
		override public function toString():String 
		{ 
			return formatToString("GalleryEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
