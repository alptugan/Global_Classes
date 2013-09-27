package com.alptugan.utils
{
	import com.alptugan.events.LoadXMLEvent;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LoadXML extends EventDispatcher
	{
		private var xmlName:String;
		private var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});

		public var xml:XML;

		
		public function LoadXML(xmlName:String)
		{
			this.xmlName = xmlName;
			queue.append( new XMLLoader(xmlName, {name:"xmlDoc",autoDispose:true,auditSize:false}) );
			//start loading
			queue.load();
			
		}
		
		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		
		private function completeHandler(event:LoaderEvent):void {
			/*var image:ContentDisplay = LoaderMax.getContent("photo1");
			TweenLite.to(image, 1, {alpha:1, y:100});*/
			xml = LoaderMax.getContent("xmlDoc");
			
			queue.dispose(true);
			queue.empty(true,true);
			queue.unload();
			
			//trace(xml);
			trace(event.target + " is completed!");
			var el:LoadXMLEvent = new LoadXMLEvent(LoadXMLEvent.XML_LOADED,xml,"");
			dispatchEvent(el);
		}
		
		private function errorHandler(event:LoaderEvent):void {
			queue.dispose(true);
			trace("error occured with " + event.target + ": " + event.text);
			var eld:LoadXMLEvent = new LoadXMLEvent(LoadXMLEvent.XML_ERROR,xml,"");
			dispatchEvent(eld);
		}
	}
}