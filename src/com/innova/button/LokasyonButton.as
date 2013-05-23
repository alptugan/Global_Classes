package src.com.innova.button
{
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	
	public class LokasyonButton extends CasaSprite
	{
		
		[Embed(source="assets/images/lokasyon/btn-bg.png")]
		protected var ButtonClass:Class;
		
		[Embed(source="assets/images/lokasyon/btn-clicked.png")]
		protected var ClickedButtonClass:Class;
		
		private var ButtonClicked:CasaSprite;
		private var Button:CasaSprite;
		private var txt:String;
		public var bmp:Bitmap;

		private var tf:ATextSingleLine;
		
		public var src:String;
		
		public function LokasyonButton(txt:String)
		{
			this.txt = txt;
			this.mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			Button = new CasaSprite();
			addChild(Button);
			
			Button.addChild(new ButtonClass() as Bitmap);
			
			ButtonClicked = new CasaSprite();
			addChild(ButtonClicked);
			ButtonClicked.alpha = 0;
			ButtonClicked.addChild(new ClickedButtonClass() as Bitmap);
			
			tf = new ATextSingleLine(txt,Globals.css[4].name,Globals.css[4].color,Globals.css[4].size);
			addChild(tf);
			
			Aligner.alignCenter(tf,this,0,-6);
			
		}
		
		public function setClicked():void
		{
			TweenMax.to(Button,0.2,{tint:0xffffff,ease:Strong.easeOut,onComplete:function():void{
				
				TweenMax.to(tf,0.2,{tint:Globals.css[4].hovercolor,ease:Strong.easeOut});
				TweenMax.to(ButtonClicked,0.3,{alpha:1,ease:Strong.easeOut});
			
			}});
			
		}
		
		public function setUnClicked():void
		{
			TweenMax.to(tf,0.3,{tint:Globals.css[4].color,ease:Strong.easeOut});
			TweenMax.to(Button,0.3,{tint:null,ease:Strong.easeOut});
			TweenMax.to(ButtonClicked,0.3,{alpha:0,ease:Strong.easeOut});
		}
	}
}