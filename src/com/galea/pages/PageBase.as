package src.com.galea.pages
{
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.drawing.CustomShapes.ACrossShape;
	import com.alptugan.globals.Root;
	import com.alptugan.text.AText;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.stroep.flashflowfactory.Page;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.galea.display.APatternBg;
	import src.com.galea.styleGalea;
	
	public class PageBase extends Root
	{
		public var title:AText;
		public var bg:APatternBg;
		private var names:String;
		public var h:int;

		public var closeBtn:ACrossShape;
		
		public function PageBase(names:String="",h:int=330)
		{
			super();
			this.names = names;
			this.h = h;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			initResizeHandler();
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			bg = new APatternBg(stage.stageWidth,h);
			bg.y = Pages.marginY;
			bg.alpha  = 0.5;
			addChild(bg);
			
			
			title = new AText(FontNamesFB.thin,names,400,styleGalea.h2Size,styleGalea.h2Color);
			title.x = Pages.titleX;
			title.y = bg.y + Pages.titleY -  3;
			addChild(title);
			
			closeBtn = new ACrossShape();
			addChild(closeBtn);
			
			closeBtn.y = title.y;
			closeBtn.x = stage.stageWidth - closeBtn.width - 20;
			
			
		}
		
		
		override protected function on_Resize(e:Event):void
		{
			if(bg.tiled)
				bg.tiled.setSize(stage.stageWidth,h);
			
			if (closeBtn) 
			{
				alignRight(closeBtn,-20,title.y);
			}
		}
	}
}