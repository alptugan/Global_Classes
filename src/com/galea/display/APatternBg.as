package src.com.galea.display
{
	import com.alptugan.drawing.TileBackground;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class APatternBg extends CasaSprite
	{
		public var tiled:TileBackground;
		
		private var 
					bgColor    : uint,
					shapeColor : uint,
					bgW        : int,
					bgH		   : int,
					shpW       : int,
					shpH       : int,
					W          : int,
					H          : int;
		
		public function APatternBg(W:int,H:int,bgColor:uint = 0xffffff,shapeColor:uint = 0xc7c7c7, bgW:int = 3, bgH:int=3,shpW:int=1,shpH:int=1)
		{
			this.bgColor    = bgColor;
			this.shapeColor = shapeColor;
			this.bgW        = bgW;
			this.bgH 		= bgH;
			this.shpW 		= shpW;
			this.shpH       = shpH;
			this.W			= W;
			this.H			= H;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);

			/*var bmd:BitmapData = new BitmapData(80, 80, true, 0xFFCCCCCC);
			
			for (var i:uint = 0; i < 80; i++) {
				var red:uint = 0x60FF0000;
				bmd.setPixel32(i, 40, red);
			}
			
			var bm:Bitmap = new Bitmap(bmd);
			addChild(bm);*/
			
			/*var bmd:BitmapData = new BitmapData(200, 200, false, 0x00CCCCCC);
			
			var seed:Number = Math.floor(Math.random() * 10);
			var channels:uint = BitmapDataChannel.RED ;
			bmd.perlinNoise(100, 80, 6, seed, false, true, channels, false, null);
			
			var bm:Bitmap = new Bitmap(bmd);
			addChild(bm);*/
			
			var bmd:BitmapData = new BitmapData(bgW, bgH, false, bgColor);
			var rect:Rectangle = new Rectangle(0, 0, shpW, shpH);
			bmd.fillRect(rect, shapeColor);
			
	/*		var bm:Bitmap = new Bitmap(bmd);
			addChild(bm);*/
			
			tiled = new TileBackground(bmd,W,H);
			addChild(tiled);
			
			

		}
	}
}