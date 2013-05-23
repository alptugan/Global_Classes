package com.alptugan.events
{
	import flash.events.Event;
	
	/**
	 * @author alp tugan
	 */
	public class CameraEvent extends Event
	{
		/** 
		 * User allow camera to capture
		 */
		public static const CAMERA_ALLOWED:String = "CameraEvent.camera_allowed";
		
		/** 
		 * User doesn't allow camera to capture
		 */
		public static const CAMERA_DENIED:String = "CameraEvent.camera_DENIED";
		
		/** 
		 * Motion Captured
		 */
		public static const MOTION_CAPTURED:String = "CameraEvent.motion_CAPTURED";
		
		public function CameraEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{ 
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{ 
			return new CameraEvent(this.type, this.bubbles, this.cancelable);
		} 
		
		override public function toString():String 
		{ 
			return formatToString("CameraEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}
