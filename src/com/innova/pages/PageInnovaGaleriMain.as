package src.com.innova.pages
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	import src.com.innova.InnovaMessage;
	
	public class PageInnovaGaleriMain extends Page
	{
		public function PageInnovaGaleriMain()
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
			
			//Load  Message Board
			var welcome:InnovaMessage = new InnovaMessage(Globals.Style.messages[0].welcome[0].toString());
			addChild(welcome);
			Aligner.alignCenter(welcome,stage,450);
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			dispatchEvent(new Event("PageRemovedFromStage"));
		}
	}
}