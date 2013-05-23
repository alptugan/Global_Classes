package src.com.innova.panaroma
{
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	
	public class YakinlasButtonClass extends CasaSprite
	{
		
		[Embed(source="assets/images/panaroma/yakicon.png")]
		protected var YakinIconClass:Class;
		
		[Embed(source="assets/images/panaroma/yakuz.png")]
		protected var BgClass:Class;
		
		private var rect:Bitmap;
		private var yakinIcon:Bitmap;
		
		
		
		private var tf:ATextSingleLine;
		private var txt:String;
		
		public function YakinlasButtonClass(txt:String="YAKINLAŞ")
		{
			this.txt = txt;
			this.mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			
			rect = new BgClass() as Bitmap
			addChild(rect);
			
			yakinIcon = new YakinIconClass() as Bitmap
			addChild(yakinIcon);
			
			yakinIcon.x = 11;
			yakinIcon.y = 16;
			
			// Text
			tf = new ATextSingleLine(txt,Globals.css[9].name,Globals.css[9].color,Globals.css[9].size);
			addChild(tf);
			tf.x = 55;
			tf.y = 26;
			
		}
		
		public function onMouseDown(color:uint=0x7ac4e0):void
		{
				TweenMax.to(rect,0.5,{tint:color,ease:Expo.easeOut});
		}
		
		public function onMouseUp():void
		{
			TweenMax.to(rect,0.5,{tint:null,ease:Expo.easeOut});
		}
	}
}