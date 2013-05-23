package src.com.azinliklarittifaki.pages
{
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.azinliklarittifaki.gallery.GalleryMain;
	
	public class Fotograflar extends Page
	{

		private var it:GalleryMain;
		public function Fotograflar()
		{
			super();
		}
		
		
		
		override protected function onAddedToStage(event:Event):void
		{
			
			it = new GalleryMain("xml/fotograflar.xml");
			addChild(it);
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			//it.destroy();
		}
	}
}