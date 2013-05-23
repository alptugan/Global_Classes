package com.alptugan.media
{
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.text.ATextSingleLine;
	import com.alptugan.utils.Colors;
	import com.everydayflash.equalizer.*;
	import com.everydayflash.equalizer.color.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.AudioLoad;
	
	import src.com.galea.Globals;
	
	public class Mp3BgPlayer extends CasaSprite
	{

		public var _audioLoad:AudioLoad;
		private var channel:SoundChannel = new SoundChannel();
		public var isPlaying:Boolean = true;
		private var _percentage:String;

		public var src:String;
		private var isStop:Boolean;

		private var tx:ATextSingleLine;
		private var isVisible:Boolean;

		private var st:SoundTransform;
		private var _volume : Number = 0.7;
		
		public function Mp3BgPlayer(src:String,isStop:Boolean = false,isVisible:Boolean=true)
		{
			super();
			this.src = src;
			this.isStop = isStop;
			this.isVisible = isVisible;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		public function get percentage():String
		{
			return _percentage;
		}
		
		public function set volume(val:Number):void
		{
			_volume = val;
			setVolume();
			
		}
		
		private function setVolume():void
		{
			st = channel.soundTransform;
			st.volume = _volume; // set to 70% volume
			channel.soundTransform = st;
		}
		
		protected function onAdded(e:Event):void
		{			
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			this._audioLoad = new AudioLoad(src);
			this._audioLoad.addEventListener(LoadEvent.COMPLETE, this._onComplete);
			this._audioLoad.addEventListener(LoadEvent.PROGRESS, this._onProgress);
			
			this._audioLoad.start();

			
			if(this.isVisible)
			{
				var es:EqualizerSettings = new EqualizerSettings();
				es.numOfBars = 4;
				es.height = 11;
				es.barSize = 4;
				es.vgrid = true;
				es.hgrid = 0;
				es.colorManager = new SolidBarColor(0xFFFFFFFF);
				es.effect = EqualizerSettings.FX_NONE;
				
				tx = new ATextSingleLine(Globals.Language == "tr" ? "SES AÇ / KAPA" : "SOUND ON / OFF","regular",Colors.cBlack,9,false,false);
				addChild(tx);
				
				tx.y = 2;
				
				var eq:Equalizer = new Equalizer();
				eq.update(es);
				addChild(eq);
				
				eq.x = tx.width + 5;
				
				this.alpha = 0.55;
				
				
				
				this.mouseChildren = false;
				this.buttonMode = true;
				
				this.addEventListener(MouseEvent.CLICK,onClick);
				this.addEventListener(MouseEvent.MOUSE_OVER,onOver);
				this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
				
				addEventListener(Event.ENTER_FRAME, eq.render);
			}
			
		}
		
		protected function onSoundComplete(event:Event):void
		{
				
				channel = this._audioLoad.sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
				setVolume();
			
			
		}
		protected function _onComplete(e:LoadEvent):void {
			this._audioLoad.removeEventListener(LoadEvent.COMPLETE, this._onComplete);
			this._audioLoad.removeEventListener(LoadEvent.PROGRESS, this._onProgress);
			if(this.isVisible)
			tx.SetText(Globals.Language == "tr" ? "SES AÇ / KAPA" : "SOUND ON / OFF");
			if(!isStop)
			{
				channel = this._audioLoad.sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
				setVolume();
			}
			
			dispatchEvent(new Event("loaded"));
		}
		
		private function _onProgress(e:LoadEvent):void {
			
			if(this.isVisible)
			{
				_percentage =  "% " + String(int(e.progress)*100) + " yüklendi";
				tx.tf.htmlText = _percentage;
			}
			
		}
	
		
		protected function onOver(event:MouseEvent):void
		{if(this.isVisible)
			this.alpha = 1;
		}
		
		protected function onOut(event:MouseEvent):void
		{if(this.isVisible)
			this.alpha = 0.55;
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if (isPlaying) 
			{
				this.channel.stop() ;
				isPlaying = false;
			}else{
				channel = this._audioLoad.sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
				isPlaying = true;
			}
			setVolume();
			
		}
		
		public function stop():void
		{
			this.channel.stop() ;
			isPlaying = false;
			setVolume();
		}
		
		public function play():void
		{
			channel = this._audioLoad.sound.play();
			channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
			isPlaying = true;
			setVolume();
		}
	}
}