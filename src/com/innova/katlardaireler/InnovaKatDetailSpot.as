package src.com.innova.katlardaireler
{
	import com.alptugan.drawing.shape.CircleShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.LineStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	
	public class InnovaKatDetailSpot extends CasaSprite
	{
		/*private var innerCircle:CircleShape;
		private var outerCircle:CircleShape;
		*/
		
		private var spot:MovieClip = new Spot();
		private var tfInfo:AText;
		
		private var info : String;
		public var orjW:Number ;
		public var orjH:Number;
		public var orjX:Number;
		public var orjY:Number;
		
		public function InnovaKatDetailSpot(info:String,_x:int,_y:int)
		{
			this.info = info;
			this.x = _x;
			this.y = _y;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			this.mouseChildren = false;
			
			/*
			innerCircle = new CircleShape(new Point(0,0),15,new FillStyle(Globals.Style.global.color.@blue,0.8));
			addChild(innerCircle);
			
			outerCircle = new CircleShape(new Point(0,0),24,new FillStyle(0,0),new LineStyle(3,Globals.Style.global.color.@blue,0.8));
			addChild(outerCircle);*/
			
			addChild(spot);
			
			tfInfo = new AText(Globals.css[5].name,info,150,Globals.css[5].size,Globals.css[5].color,false,false,"center");
			addChild(tfInfo);
			Aligner.alignCenter(tfInfo,spot,-tfInfo._tf.textWidth*0.5 + 15,-tfInfo._tf.textHeight+25);
		}
	}
}