package com.alptugan.Media
{
	import alptugan.Events.MediaPlayerEvent;
	import alptugan.Preloader.PreloaderUranium;
	
	import com.kusina.Globals;
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.system.Security;
	
	import org.casalib.display.CasaMovieClip;
	import org.casalib.events.VideoLoadEvent;
	import org.casalib.load.VideoLoad;
	
	Security.allowDomain("*");
	public class FlvPlayer extends Sprite
	{
		public static var Title : String,SubTitle:String;
		public static var fSource  : String;
		private static var C  : FlvPlayerInterface,videoSnd:SoundTransform;
		private var transTime : Number;
		private var intVolume : Number;
		public var Pxml:XML,Ph:int,Pw:int,Pc:uint;
		public static var videoLoad:VideoLoad,isPlaying:Boolean = false,isStop:Boolean = false;
		private var scaleFac : Number;
		private var Pre:PreloaderUranium;
		private var BolisLoaded : Boolean = false;
		
		public function FlvPlayer (_fSource:String,Pxml:XML,Pw:int,Ph:int,Pc:uint,bolPl:Boolean = true)
		{
			fSource   = _fSource;
			this.Pxml = Pxml;
			this.Ph   = Ph;
			this.Pw   = Pw;
			this.Pc   = Pc;
			addEvent(this,Event.ADDED_TO_STAGE, init);
			addEvent(this,Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function init(e:Event):void
		{
			CreateInteface();
			//
			
			removeEvent(this,Event.ADDED_TO_STAGE, init);
		}
		
		private function CreateInteface():void
		{
			
			C   = new FlvPlayerInterface(Pxml,Pw,Ph,Pc);
			C.addEventListener(MediaPlayerEvent.INTERFACE_LOADED,onInterfaceLoaded);
			addEvent(C,"playClicked", onPlayPauseClicked);
			addEvent(C,"sndClicked", onSoundClick);
			addChild(C);
			
		}
		
		private function onNetStatus (e:NetStatusEvent):void
		{
			switch (e.info.code) {
				// trace a messeage when the stream is not found
				case "NetStream.Play.StreamNotFound":
					trace("Stream not found: " );
					break;
				// when the video reaches its end, we check if there are
				// more video left or stop the player
				case "NetStream.Buffer.Empty":
					//preloader
					break;
				case "NetStream.Buffer.Full" :
					//preloader
					
					break;
				case "NetStream.Play.Stop":
					//preloader	
					videoLoad.netStream.seek(0);
					//videoLoad.netStream.pause();
					C.PlayPause_Btn.getChildByName("play").visible = true;
					C.PlayPause_Btn.getChildByName("pause").visible = false;
					isPlaying = false;
					isStop    = true;	
					break;
			}
		}
		
		
		private function onChange(e:MediaPlayerEvent):void
		{
			
			TweenLite.to(Pre,0.5,{alpha : 1,ease:Expo.easeOut});
			if(C.PlayList)
			{
				Title   = e.Title;
				C.TitleBar.setNewText(Title,e.SubTitle);
				fSource = e.Source;
			}
			
			C.RemoveListeners();
			removeEvent(videoLoad,VideoLoadEvent.PROGRESS, this._onProgress);
			removeEvent(videoLoad,VideoLoadEvent.BUFFERED, this._onBuffered);
			removeEvent(videoLoad.netStream,NetStatusEvent.NET_STATUS, onNetStatus);
			videoLoad.netStream.close();
			this.removeChild(videoLoad.video);
			videoLoad.destroy();
			
			C.PPauseClicked(null);
			videoLoad = new VideoLoad(fSource);//VIDEO-Alo Altair Value.mp4 "http://www.jinglemingle.net/VIDEO-Alo Altair Value.mp4"
			BolisLoaded = false;
			addEvent(videoLoad,VideoLoadEvent.PROGRESS, this._onProgress);
			addEvent(videoLoad,VideoLoadEvent.BUFFERED, this._onBuffered);
			addEvent(videoLoad.netStream,NetStatusEvent.NET_STATUS, onNetStatus);
			videoLoad.start();
			videoLoad.video.scaleX = scaleFac;
			videoLoad.video.scaleY = scaleFac;
			this.addChild(videoLoad.video);
			this.setChildIndex(Pre,numChildren-1);
			//C != null ? C.AddListeners() : void;
			videoLoad.netStream.play(fSource);
			//videoLoad.netStream.pause();
			C.PlayPause_Btn.getChildByName("play").visible = false;
			C.PlayPause_Btn.getChildByName("pause").visible = true;
		}
		
		private function onInterfaceLoaded (e:MediaPlayerEvent):void
		{
			//fSource = "http://www.jinglemingle.net/raysigorta.flv";
			videoLoad = new VideoLoad(fSource);//VIDEO-Alo Altair Value.mp4 "http://www.jinglemingle.net/VIDEO-Alo Altair Value.mp4"
			
			addEvent(videoLoad,VideoLoadEvent.PROGRESS, this._onProgress);
			addEvent(videoLoad,VideoLoadEvent.BUFFERED, this._onBuffered);
			//addEvent(videoLoad.video,Event.ADDED_TO_STAGE, onVideoAddedToStage);
			addEvent(videoLoad.netStream,NetStatusEvent.NET_STATUS, onNetStatus);
			//videoLoad.pauseStart = true;
			videoLoad.start();
			//videoLoad.netStream.bufferTime = 10;
			scaleFac = 385 / videoLoad.video.width;
			videoLoad.video.scaleX = scaleFac;
			videoLoad.video.scaleY = scaleFac;
			this.addChild(videoLoad.video);
			
			Pre = new  PreloaderUranium(Globals.Blue,Globals.GreyLine ,20);
			Pre.x = videoLoad.video.width >> 1;
			Pre.y = videoLoad.video.height >> 1;
			addChild(Pre);
			Pre.ShowTitle();
			C.BackGround.y = videoLoad.video.height + 20;
			C.PlayList ? addEvent(C.PlayList,MediaPlayerEvent.AUDIO_CHANGED, onChange) : void;
		}
		
		protected function _onProgress(e:VideoLoadEvent):void {
			//trace(e.millisecondsUntilBuffered + " milliseconds until buffered");
			//trace(e.progress.percentage + "% loaded");
			if(e.progress.percentage  == 100)
			{
				TweenLite.to(Pre,0.5,{alpha : 0,ease:Expo.easeOut});
				BolisLoaded = true;
			}
			
			//trace(e.buffer.percentage + "% buffered");
			//trace( "test from ", e.time);
		}
		
		protected function _onBuffered(e:VideoLoadEvent):void {
			//e.target.netStream.resume();
			C != null ? C.AddListeners() : void;
		}
		
		
		//==============================================================================================	
		// PLAY PAUSE BUTTON																								
		//==============================================================================================	
		private function onPlayPauseClicked (e:Event):void
		{
			if(!isPlaying)
			{
				isPlaying = true;
				if(isStop)
				{
					videoLoad.netStream.play(fSource);
					isStop = false;
				}else
					videoLoad.netStream.resume();
				C.PlayPause_Btn.getChildByName("pause").visible = true;
				C.PlayPause_Btn.getChildByName("play").visible = false;
				TweenLite.to(Pre,0.5,{alpha : 0,ease:Expo.easeOut});
			}else{
				(!BolisLoaded) ? TweenLite.to(Pre,0.5,{alpha : 1,ease:Expo.easeOut}) : void;
				videoLoad.netStream.pause();
				isPlaying = false;
				C.PlayPause_Btn.getChildByName("play").visible = true;
				C.PlayPause_Btn.getChildByName("pause").visible = false;
			}
			
		}
		
		//===============================================================================================	
		// SOUND VOLUME FUNCTIONS																								
		//===============================================================================================	
		private function onSoundClick (e:Event):void
		{
			if(videoSnd.volume > 0)
			{
				setVolume(.0);
			}else{
				setVolume(.8);
			}
			
		}
		//===============================================================================================	
		// SET VOLUME LEVEL WITH FADEOUT																								
		//===============================================================================================	
		public static function setVolume(_intVolume:Number = 0.8):void 
		{
			videoSnd = videoLoad.netStream.soundTransform;			
			videoSnd.volume = _intVolume;
			videoLoad.netStream.soundTransform = videoSnd;	
			TweenMax.to(C.Tracker_Snd.getChildByName("loaded"),0.2,{width:_intVolume * C.Pars.VO.wTbSoundDef, overwrite:1});
		}
		
		
		
		//===============================================================================================
		// ON STAGE RESIZE																		
		//===============================================================================================
		public function onResize(W:int, H:int):void
		{
			C.PlayList ? C.PlayList.onResize(W,H) : void;
		}
		
		
		
		private function onRemoved(e:Event):void
		{
			videoLoad.netStream.close();
			videoLoad.destroy();
			videoLoad.stop();
			removeEvent(this,Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		//================================================================================================	
		// GETTER AND SETTERS FOR NEW SOUND																				
		//================================================================================================		
		public function get SetVideo():String
		{
			return fSource;
		}
		
		public function set SetVideo(n:String):void
		{
			fSource=n;
		}
		
		public function get SetTitle():String
		{
			return Title;
		}
		
		public function set SetTitle(n:String):void
		{
			Title=n;
		}
		
		public function get SetSubTitle():String
		{
			return SubTitle;
		}
		
		public function set SetSubTitle(n:String):void
		{
			SubTitle=n;
		}
		
		private function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, true);
		}
		
		private function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
	}
}