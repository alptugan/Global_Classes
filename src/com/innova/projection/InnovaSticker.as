package src.com.innova.projection
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.globals.Root;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	
	public class InnovaSticker extends Root
	{
		[Embed(source="assets2/logo.png")]
		protected var LogoClass:Class;
		
		private var Logo:Bitmap;
		
		
		private var rect:RectShape;
		
		public var tf:ATextSingleLine;
		
		public function InnovaSticker()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			rect = new RectShape(new Rectangle(0,0,964,160),new FillStyle(0x575850,0.5));
			addChild(rect);
			
			Logo = new LogoClass() as Bitmap;
			addChild(Logo);
			Aligner.alignLeft(Logo,rect,98);
			
			tf = new ATextSingleLine('deneme texti',Globals.css[0].name,Globals.css[0].color,Globals.css[0].size);
			addChild(tf);
			onResize();
		}
		
		public function onResize():void
		{
			Aligner.alignRight(tf,rect,-30,20);
		}
	}
}