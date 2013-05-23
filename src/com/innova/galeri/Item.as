package src.com.innova.galeri
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.AText;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	
	public class Item extends CasaSprite
	{
		public var rect:RectShape;
		private var clickedColor:uint;
		private var color:uint;
		private var rectw:int;
		private var recth:int;
		
		private var bmp:Bitmap;
		private var bmpw:int;
		private var bmph:int;
		
		private var tf:AText;
		private var info:String;
		
		
		public function Item(bmp:Bitmap,info:String,_name:String,bmpw:int=159,bmph:int=96,rectw:int=180,recth:int=190,color:uint=0xb1b0a7)
		{
			this.color = color;
			this.recth = recth;
			this.rectw = rectw;
			this.bmp = bmp;
			this.bmpw = bmpw;
			this.bmph = bmph;
			this.info = info;
			this.name = _name;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			rect = new RectShape(new Rectangle(0,0,rectw,recth),new FillStyle(color));
			addChild(rect);
			
			addChild(bmp);
			Aligner.alignCenter(bmp,rect,0,-74);
			
			tf = new AText(Globals.css[2].name,this.info,this.bmpw,Globals.css[2].size,Globals.css[2].color,false,false,"left",false);
			addChild(tf);
			tf.y = bmp.y+bmp.height + 3;
			tf.x = bmp.x;
			
		}
		
		public function setRectColor(clickedColor:uint):void
		{
			var my_color:ColorTransform = new ColorTransform();
			my_color.color = clickedColor;
			rect.transform.colorTransform = my_color;
		}
	}
}