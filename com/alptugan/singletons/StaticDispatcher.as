/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : StaticDispatcher.as
 * Release Date : Feb 5, 2012
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/

/** USAGE
 * 
 * 
 * 
 * 
 package {
    import flash.display.Sprite;
    import flash.events.Event;

    
    [SWF(height="800", width="600")]
    public class test extends Sprite
    {
        
        protected var mc:Sprite;
        
        public function test( )
        {
            StaticDispatcher.addEventListener( "test", testHandler );
            
            StaticDispatcher.testThisType();
        }
        
        protected function testHandler(e:Event):void
        {
            trace("works");
        }
    }
}
 * 
 * 
 * */

package com.alptugan.singletons
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class StaticDispatcher implements IEventDispatcher
	{
		protected static const staticDispatcher:EventDispatcher = new EventDispatcher();
		
		public function StaticDispatcher()
		{
			
		}
		
		static public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			staticDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			staticDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		
		
		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			staticDispatcher.removeEventListener( type, listener, useCapture );
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			staticDispatcher.removeEventListener( type, listener, useCapture );
		}
		
		
		
		
		static public function dispatchEvent(event:Event):Boolean
		{
			return staticDispatcher.dispatchEvent( event );
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return staticDispatcher.dispatchEvent( event );
		}
		
		
		
		
		static public function hasEventListener(type:String):Boolean
		{
			return staticDispatcher.hasEventListener(type);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return staticDispatcher.hasEventListener(type);
		}
		
		
		
		
		static public function willTrigger(type:String):Boolean
		{
			return staticDispatcher.willTrigger(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return staticDispatcher.willTrigger(type);
		}
		
		
		
		static public function testThisType():void
		{
			trace("dispatching event");
			
			dispatchEvent( new Event("test") );
		}
		
	}
}