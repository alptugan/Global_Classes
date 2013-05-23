package src.com.innova.pages
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	
	public class PageInnovaKonsept extends Page
	{
		
		private var tf:AText;

		private var XMLLoader:BulkLoader;

		private var title:ATextSingleLine;
		
		public function PageInnovaKonsept()
		{
			super();
		}
		
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			title = new ATextSingleLine("KONSEPT",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
			title.x = 461;
			title.y = 82;
			addChild(title);
			dispatchEvent(new Event('addedtostage'));
			//loadXML();
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			dispatchEvent(new Event("PageRemovedFromStage"));
		}
		
		private function loadXML():void
		{
			XMLLoader  = new BulkLoader("loader_name");
			XMLLoader.add("xml/konsept.xml");
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			
			var txt:XML = XMLLoader.getContent("xml/konsept.xml");
			
			tf = new AText(Globals.css[3].name,txt.toString(),Globals.css[3].width,Globals.css[3].size,Globals.css[3].color);
			addChild(tf);
			tf.x = title.x;
			tf.y = 150;
			
			XMLLoader.clear();
			XMLLoader.remove("loader_name");
			
			
			
		}
	}
}