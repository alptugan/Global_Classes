package src.com.alptugan.textexplode
{
	import com.alptugan.drawing.shape.CircleShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.casalib.display.CasaSprite;
	
	public class CircleButton extends CasaSprite
	{
		private var message:com.alptugan.text.AText;
		private var src:Object = {};
		private var color:uint;
		private var rad:Number;
		
		public function CircleButton(src:Object,color:uint,rad:Number)
		{
			this.src   = src;
			this.color = color;
			this.rad   = rad;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			
			this.mouseChildren = false;
			this.buttonMode = true;
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			var s:CircleShape = new CircleShape(new Point(0,0),rad,new FillStyle(color,0.6));
			addChild(s);
			
			message = new com.alptugan.text.AText(this.src.name,this.src.text,rad*2,this.src.size,this.src.color,false,false,"center");
			addChild(message);
			message.alpha = 0.8;
			message.x = (s.width - message.width) * 0.5 - (rad-25);
			message.y = (s.height - message.height) * 0.5 - (rad-10);
			
		}
	}
}