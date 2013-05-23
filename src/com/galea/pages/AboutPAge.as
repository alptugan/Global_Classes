package src.com.galea.pages
{
	import com.alptugan.template.ASimpleSlideShow;
	import com.alptugan.text.AText;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.galea.Globals;
	import src.com.galea.styleGalea;

	public class AboutPAge extends Page
	{
		public var base:PageBase;
		private var cont:AText; 
		
		public function AboutPAge()
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void 
		{
			
			base = new PageBase(this.pageTitle.toUpperCase(),340);
			addChild(base);
			
			base.closeBtn.addEventListener(MouseEvent.CLICK,onClickClose);
			
			cont = new AText(styleGalea.p,String(Globals.AboutXML.item[0].name),500,styleGalea.pSize,styleGalea.pColor);
			cont.lineSpace = 2;
			cont.spacing   = 1.1;
			cont.y = base.title.y + 55;
			cont.x = base.title.x;
			addChild(cont);
			
			
			var slide:ASimpleSlideShow = new ASimpleSlideShow(Globals.AboutXML,0, 308,3,"default");
			slide.isXML = true;
			addChild(slide);
			
			slide.x = cont.x + cont.width + 30;
			slide.y = base.title.y - 18;
			// call super to show page
			super.onAddedToStage(e);
			
			/*
			,310, 207,3,"default");
			slide.isXML = true;
			addChild(slide);
			
			slide.x = cont.x + cont.width + 30;
			slide.y = cont.y;*/
		}
		
		public function onClickClose(e:MouseEvent):void
		{
			base.closeBtn.removeEventListener(MouseEvent.CLICK,onClickClose);
			
			Galea.goto(Pages.HOME_PAGE);
			
		}
	}
}