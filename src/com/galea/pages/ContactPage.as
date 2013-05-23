package src.com.galea.pages
{
	import com.alptugan.Mail.AMailForm;
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.template.ATextWithTitle;
	import com.alptugan.text.AText;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.galea.Globals;
	import src.com.galea.styleGalea;
	
	public class ContactPage extends Page
	{
		public var base:PageBase;
		
		private var M : AMailForm;
		
		public function ContactPage()
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void 
		{
			base = new PageBase(this.pageTitle.toUpperCase())
			addChild(base);
			
			base.closeBtn.addEventListener(MouseEvent.CLICK,onClickClose);
			
			M = new AMailForm( "http://www.alptugan.com/Mail.php",383,25,3 );
			
			
			M.y = base.title.y + 55;
			M.x = base.title.x;
			
			addChild( M );
			
			
			var tx:AText = new AText(styleGalea.p,String(Globals.ContactXML.contact),383,styleGalea.pSize,styleGalea.pColor);
			tx.x = M.x + M.width + 20;
			tx.y = M.y;
			tx.lineSpace = styleGalea.pLeading;
			addChild(tx);
			
			
			// call super to show page
			super.onAddedToStage(e);
		}
		public function onClickClose(e:MouseEvent):void
		{
			base.closeBtn.removeEventListener(MouseEvent.CLICK,onClickClose);
			
			Galea.goto(Pages.HOME_PAGE);
			
		}
	}
}