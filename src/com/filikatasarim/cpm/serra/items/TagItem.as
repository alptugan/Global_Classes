package src.com.filikatasarim.cpm.serra.items
{
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.display.Gradient_Bg;
	import com.alptugan.drawing.shape.RoundRectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class TagItem extends CasaSprite
	{
		private var str:String;
		private var color:uint = 0xffffff;
		private var rectcolor:uint = 0xc5c2b3;
		private var fontSize:int = 47;
		private var txt:ATextSingleLine;
		private var rect:RoundRectShape;
		private var gradBox:Gradient_Bg;
		
		public var catId:int;
		public var subCatId:int;
		
		public function TagItem(str:String)
		{
			this.str = str;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.mouseChildren = false;
			txt = new ATextSingleLine(str,FontNamesFB.medium,color,fontSize);
			addChild(txt);
			
			
			rect = new RoundRectShape(new Rectangle(0,0,txt.tf.textWidth+60,txt.tf.textHeight+10),new FillStyle(rectcolor),null,3,3,3,3);
			addChildAt(rect,0);
			
			gradBox = new Gradient_Bg(txt.tf.textWidth+60,txt.tf.textHeight+10,[0xbe9f58,0x857040],GradientType.LINEAR);
			addChildAt(gradBox,0);
			gradBox.mask = rect;
			
			Aligner.alignCenterMiddleToBounds(txt,gradBox.width,gradBox.height,-2,22);
		}
		
		
	}
}