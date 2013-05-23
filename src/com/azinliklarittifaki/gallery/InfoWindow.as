package src.com.azinliklarittifaki.gallery
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.AText;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class InfoWindow extends CasaSprite
	{
		private var rect:RectShape;
		private var text:String;
		public var tf:AText;
		private var params:Object;
		
		
		public function InfoWindow(params:Object)
		{
			this.params = params;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			tf   = new AText(params.fontName,params.text,params.w-30,params.fontSize,params.color,true,false,params.align,true);
			addChild(tf);
			
			rect = new RectShape(new Rectangle(0,0,params.w,params.h),new FillStyle(0,0.8));
			addChildAt(rect,0);
			
			rect.height = tf.height + 30;
			
			Aligner.alignCenter(tf,rect,0,10);
			
		}
	}
}