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
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	
	public class InnovaKatSpot extends CasaSprite
	{
		/*private var innerCircle:CircleShape;
		private var outerCircle:CircleShape;
		*/
		private var tfNum:ATextSingleLine;
		private var tfInfo:ATextSingleLine;
		private var spot:MovieClip = new Spot();
		private var num:String;
		private var info : String;
		
		
		public function InnovaKatSpot(num:String,info:String,_x:int,_y:int)
		{
			this.num  = num;
			this.info = info;
			this.x = _x;
			this.y = _y;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			this.mouseChildren = false;
			
			
			/*innerCircle = new CircleShape(new Point(0,0),15,new FillStyle(Globals.Style.global.color.@blue,0.8));
			addChild(innerCircle);
			
			outerCircle = new CircleShape(new Point(0,0),24,new FillStyle(0,0),new LineStyle(3,Globals.Style.global.color.@blue,0.8));
			addChild(outerCircle);*/
			addChild(spot);
			tfNum = new ATextSingleLine(num,Globals.css[5].name,Globals.css[5].color,Globals.css[5].size);
			addChild(tfNum);
			
			Aligner.alignCenter(tfNum,spot,-tfNum.width+15,-tfNum.height+4);
			
			tfInfo = new ATextSingleLine(info,Globals.css[6].name,Globals.css[6].color,Globals.css[6].size);
			addChild(tfInfo);
			Aligner.alignCenter(tfInfo,tfNum,-tfInfo.width*0.5,25);
		}
	}
}