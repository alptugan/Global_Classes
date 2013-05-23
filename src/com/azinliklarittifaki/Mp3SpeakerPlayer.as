package src.com.azinliklarittifaki
{
	import com.alptugan.globals.Root;
	import com.alptugan.media.Mp3BgPlayer;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	public class Mp3SpeakerPlayer extends Root
	{
		[Embed(source="assets/sound-on.png")]
		protected var SoundOnClass:Class;
		
		[Embed(source="assets/sound-off.png")]
		protected var SoundOffClass:Class;
		
		private var Off:CasaSprite;
		
		
		
		private var On:CasaSprite;
		
		
		private var player:Mp3BgPlayer;

		public function Mp3SpeakerPlayer()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			// Load MP3
			player = new Mp3BgPlayer("assets/noiz.mp3",false,false);
			addChild(player);
			
			On = new CasaSprite();
			On.name = "on";
			addChild(On);
			
			
			Off = new CasaSprite();
			Off.name = "off";
			addChild(Off);
			
			Off.visible = false;
			Off.alpha = 0;
			
			Off.addChild(new SoundOffClass() as Bitmap);
			
			On.addChild(new SoundOnClass() as Bitmap);
			
			this.addEventListener(MouseEvent.CLICK,onClickSwitch);
			
		}
		
		protected function onClickSwitch(e:MouseEvent):void
		{
			if(player.isPlaying )
			{
				player.stop();
				TweenMax.to(Off,0.5,{autoAlpha:1,ease:Expo.easeOut});
				TweenMax.to(On,0.5,{autoAlpha:0,ease:Expo.easeOut});
			}else{
				player.play();
				TweenMax.to(Off,0.5,{autoAlpha:0,ease:Expo.easeOut});
				TweenMax.to(On,0.5,{autoAlpha:1,ease:Expo.easeOut});
			}
		}
	}
}