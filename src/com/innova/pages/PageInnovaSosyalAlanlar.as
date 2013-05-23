package src.com.innova.pages
{
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	import src.com.innova.galeri.InnovaMainGallery;
	
	public class PageInnovaSosyalAlanlar extends Page
	{
		public function PageInnovaSosyalAlanlar()
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//var title:ATextSingleLine = new ATextSingleLine("SOSYAL"+ "<br>" + "ALANLAR",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
			var title:AText = new AText(Globals.css[3].name,"SOSYAL ALANLAR",240,Globals.css[3].size,Globals.css[3].color,false);
			title.x = 461;
			title.y = 25;
			addChild(title);
			
			
			//Galeri
			var galeri:InnovaMainGallery = new InnovaMainGallery("xml/sosyal.xml");
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