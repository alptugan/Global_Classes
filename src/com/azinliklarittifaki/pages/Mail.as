package src.com.azinliklarittifaki.pages
{

	
	import com.alptugan.text.AText;
	
	import flash.events.Event;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.azinliklarittifaki.mail.AMailForm;
	
	public class Mail extends Page
	{
		private var M : AMailForm;
		
		public function Mail()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			super();
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			M = new AMailForm( "http://www.azinliklarittifaki.com/Mail.php",290,25,3,true);
			
			
			M.y = 90;
			M.x = 248;
			
			addChild( M );
			
			/*
			var tx:AText = new AText(styleGalea.p,String(Globals.ContactXML.contact),383,styleGalea.pSize,styleGalea.pColor);
			tx.x = M.x + M.width + 20;
			tx.y = M.y;
			tx.lineSpace = styleGalea.pLeading;
			addChild(tx);*/
		}
	}
}