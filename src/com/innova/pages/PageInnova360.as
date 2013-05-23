package src.com.innova.pages
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	import src.com.innova.galeri.InnovaMainGallery;
	
	public class PageInnova360 extends Page
	{
		public function PageInnova360()
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var title:ATextSingleLine = new ATextSingleLine("GALERİ",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
			title.x = 461;
			title.y = 72;
			addChild(title);
			
			//Galeri
			var galeri:InnovaMainGallery = new InnovaMainGallery("xml/panaromik.xml",728,768,false,true);
			addChild(galeri);
			galeri.x = 460;
			galeri.y = 38;
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			dispatchEvent(new Event("PageRemovedFromStage"));
		}
	}
}