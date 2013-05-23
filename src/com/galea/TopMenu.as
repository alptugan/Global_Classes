package src.com.galea
{
	import com.alptugan.globals.Root;
	import com.alptugan.media.Mp3BgPlayer;
	
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.galea.display.APatternBg;
	import src.com.galea.pages.Pages;
	
	public class TopMenu extends Root
	{

		private var t:APatternBg;
		
		private var player:Mp3BgPlayer;
		
		
		public var Menu:AccordionMenu;
		
		public function TopMenu(Y:int)
		{
			this.y = Y;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			stage.addEventListener(Event.RESIZE,onResizes);
			t = new APatternBg(stage.stageWidth,47);
			addChildAt(t,0);
			
			t.alpha = 0.75;
			Menu = new AccordionMenu(styleGalea.h1,styleGalea.h1Size);
			
			addChild(Menu);
			Menu.x = Pages.titleX - 2;
			Menu.y = 4 + (t.height - Menu.height) >> 1;
			
			
			
			
			player = new Mp3BgPlayer("assets/sound/de.mp3");
			Menu.addChild(player);
			
			
			
			onResizes(null);
			
			
		}
		
		public function onResizes(e:Event):void
		{
			t.tiled.setSize(stage.stageWidth,47);
			player.x = stage.stageWidth - player.width - 50;
			player.y = (Menu.height - player.height) >> 1;
			
			
		}
		
		override protected function on_MouseLeave(e:Event):void
		{
			//t.alpha =0.5;
		}
	}
}