package src.com.azinliklarittifaki.gallery
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.globals.Root;
	import com.alptugan.layout.Aligner;
	import com.alptugan.valueObjects.voText;
	import com.greensock.layout.AutoFitArea;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.azinliklarittifaki.Globals;
	
	public class ItemFullScreen extends Root
	{
		private var bmp:Bitmap;
		private var infoTxt:String;
		private var rect:RectShape;
		public var info:InfoWindow;
		public var infoPosY:int;

		private var area:AutoFitArea;
		
		public function ItemFullScreen(bmp:Bitmap,infoTxt:String="")
		{
			this.bmp     = bmp;
			this.infoTxt = infoTxt;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			area.destroy();
		}		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			bmp.smoothing = true;
			addChild(bmp);
			Aligner.alignMiddleHorizontalToBounds(bmp,W,0,106);
			
			// Info Window
			var tfvo:voText = new voText(infoTxt,"left",Globals.css[1].color,bmp.width - 100, 100,0.8,Globals.css[1].name,Globals.css[1].size);
			
			info = new InfoWindow(tfvo);
			addChild(info);
			
			info.alpha = 0;
			info.visible = false;
			Aligner.alignMiddleHorizontalToBounds(info,W,0,bmp.y + 30);
			
			
			area = new AutoFitArea(this, 0,bmp.y,W,H-126);
			area.attach(bmp,{vAlign:"TOP"});
			
			//area.preview = true;
			
			infoPosY = info.y;
		}
		
		override protected function on_Resize(e:Event):void
		{
			Aligner.alignMiddleHorizontalToBounds(bmp,W,0,106);
			area.width = W;
			area.height = H-126
			Aligner.alignMiddleHorizontalToBounds(info,W,0,bmp.y + 40);
		}
		
		
	}
}