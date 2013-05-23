package  src.com.innova.pages
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	import src.com.innova.InnovaMessage;
	
	public class HomePage extends Page
	{
		private var isProjection:Boolean;
		
		public function HomePage(isProjection:Boolean = false)
		{
			this.isProjection = isProjection;
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(!this.isProjection)
			{
				var title:ATextSingleLine = new ATextSingleLine("",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
				title.x = 461;
				title.y = 72;
				addChild(title);
				
			}
			
		
		}
		
		
	}
}