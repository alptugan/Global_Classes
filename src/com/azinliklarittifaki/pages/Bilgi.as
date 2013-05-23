package src.com.azinliklarittifaki.pages
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.text.AText;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.azinliklarittifaki.Globals;
	
	public class Bilgi extends Page
	{
		
		private var src:String ;

		private var XMLLoader:BulkLoader;
		
		public function Bilgi()
		{
		}
		
		
		
		override protected function onAddedToStage(event:Event):void
		{
			this.x = 248;
			this.y = 90;
			loadXML();
			//
		}
		
		private function loadXML():void
		{
			src = "xml"+this.pageName+".xml";
			XMLLoader  = new BulkLoader("bilgi");
			XMLLoader.add(src);
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.addEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			XMLLoader.start();
		}
		
		private function onAllProgress(e:BulkProgressEvent):void
		{
			//trace("alo : ",Math.round(e.bytesLoaded / e.bytesTotal * 100 )  );
		}
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.removeEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			
			var txt:XML = XMLLoader.getContent(src);
			
			
			var tf:AText = new AText(Globals.css[2].name,txt.toString(),Globals.css[2].width,Globals.css[2].size,Globals.css[2].color,true,false,"left",true);
			addChild(tf);
			
			XMLLoader.clear();
			XMLLoader.remove("bilgi");
			
		}
	}
}