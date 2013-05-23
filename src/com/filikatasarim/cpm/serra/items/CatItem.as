package src.com.filikatasarim.cpm.serra.items
{
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.display.Gradient_Bg;
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class CatItem extends CasaSprite
	{
		private var str:String;
		private var color:uint = 0xffffff;
		private var rectcolor:uint = 0xd98828;
		private var fontSize:int = 47;
		private var rect:RectShape;
		private var txt:ATextSingleLine;
		
		private var bgRect:RectShape;
		private var bgRectColor:uint = 0xc5c2b3;
		private var w:int = 395;
		private var h:int = 198;
		
		private var bmp:Bitmap;
		public var id:int;
		
		public var X:Number,Y:Number;
		private var gradBox:Gradient_Bg;
		public function CatItem(str:String,bmp:Bitmap)
		{
			this.str = str;
			this.bmp = bmp;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			/*bgRect = new RectShape(new Rectangle(0,0,w,h),new FillStyle(bgRectColor));
			addChild(bgRect);
			*/
			
			this.scaleX = this.scaleY = 0.9;
			
			
			rect   = new RectShape(new Rectangle(0,0,w,74),new FillStyle(rectcolor));
			addChild(rect);
			
			txt = new ATextSingleLine(str,FontNamesFB.medium,color,fontSize);
			addChild(txt);
			
			gradBox = new Gradient_Bg(w,txt.tf.textHeight+10,[0xbe9f58,0x857040],GradientType.LINEAR);
			addChildAt(gradBox,0);
			gradBox.mask = rect;
			
			
			
			txt.x = rect.x + 20;
			txt.y = rect.y + 18;
			
			bmp.smoothing = true;
			
			//area.preview = true;
			addChild(bmp);
			var area:AutoFitArea = new AutoFitArea(this,0,0,w,h);
			area.attach(bmp);
			
			bmp.y = gradBox.height;
		}
	}
}