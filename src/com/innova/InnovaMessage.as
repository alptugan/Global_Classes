package src.com.innova
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.AText;
	import com.alptugan.valueObjects.TextFormatVO;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	public class InnovaMessage extends CasaSprite
	{
		[Embed(source="assets/images/message.png")]
		protected var MessagePane:Class;
		
		private var message:CasaSprite;
		public var tf:AText;
		private var src:String;
		private var katlar:Boolean ;
		
		
		public function InnovaMessage(src:String,katlar:Boolean = false)
		{
			this.src = src;
			this.katlar = katlar;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			message = new CasaSprite();
			addChild(message);
			
			message.addChild(new MessagePane() as Bitmap);
			tf = new AText(Globals.css[0].name,this.src,Globals.css[0].width,Globals.css[0].size,this.katlar ? Globals.css[0].color : Globals.css[3].color,false,false,"center");
			addChild(tf);

			Aligner.alignCenter(tf,message);
			dispatchEvent(new Event('addedtostage'));
		}
		
		public function setMessage(src:String,type:String=""):void
		{
			tf.setText(src,type);
			tf.y = (message.height - tf._tf.textHeight) >> 1;
		}
		
		public function setTextFormat(fmk:Vector.<TextFormatVO>):void
		{
			tf.setTextFormat(fmk);
		}
		
		public function getMessage():String
		{
			return tf._tf.text;
		}
	}
}