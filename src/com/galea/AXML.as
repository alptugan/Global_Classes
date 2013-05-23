package src.com.galea
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.casalib.events.LoadEvent;
	import org.casalib.load.DataLoad;

	/*
	
	loader = new AXML();
	loader.addEventListener(LoadEvent.COMPLETE,onComplete);
	loader.load("xml/menu.xml");
	
	*/
	
	public class AXML extends EventDispatcher
	{
		public var xml       : XML,
				   dataLoad  : DataLoad;
		
		public function AXML()
		{
			
		}
		
		public  function load(src:String):void
		{
			dataLoad = new DataLoad(src);
			dataLoad.addEventListener(LoadEvent.COMPLETE, XMLonComplete);
			dataLoad.start();
		}
		
		protected  function XMLonComplete(e:LoadEvent):void
		{
			dataLoad.destroy();
			dataLoad.removeEventListeners();
			// set xml variable
			xml = dataLoad.dataAsXml;
			dispatchEvent(e);
		}
	}
}