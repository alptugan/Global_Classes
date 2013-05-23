package src.com.azinliklarittifaki
{
	import com.alptugan.drawing.ALine;
	import com.alptugan.globals.Root;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Header extends Root
	{
		
		public var Menu : AccordionMenu;
		private var Logo : ATextSingleLine;
		private var Line : ALine;
		
		public function Header(_x:int,_y:int)
		{
			this.x = _x;
			this.y = _y;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			Logo = new ATextSingleLine("AZINLIKLAR İTTİFAKI",Globals.css[0].name,Globals.css[0].color,Globals.css[0].size,true,false,true);
			addChild(Logo);
			
			Line = new ALine(new Point(0,40),1,0x333333);
			addChild(Line);
			Line.x = Logo.x + Logo.width + 22;
			Line.y = Logo.y + 4+(Logo.height - Line.height)>>1;
			
			Menu = new AccordionMenu(Globals.css[1].name,Globals.css[1].size,Globals.css[1].color,16);
			Menu.x = Line.x + 22 ;
			addChild(Menu);
		}
	}
}