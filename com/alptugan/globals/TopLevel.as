//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.globals
{
	import com.alptugan.events.TopLevelEvents;
	import com.alptugan.utils.SWFProfiler;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	/*
	* TopLevel class
	* have all document classes extend this
	* class instead of Sprite or MovieClip to
	* allow global stage and root access through
	* TopLevel.stage and TopLevel.root
	*/
	public class TopLevel extends MovieClip
	{
		
		/**
		 * stage : Globals stage variable
		 * root  : Globals root (top layer) object 
		 */
		public static var
			stage : Stage,
			root  : DisplayObject;
		
			
		/**
		 * profiler : enabled with right-click on stage in order to see performance monitor hide/show
		 * rEvt     : TopLevel Class Events 
		 */		
		private var profiler    : Boolean,
					rEvt        : TopLevelEvents,
					_loaderInfo : Boolean;
		
		/**
		 * 
		 * @param profiler : Boolean, you can set it true or false according to your needs
		 * 
		 */					
		public function TopLevel( profiler : Boolean = true, _loaderInfo : Boolean = false )
		{
			this.profiler = profiler;
			this._loaderInfo = _loaderInfo;
			if ( this.stage )
			{
				setupTopLevel();
			}
			else
			{
				addEvent(this,Event.ADDED_TO_STAGE,setupTopLevel );
			}
		}
		
		/**
		 * 
		 * adds Event listener with week reference
		 * 
		 * @param item     : EventDispatcher object which is listening defined function
		 * @param type     : Type of Event
		 * @param listener : Listener function
		 * 
		 */
		public function addEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.addEventListener( type,listener,false,0,true );
		}
		
		/**
		 * 
		 * removes Event listener with week reference
		 * 
		 * @param item     : EventDispatcher object which is listening defined function
		 * @param type     : Type of Event
		 * @param listener : Listener function
		 * 
		 */
		public function removeEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.removeEventListener( type,listener );
		}
		
		public function removeContent( childName:String ):void
		{
			if( stage.getChildByName( childName ) != null){
				if( stage.getChildByName( childName ).visible ) stage.removeChild( stage.getChildByName( childName ) );					
			}			  			
		}
		
		/**
		 * Initializes the application 
		 * @param event
		 * 
		 */
		private function setupTopLevel( event : Event = null ) : void
		{
			if ( event )
				removeEvent(this,Event.ADDED_TO_STAGE,setupTopLevel );
	
			TopLevel.stage = this.stage;
			TopLevel.root = this;
			
			Config.setup( this );
			profiler ? SWFProfiler.init( stage,this ) : void;
			
			//addEvent(TopLevel.stage, Event.RESIZE,onResize );
			(_loaderInfo) ? loaderInfo.addEventListener(Event.INIT, onLoaderInfo_INIT) : void; 
		}
		
		
		
		public function onLoaderInfo_INIT(event:Event):void
		{
			loaderInfo.removeEventListener(Event.INIT, onLoaderInfo_INIT); 
			
			trace(Capabilities.screenResolutionX);
			trace("loaderInfo.actionScriptVersion: "+loaderInfo.actionScriptVersion);
			trace("loaderInfo.applicationDomain: "+loaderInfo.applicationDomain);
			//trace("loaderInfo.bytes: "+loaderInfo.bytes);
			trace("loaderInfo.bytesLoaded: "+loaderInfo.bytesLoaded);
			trace("loaderInfo.bytesTotal: "+loaderInfo.bytesTotal);
			trace("loaderInfo.childAllowsParent: "+loaderInfo.childAllowsParent);
			//trace("loaderInfo.constructor: "+loaderInfo.constructor);
			trace("loaderInfo.content: "+loaderInfo.content);
			trace("loaderInfo.contentType: "+loaderInfo.contentType);
			trace("loaderInfo.frameRate: "+loaderInfo.frameRate);
			trace("loaderInfo.height: "+loaderInfo.height);
			trace("loaderInfo.loader: "+loaderInfo.loader);
			trace("loaderInfo.loaderURL: "+loaderInfo.loaderURL);
			trace("loaderInfo.parameters: "+loaderInfo.parameters);
			trace("loaderInfo.parentAllowsChild: "+loaderInfo.parentAllowsChild);
			//trace("loaderInfo.prototype: "+loaderInfo.prototype);
			trace("loaderInfo.sameDomain: "+loaderInfo.sameDomain);
			trace("loaderInfo.sharedEvents: "+loaderInfo.sharedEvents);
			trace("loaderInfo.swfVersion: "+loaderInfo.swfVersion);
			trace("loaderInfo.url: "+loaderInfo.url);
			trace("loaderInfo.width: "+loaderInfo.width);
		}
	}
}