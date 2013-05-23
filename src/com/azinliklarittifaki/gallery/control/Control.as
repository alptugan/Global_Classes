package src.com.azinliklarittifaki.gallery.control
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	
	public class Control extends CasaSprite
	{
		[Embed(source="assets/btn-left.jpg")]
		protected var leftBtn:Class;
		
		[Embed(source="assets/btn-right.jpg")]
		protected var rightBtn:Class;
		
		[Embed(source="assets/btn-info.jpg")]
		protected var infoBtn:Class;
		
		[Embed(source="assets/btn-thumb.jpg")]
		protected var thumbBtn:Class;
		
		
		private var left:CasaSprite;
		private var right:CasaSprite;
		private var thumb:CasaSprite;
		private var info:CasaSprite;
		
		
		public function Control()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			// Left
			left = new CasaSprite();
			left.name = "l";
			addChild(left);
			
			left.addChild(new leftBtn() as Bitmap);
			left.alpha = 0.2;
			left.buttonMode = true;
			left.x = 0;
			
			
			//thumb
			thumb = new CasaSprite();
			thumb.name = "t";
			addChild(thumb);
			
			thumb.addChild(new thumbBtn() as Bitmap);
			thumb.alpha = 0.2;
			thumb.buttonMode = true;
			thumb.x = left.x + left.width + 1;
			
			//info
			info = new CasaSprite();
			info.name = "i";
			addChild(info);
			
			info.addChild(new infoBtn() as Bitmap);
			info.alpha = 0.2;
			info.buttonMode = true;
			info.x = thumb.x + thumb.width + 1;
			
			
			// Right
			right = new CasaSprite();
			right.name = "r";
			addChild(right);
			
			right.addChild(new rightBtn() as Bitmap);
			right.alpha = 0.2;
			right.buttonMode = true;
			right.x = info.x + info.width + 1;
			
		}
	}
}