package com.alptugan.Media
{
	
	import alptugan.Drawing.CustomShapes.SoundIcon;
	import alptugan.Drawing.CustomShapes.SoundIconOff;
	import alptugan.Drawing.Navigation.PauseButton;
	import alptugan.Drawing.Navigation.PlayButton;
	import alptugan.Drawing.Navigation.ShareButton;
	import alptugan.Drawing.Navigation.TrackerBarButton;
	import alptugan.Events.FontLoaderEvent;
	import alptugan.Events.MediaPlayerEvent;
	import alptugan.utils.ParseAudioXML;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import com.AudioPlayer.SoundTitle;
	import com.kusina.Globals;
	import com.ListManagerPlayList;
	import com.greensock.TweenMax;
	import com.greensock.plugins.GlowFilterPlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.URLResource;
	
	
	public class FlvPlayerInterface extends Sprite
	{
		public var Tracker_Bg           : Sprite ;
		public var Tracker_Snd          : Sprite ;
		public var Sound_Btn            : Sprite;
		public var PlayPause_Btn        : Sprite ;          
		
		public var BackGround          : Sprite;
		private var transTime : Number = 0.5;
		////////Time Preview/////////////////////////////
		public var txt                  : TextField;
		private var txt_fmt             : TextFormat;
		public static var Fonts:FlvFontClass;
		
		public var ILoader              : BulkLoader;
		public var Config               : XML;
		public var Fonts                : FlvFontClass;
		
		public var PlayList             : ListManagerPlayList,Pxml:XML,Ph:int,Pw:int,Pc:uint,bolPl:Boolean;
		public var Pars                 : ParseAudioXML;
		public var TitleBar             : SoundTitle   ;
		
		// timer for updating player (progress, volume...)
		public var tmrDisplay           :Timer;
		private const DISPLAY_TIMER_UPDATE_DELAY:int	= 10;
		private var BolClick            : Boolean;
		public var Share: ShareButton;
		
		
		public function FlvPlayerInterface (Pxml:XML,Pw:int,Ph:int,Pc:uint)
		{
			this.Pxml = Pxml;
			this.Ph   = Ph;
			this.Pw   = Pw;
			this.Pc   = Pc;
			this.bolPl= bolPl;
			addEvent(this,Event.ADDED_TO_STAGE, init);
			addEvent(this,Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function init(e:Event):void
		{
			Fonts  = new FlvFontClass("assets/font/Copy_Num.swf","");
			
			
			addEvent(Fonts,FontLoaderEvent.FONTS_LOADED,onFontLoaded);
			addChild(Fonts);
			
			removeEvent(this,Event.ADDED_TO_STAGE, init);
		}
		
		private function onFontLoaded(e:FontLoaderEvent):void
		{
			removeEvent(Fonts,FontLoaderEvent.FONTS_LOADED,onFontLoaded);
			
			ILoader = new BulkLoader("foo");
			ILoader.add("mp3_data/config.xml",{id:"XML"});
			addEvent(ILoader,BulkLoader.COMPLETE, onCompleteInternal);
			
			ILoader.start();
		}
		
		private function onCompleteInternal(e:Event):void
		{	
			
			Config = ILoader.getXML("XML");
			Pars = new ParseAudioXML(Config);
			BackGroundPanel(0,0,Pars.VO.ClBg,Pars.VO.wBg,Pars.VO.hBg,Pars.VO.ehBg,Pars.VO.ewBg);
			AddTimePreview(Pars.VO.ClTxt,Pars.VO.xTxt,Pars.VO.yTxt,6);
			
			Tracker_Bg = new Sprite();
			Tracker_Snd = new Sprite();
			Sound_Btn = new Sprite();
			PlayPause_Btn = new Sprite();
			//AddListeners();
			BackGround.addChild(PlayPause_Btn);
			BackGround.addChild(Tracker_Bg);
			BackGround.addChild(Sound_Btn);
			BackGround.addChild(Tracker_Snd);
			var Play_Btn  : PlayButton       = new PlayButton(Pars.VO.wPlayPause,Pars.VO.hPlayPause,Pars.VO.ClPlayPause,Pars.VO.xPlayPause,Pars.VO.yPlayPause);
			var Pause_Btn : PauseButton      = new PauseButton(Pars.VO.wPause,Pars.VO.hPause,Pars.VO.ClPause,Pars.VO.xPause,Pars.VO.yPause);
			var TbLoaded  : TrackerBarButton = new TrackerBarButton(Pars.VO.wTbDef,Pars.VO.hTbDef,Pars.VO.ewTbDef,Pars.VO.ehTbDef,Pars.VO.ClTbLoaded,Pars.VO.xTbDef,Pars.VO.yTbDef,"loaded");
			var TbDef     : TrackerBarButton = new TrackerBarButton(Pars.VO.wTbDef,Pars.VO.hTbDef,Pars.VO.ewTbDef,Pars.VO.ehTbDef,Pars.VO.ClTbDef,Pars.VO.xTbDef,Pars.VO.yTbDef,"default");
			var TbPlayed  : TrackerBarButton = new TrackerBarButton(Pars.VO.wTbDef,Pars.VO.hTbPlayed,Pars.VO.ewTbDef,Pars.VO.ehTbDef,Pars.VO.ClTbPlayed,Pars.VO.xTbDef,Pars.VO.yTbPlayed,"played");
			var SndIco    : SoundIcon        = new SoundIcon(Pars.VO.ClSoundIco,Pars.VO.xSoundIco,Pars.VO.ySoundIco);
			var SndIcoOff : SoundIconOff     = new SoundIconOff(Pars.VO.ClSoundIco,Pars.VO.xSoundIco,Pars.VO.ySoundIco);
			var TbSndDef  : TrackerBarButton = new TrackerBarButton(Pars.VO.wTbSoundDef,Pars.VO.hTbSoundDef,Pars.VO.ewTbSoundDef,Pars.VO.ehTbSoundDef,Pars.VO.ClTbSoundDef,Pars.VO.xTbSoundDef,Pars.VO.yTbSoundDef,"default");
			var TbSndLoaded : TrackerBarButton = new TrackerBarButton(Pars.VO.wTbSoundDef,Pars.VO.hTbSoundCurr,Pars.VO.ewTbSoundDef,Pars.VO.ehTbSoundDef,Pars.VO.ClTbSoundCurr,Pars.VO.xTbSoundDef,Pars.VO.yTbSoundCurr,"loaded");
			
			TbLoaded.scaleX = 0.0;
			TbPlayed.scaleX = 0.0;
			TbSndLoaded.scaleX = 0.8;
			Play_Btn.visible = false;
			Pause_Btn.visible = true;
			SndIcoOff.visible = false;
			Tracker_Bg.addChild(TbDef);
			Tracker_Bg.addChild(TbLoaded);
			Tracker_Bg.addChild(TbPlayed);
			PlayPause_Btn.addChild(Play_Btn);	
			PlayPause_Btn.addChild(Pause_Btn);	
			Sound_Btn.addChild(SndIco);
			Sound_Btn.addChild(SndIcoOff);
			Tracker_Snd.mouseChildren = false;
			Tracker_Snd.buttonMode    = true;
			Tracker_Snd.addChild(TbSndDef);
			Tracker_Snd.addChild(TbSndLoaded);
			
			Tracker_Bg.mouseChildren = false;
			Tracker_Bg.buttonMode = true;
			
			removeEvent(ILoader,BulkLoader.COMPLETE, onCompleteInternal);
			
			if(bolPl)
			{
				//Show PlayList
				PlayList = new ListManagerPlayList(Pxml,Pw,Ph,Pc);
				PlayList.x = Pars.VO.wBg + 32;
				//If some item is clicked on playlist stop current sound and load new one
				
				addChild(PlayList);
				
				//Add title
				FlvPlayer.Title       = PlayList.VO[0].title;
				FlvPlayer.SubTitle    =  PlayList.VO[0].subtitle;
			}
			
			
			
			TitleBar    = new SoundTitle(FlvPlayer.Title, FlvPlayer.SubTitle); 
			TitleBar.x = 3;
			TitleBar.y = 2;
			BackGround.addChild(TitleBar);
			
			//Add Share Button
			Share = new ShareButton(Globals.Language == "en" ? "SHARE" : "PAYLAŞ", 1,6,Globals.Blue,Globals.BgColor,11,4,49,15);
			addEvent(Share,MouseEvent.CLICK,onClickShare);
			BackGround.addChild(Share);
			Share.x = BackGround.width - Share.width - 2;
			Share.y  = TitleBar.y + 1;
			
			ILoader.clear();
			ILoader.removeAll();
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.INTERFACE_LOADED));
			
		}
		
		private function onClickShare (e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://www.facebook.com/sharer.php?u="+FlvPlayer.fSource+"&t="+FlvPlayer.Title), "_blank");
		}
		
		//================================================================================================	
		// EVENT LISTENERS																								
		//================================================================================================	
		public function AddListeners():void
		{
			/**Play-Pause Button Event Listeners**/
			addEvent(PlayPause_Btn,MouseEvent.CLICK,PPauseClicked);
			addEvent(PlayPause_Btn,MouseEvent.MOUSE_OVER, onOver);
			addEvent(PlayPause_Btn,MouseEvent.MOUSE_OUT, onOut);
			
			/**Sound On / Off Button Event Listeners**/
			addEvent(Sound_Btn,MouseEvent.CLICK, onSoundClick);
			addEvent(Sound_Btn,MouseEvent.MOUSE_OVER, onOver);
			addEvent(Sound_Btn,MouseEvent.MOUSE_OUT, onOut);
			
			/**Tracker Event Listener**/
			addEvent(Tracker_Bg,MouseEvent.MOUSE_DOWN,onMouseDownTracker);
			addEvent(Tracker_Bg,MouseEvent.MOUSE_UP,onMouseUpTracker);
			addEvent(Tracker_Snd,MouseEvent.MOUSE_DOWN,setSndVolWithTracker);
			addEvent(Tracker_Snd,MouseEvent.MOUSE_UP,setSndVolWithTracker);
			//addEvent(Tracker_Bg,Event.ENTER_FRAME, calcProgress);
			tmrDisplay = new Timer(DISPLAY_TIMER_UPDATE_DELAY);
			addEvent(tmrDisplay,TimerEvent.TIMER, calcProgress);
			tmrDisplay.start();
		}
		
		public function PPauseClicked (e:MouseEvent):void
		{
			/*if(PlayPause_Btn.getChildByName("play").visible)
			{
			PlayPause_Btn.getChildByName("play").visible = false;
			PlayPause_Btn.getChildByName("pause").visible = true;
			}else{
			PlayPause_Btn.getChildByName("play").visible = true;
			PlayPause_Btn.getChildByName("pause").visible = false;
			}*/
			dispatchEvent(new Event("playClicked"));
		}
		
		//================================================================================================
		// PROGRESS OF TRACKER BAR																						
		//================================================================================================
		private function onMouseDownTracker(e:MouseEvent):void 
		{
			BolClick = true;
			var p:int = FlvPlayer.videoLoad.duration * (e.currentTarget.mouseX - Tracker_Bg.getChildByName("default").x) / Tracker_Bg.width;
			FlvPlayer.videoLoad.netStream.seek(p);
			Tracker_Bg.getChildByName("played").width = (e.currentTarget.mouseX - Tracker_Bg.getChildByName("default").x) ;
		}
		
		private function onMouseUpTracker (e:MouseEvent):void
		{
			BolClick = false;
		}
		
		//================================================================================================	
		// UPDATE TRACKER POSITION															
		//================================================================================================		
		public function calcProgress(e:Event):void
		{		
			var LoadedStream : Number = (FlvPlayer.videoLoad.netStream.bytesLoaded  / FlvPlayer.videoLoad.netStream.bytesTotal)* Tracker_Bg.getChildByName("default").width ;
			var PlayedStream : Number = ((Tracker_Bg.width * FlvPlayer.videoLoad.netStream.time) / FlvPlayer.videoLoad.metaData.duration);
			Tracker_Bg.getChildByName("loaded").width = LoadedStream;
			Tracker_Bg.getChildByName("played").width = PlayedStream;
			txt.htmlText             = formatTime(FlvPlayer.videoLoad.netStream.time )+"<font color='#0074D9'>"+"·"+"</font>"+formatTime(FlvPlayer.videoLoad.metaData.duration);
		}
		
		private function formatTime(t:int):String {
			// returns the minutes and seconds with leading zeros
			// for example: 70 returns 01:10
			var s:int = Math.round(t);
			var m:int = 0;
			if (s > 0) {
				while (s > 59) {
					m++; s -= 60;
				}
				return String((m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s);
			} else {
				return "00:00";
			}
		}
		
		private function onSoundClick (e:MouseEvent):void
		{
			if(Sound_Btn.getChildByName("SoundIco").visible)
			{
				Sound_Btn.getChildByName("SoundIco").visible = false;
				Sound_Btn.getChildByName("SoundIcoOff").visible = true;
			}else{
				Sound_Btn.getChildByName("SoundIco").visible = true;
				Sound_Btn.getChildByName("SoundIcoOff").visible = false;
			}
			dispatchEvent(new Event("sndClicked"));
		}
		
		//===============================================================================================	
		private function setSndVolWithTracker(e:MouseEvent):void
			//===============================================================================================
		{
			if(e.type == "mouseDown")
			{
				FlvPlayer.setVolume(((e.stageX - Pars.VO.xTbSoundDef - parent.parent.parent.parent.x + 2) / Pars.VO.wTbSoundDef));
				addEvent(Tracker_Snd,MouseEvent.MOUSE_MOVE, onSndTbMove);
				addEvent(Tracker_Snd,MouseEvent.MOUSE_OUT, onSndTbOut);
			}else{
				removeEvent(Tracker_Snd,MouseEvent.MOUSE_MOVE, onSndTbMove);
				removeEvent(Tracker_Snd,MouseEvent.MOUSE_OUT, onSndTbOut);
			}
		}
		//===============================================================================================	
		private function onSndTbOut(e:MouseEvent):void
			//===============================================================================================
		{
			removeEvent(Tracker_Snd,MouseEvent.MOUSE_MOVE, onSndTbMove);
			removeEvent(Tracker_Snd,MouseEvent.MOUSE_OUT, onSndTbOut);
		}
		//===============================================================================================
		private function onSndTbMove(e:MouseEvent):void
			//===============================================================================================
		{
			FlvPlayer.setVolume(((e.stageX - Pars.VO.xTbSoundDef - parent.parent.parent.parent.x + 2) / Pars.VO.wTbSoundDef));
		}
		
		//===============================================================================================
		// MOUSE OVER MOUSE OUT FUNCTIONS																				
		//===============================================================================================
		private function onOver(e:MouseEvent):void
		{
			TweenMax.to(e.target, transTime, {alpha:1});	
			TweenMax.to(e.target, transTime, {glowFilter:{color:Config.mouse_over_color, alpha:1,blurX:3, blurY:3,overwrite:1}});	
		}
		
		private function onOut(e:MouseEvent):void
		{
			TweenMax.to(e.target, transTime, {alpha:0.8});	
			TweenMax.to(e.target, transTime, {glowFilter:{color:Config.mouse_over_color, alpha:0,blurX:3, blurY:3,overwrite:1}});	
		}
		
		
		/****************************************************************************************************************
		 * TIME PREVIEW																									*
		 ****************************************************************************************************************/
		private function AddTimePreview(c:uint, X:int,Y:int,size:Number = 9):void
		{
			txt                   = new TextField();
			txt.embedFonts = true;
			txt.selectable           = false;
			txt.multiline            = false;
			txt.wordWrap             = false;
			txt.autoSize             = "left";
			txt.antiAliasType     = AntiAliasType.ADVANCED;
			txt_fmt               = new TextFormat();
			
			txt_fmt.font          = FlvFontClass.InputFont.fontName;
			txt_fmt.size          = size;//Config.time_preview.@size;
			txt_fmt.color         = c;
			txt_fmt.letterSpacing = 0.5;
			txt.defaultTextFormat = txt_fmt;
			txt.x                 = X;
			txt.y                 = Y;
			txt.htmlText          = "00:00"+"<font color='#0074D9'>"+"·"+"</font>"+"00:00";
			BackGround.addChild(txt);		
			
		}
		
		/****************************************************************************************************************
		 * BACKGROUND GRAPHICS																							*
		 ****************************************************************************************************************/
		private function BackGroundPanel(X:int,Y:int,Color:uint,w:int,h:int,eW:int = 0, eH:int = 0):void
		{
			BackGround = new Sprite();
			BackGround.graphics.beginFill(Color);
			BackGround.graphics.drawRoundRect(X,Y,w,h,eW,eH);
			BackGround.graphics.endFill();
			addChild(BackGround);
		}
		public function RemoveListeners ():void
		{
			if(tmrDisplay)
			{
				removeEvent(tmrDisplay,TimerEvent.TIMER, calcProgress);
				tmrDisplay.stop();
			}
			
			/**Play-Pause Button Event Listeners**/
			removeEvent(PlayPause_Btn,MouseEvent.CLICK,PPauseClicked);
			removeEvent(PlayPause_Btn,MouseEvent.MOUSE_OVER, onOver);
			removeEvent(PlayPause_Btn,MouseEvent.MOUSE_OUT, onOut);
			
			/**Sound On / Off Button Event Listeners**/
			removeEvent(Sound_Btn,MouseEvent.CLICK, onSoundClick);
			removeEvent(Sound_Btn,MouseEvent.MOUSE_OVER, onOver);
			removeEvent(Sound_Btn,MouseEvent.MOUSE_OUT, onOut);
			
			/**Tracker Event Listener**/
			removeEvent(Tracker_Bg,MouseEvent.MOUSE_DOWN,onMouseDownTracker);
			removeEvent(Tracker_Bg,MouseEvent.MOUSE_UP,onMouseUpTracker);			
			removeEvent(Tracker_Snd,MouseEvent.MOUSE_DOWN,setSndVolWithTracker);
			removeEvent(Tracker_Snd,MouseEvent.MOUSE_UP,setSndVolWithTracker);
			//removeEvent(Tracker_Bg,Event.ENTER_FRAME, calcProgress);
			
		}
		private function onRemoved(e:Event):void
		{
			RemoveListeners();
			
			removeChild(Fonts);
			BackGround.removeChild(PlayPause_Btn);
			BackGround.removeChild(Tracker_Bg);
			BackGround.removeChild(Sound_Btn);
			BackGround.removeChild(Tracker_Snd);
			BackGround.removeChild(txt);
			BackGround.removeChild(TitleBar);
			
			PlayList ? removeChild(PlayList) : void;
			removeChild(BackGround);
			removeEvent(this,Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, true);
		}
		
		private function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
		
	}
}