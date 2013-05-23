package src.com.innova.pages
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	import src.com.innova.InnovaMessage;
	
	public class PageInnovaFilm extends Page
	{
		public function PageInnovaFilm()
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
			
			
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			dispatchEvent(new Event("PageRemovedFromStage"));
		}
	}
}