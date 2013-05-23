package com.alptugan.template
{
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.drawing.Navigation.PauseButton;
	import com.alptugan.drawing.Navigation.PlayButton;
	import com.alptugan.primitives.AGradientCircle;
	import com.alptugan.text.ATextSingleLine;
	import com.alptugan.utils.Colors;
	import com.alptugan.valueObjects.ImageItemVO;
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.DataLoad;
	import org.casalib.load.GroupLoad;
	import org.casalib.load.ImageLoad;
	
	import src.com.galea.Globals;
	import src.net.jwproduction.FontNames;
	
	/* XML SAMPLE
	
	<?xml version="1.0" encoding="UTF-8" ?>
	<data>
	<img>
	<src>images/1.jpg</src>
	<title>TitLE 1</title>
	<info></info>
	</img>
	
	<img>
	<src>images/2.jpg</src>
	<title>TitLe 2</title>
	<info></info>
	</img>
	
	<img>
	<src>images/3.jpg</src>
	<title>TitLE 3</title>
	<info></info>
	</img>
	
	<img>
	<src>images/4.jpg</src>
	<title>TitLE 4</title>
	<info></info>
	</img>
	</data>
	
	*/
	
	public class ASimpleSlideShow extends CasaSprite
	{
		
		private var
		w         : int,
		h         : int,
		slideTime : Number,
		source    : *,
		VO        : Vector.<ImageItemVO> = new Vector.<ImageItemVO>;
		
		private var
		groupLoad : GroupLoad,
		dataLoad  : DataLoad,
		xml       : XML,
		images    : Array =[],
			len       : int,
			i         : int = 0;
		
		public var isXML:Boolean = false;
		private var imgHolder : CasaSprite;
		
		private var my_timer:Timer;
		
		private var dot     : AGradientCircle;
		private var dotClicked:Boolean;
		private var txt     : ATextWithTitle;
		private var txts    : Array           = [];
		private var dots    : Array           = [];
		
		private var playBtn : PlayButton;
		private var pauseBtn : PauseButton;
		
		private var style    : String;
		
		private var progressTxt : ATextSingleLine;
		
		
		
		public function ASimpleSlideShow(source:*,w:int,h:int,slideTime:Number, style:String = "default")
		{
			super();
			this.source = source;
			this.w   = w;
			this.h   = h;
			this.slideTime = slideTime;
			this.style     = style;
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		
		
		protected function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			OverwriteManager.init();
			
			//load XML
			if (isXML) 
			{
				xml = source as XML;
				// set the egthn of the images
				len = xml.img.length();
				startLoading();
			}else{
				loadXML();
			}
			
			createPreloader();
		}
		
		
		//======================================================================================================================
		// CREATE PRELOADER
		//======================================================================================================================
		private function createPreloader():void
		{
			progressTxt = new ATextSingleLine(Globals.Language == "tr" ? "YÜKLENİYOR" : "LOADING",FontNamesFB.regular,Colors.cWhiteSmoke,10,Globals.Language == "tr" ? true : false,true);
			addChild(progressTxt);
			
			progressTxt.x = (w-progressTxt.width) >> 1;
			progressTxt.y = (h-progressTxt.height) >> 1;
			
			TweenLite.from(progressTxt,0.5,{alpha:1,y:"-30"});
		}		
		
		/**
		 * 
		 *  LOAD XML FILE 
		 * 
		 */
		private function loadXML():void
		{
			dataLoad = new DataLoad(source);
			dataLoad.addEventListener(LoadEvent.COMPLETE, XMLonComplete);
			dataLoad.start();
		}
		
		protected function XMLonComplete(e:LoadEvent):void
		{
			dataLoad.destroy();
			groupLoad.destroy();
			// set xml variable
			xml = dataLoad.dataAsXml;
			
			// set the egthn of the images
			len = xml.img.length();
			
			//AFTER XML LOADING IS FINISHED, START LOADING IMAGES
			startLoading();
		}
		
		/**
		 *
		 * START TO LOAD IMAGES 
		 * 
		 */
		private function startLoading():void
		{
			//GROUP LOADER FOR ALL OF THE IMAGES
			this.groupLoad = new GroupLoad();
			
			// HOLDER SPRITE FOR IMAGES
			imgHolder      = new CasaSprite();
			addChild(imgHolder);
			
			// PLAY PAUSE BUTTON TO STOP AND PLAY THE SLIDESHOW
			playBtn        = new PlayButton(15,15,0xffffff,0,0,true,w,h);
			pauseBtn       = new PauseButton(15,15,0xffffff,0,0,true,w,h);
			playBtn.alpha  = 0;
			pauseBtn.alpha = 0;
			pauseBtn.addEventListener(MouseEvent.MOUSE_OVER,onOverImgs);
			pauseBtn.addEventListener(MouseEvent.MOUSE_OUT,onOutImgs);
			playBtn.addEventListener(MouseEvent.CLICK,onClickImg);
			pauseBtn.addEventListener(MouseEvent.CLICK,onClickImg);
			addChild(playBtn);
			addChild(pauseBtn);
			
			
			
			for (var i:int = 0; i < len; i++)
			{
				// SET VALUE OBJECT PROPERTIES
				VO[ i ]     = new ImageItemVO();
				VO[i].src   = xml.img[i].src;
				VO[i].title = xml.img[i].title;
				VO[i].info  = xml.img[i].info;
				
				// LOAD IMAGES
				images[i]   = new ImageLoad(String(VO[i].src));
				
				// SET ALPHAS TO 0
				images[i].loader.alpha = 0;
				
				
				
				// ADD IMAGES TO DISPLAY LIST
				imgHolder.addChild(this.images[i].loader);
				
				
				
				// ADD THEM TO THE GROUPLOAD
				groupLoad.addLoad(this.images[i]);
				
			}
			
			this.groupLoad.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this.groupLoad.addEventListener(LoadEvent.PROGRESS, this.onProgress);
			this.groupLoad.addEventListener(LoadEvent.COMPLETE, this.onComplete);
			this.groupLoad.start();
		} // End of startLoading()
		
		/**
		 *
		 * USERS CLICKS ONTO IMAGES
		 *  
		 * @param e
		 * 
		 */
		protected function onClickImg(e:MouseEvent):void
		{
			
			if(!dotClicked)
			{
				my_timer.stop();
				TweenLite.to(pauseBtn,0.5,{alpha:0});
				TweenLite.to(playBtn,0.5,{alpha:1});
				dotClicked = true;
			}else{
				my_timer.start();
				TweenLite.to(pauseBtn,0.5,{alpha:1});
				TweenLite.to(playBtn,0.5,{alpha:0});
				dotClicked = false;
			}
		}
		
		/**
		 * MOUSE OVER SHOW PALAY PAUSE BUTTONS 
		 * @param e
		 * 
		 */
		protected function onOverImgs(e:MouseEvent):void
		{
			if (dotClicked) 
			{
				TweenLite.to(playBtn,0.5,{alpha:1});
				pauseBtn.alpha = 0;
			}else{
				playBtn.alpha = 0;
				TweenLite.to(pauseBtn,0.5,{alpha:1});
			}
			
		}
		

		
		/**
		 * MOUSE OUT HIDE PLAY PAUSE BUTTONS 
		 * @param e
		 * 
		 */
		protected function onOutImgs(e:MouseEvent):void
		{
			if (dotClicked) 
			{
				TweenLite.to(playBtn,0.5,{alpha:0});
			}else{
				TweenLite.to(pauseBtn,0.5,{alpha:0});
			}
		}
		
		protected function onError(e:IOErrorEvent):void {
			//trace("There was an error");
			this.groupLoad.removeLoad(this.groupLoad.erroredLoads[0]);
		}
		
		protected function onProgress(e:LoadEvent):void {
			//trace("Group is " + e.progress.percentage + "% loaded at " + e.Bps + "Bps.");
			progressTxt.SetText(Globals.Language == "tr" ? "% " + String(Math.ceil(e.progress.percentage)) + " YÜKLENDİ" : String(Math.ceil(e.progress.percentage)) + " %" + "LOADED");
		}
		
		protected function onComplete(e:LoadEvent):void 
		{	
			// WHEN GROUP LOADING IS FINISHED DESTROY GROUP LOADER
			groupLoad.destroyProcesses(true);
			groupLoad.destroyLoads();
			groupLoad.destroy();
			
			scaleImages();
			
			switch(style)
			{
				case "default":
					len > 1 ? loadDotsAndTxt() : void;
					break;
					
			}
			
			// REMOVE PRELOADER
			TweenLite.to(progressTxt,0.5,{alpha:0,y:"30",onComplete:function():void{progressTxt.destroy();progressTxt=null;}});
			
			// SHOW FIRST IMAGE START SLIDE
			TweenLite.to(images[0].loader,0.5,{alpha:1,onComplete:startTimer,delay:0.3});
		}
		
		//======================================================================================================================
		// SCALING IMAGES
		//======================================================================================================================
		private function scaleImages():void
		{
			for (var i:int = 0; i < len; i++)
			{
				
				
				var r:Number;//ratio
				
				r = images[i].loader.height/images[i].loader.width;//calculation ratio
				
				if(w > 0)
				{
					images[i].loader.width = w;
					images[i].loader.height = Math.round(images[i].loader.width*r);
					trace("genişlik büyük");
				}else{
					images[i].loader.height = h;
					images[i].loader.width = Math.round(images[i].loader.height/r);
					trace("yükseklik büyük");
				}
				
			}
			
			// PLACE THE PAUSE AND START BUTTONS IN THE MIDDLE OF THE SCREEN
			pauseBtn.x = images[0].loader.width*0.5 - pauseBtn.width*0.5;
			pauseBtn.y = images[0].loader.height*0.5 - pauseBtn.height*0.5;
			
			playBtn.x = pauseBtn.x;
			playBtn.y = pauseBtn.y;
			
			
			dispatchEvent(new Event("onLoaded"));
		}
		
		//======================================================================================================================
		// ADD DOTS and TEXTFIELDS
		//======================================================================================================================
		private function loadDotsAndTxt():void
		{
			for (var j:int = 0; j < len; j++)
			{
				//images[j].loader.addChild(new Bounds(images[j].loader));
				// ADD DOTS
				dots[j]   = new AGradientCircle(10,[0x404040,0x5f5f5f],true);
				dots[j].x = images[0].loader.width - j * 15 - 5;
				dots[j].y = images[0].loader.height + 10;
				dots[j].id = j;
				addChild(dots[j]);
				dots[j].addEventListener(MouseEvent.CLICK,onclickDot);
				
				txts[j]   = new ATextWithTitle(VO[j].title,VO[j].info,265,18,12,0x000000);
				txts[j].x =  10+images[0].loader.width;
				txts[j].alpha = 0;
				addChild(txts[j]);
			}
			
			// AFTER ALL OF THE IMAGES LOADED AND ADDED TO STAGE SHOW THE FIRST ONE
			TweenLite.to(txts[0],0.5,{alpha:1});
			TweenLite.to(dots[0],0.5,{scaleX:1.3,scaleY:1.3});
			dots[0].removeEventListeners();
			dots[0].buttonMode = false;
		} 
		// End of loadDotsAndTxt
		
		//======================================================================================================================
		// WHEN USER CLICKS ONTO ONE OF THE DOTS
		//======================================================================================================================
		private function onclickDot(e:MouseEvent):void
		{
			dotClicked = true;
			my_timer.stop();
			var id:int = e.target.id;
			hidePrev();
			i = id;
			nextImage();
		}
		
		/**
		 * 
		 * TIMER HANDLER ON EVERY slideTime SECONDS 
		 * 
		 */
		protected function startTimer():void 
		{	
			if (len > 1) 
			{
				my_timer=new Timer(slideTime*1000);
				my_timer.addEventListener(TimerEvent.TIMER, timerListener);
				my_timer.start();	
			}
		}
		
		/**
		 * 
		 * TRIGGER TIMER FUNCTION ON EVERY slideTime SECONDS
		 * @param e 
		 * 
		 */
		protected function timerListener(e:TimerEvent):void {
			
			hidePrev();
			
			i++;
			if (i==len) {
				i=0;
			}
			nextImage();
		} // End of timerListener
		
		/**
		 * SHOW NEXT IMAGE 
		 * 
		 */
		private function nextImage():void
		{
			switch(style)
			{
				case "default":
				{
					dots[i].removeEventListeners();
					dots[i].buttonMode = false;
					TweenLite.to(txts[i],0.5,{alpha:1});
					TweenLite.to(dots[i],0.5,{scaleX:1.3,scaleY:1.3});
					break;
				}
					
			}
			TweenLite.to(images[i].loader,0.5,{alpha:1,delay:0.1});
		} // End of nextImage
		
		/**
		 * HIDE PREVIOUS IMAGE 
		 * 
		 */
		private function hidePrev():void
		{
			switch(style)
			{
				case "default":
				{
					TweenLite.to(txts[i],0.5,{alpha:0,delay:0.1});
					TweenLite.to(dots[i],0.5,{scaleX:1,scaleY:1});
					dots[i].initHandlers();
					dots[i].addEventListener(MouseEvent.CLICK,onclickDot);
					dots[i].buttonMode = true;
					break;
				}
					
			}
			TweenLite.to(images[i].loader,1,{alpha:0 });
		} // End of Hide Prev
		
		/**
		 * 
		 * @param e : REMOVED FROM STAGE EVENT , CLEAR SCENE FOR GARBGAGE COLLECTION
		 * 
		 */
		protected function onRemoved(e:Event):void
		{
			this.removeEventListeners();
			imgHolder.removeEventListeners();
			imgHolder.destroy();
			pauseBtn.removeEventListener(MouseEvent.MOUSE_OVER,onOverImgs);
			pauseBtn.removeEventListener(MouseEvent.MOUSE_OUT,onOutImgs);
			playBtn.removeEventListener(MouseEvent.CLICK,onClickImg);
			pauseBtn.removeEventListener(MouseEvent.CLICK,onClickImg);
			// Timer for Slider
			my_timer.stop();
			my_timer.removeEventListener(TimerEvent.TIMER, timerListener);
			my_timer = null;
			
			for (var i:int = 0; i < len; i++)
			{
				TweenLite.killTweensOf(images[i].loader);
				imgHolder.removeChild(images[i].loader);
				
				switch(style)
				{
					case "default":
					{
						dots[i].removeEventListener(MouseEvent.CLICK,onclickDot);
						removeChild(this.dots[i]);
						removeChild(this.txts[i]);
						
						this.dots[i].removeChildrenAndDestroy(true,true);
						this.txts[i].removeChildrenAndDestroy(true,true);
						
						this.txts[i]   = null;
						this.dots[i]   = null;
						break;
					}
				}
				
				this.images[i].destroy();
				this.images[i] = null;
			}
			
			imgHolder.destroy();
			removeChild(playBtn);
			removeChild(pauseBtn);
			
			playBtn = null;
			pauseBtn = null;
			imgHolder = null;
			
			VO = null;
			images = null;
			
			switch(style)
			{
				case "default":
				{
					dots = null;
					txts = null;
					txt = null;
					break;
				}		
			}
		} // End of onRemoved
	}
}