package src.com.innova.galeri
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.display.CreateMask;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	import com.bigspaceship.tween.easing.Expo;
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	
	import src.com.innova.Globals;
	import src.com.innova.SoundCenter;
	import src.com.innova.katlardaireler.InnovaKatPanaromaController;
	
	public class InnovaMainGallery extends CasaSprite
	{
		[Embed(source="assets/images/galeri/onceki.png")]
		protected var OncekiClass:Class;	
		
		[Embed(source="assets/images/galeri/sonraki.png")]
		protected var SonrakiClass:Class;	
		
		[Embed(source="assets/images/galeri/sirayla.png")]
		protected var SiraylaClass:Class;	
		
		[Embed(source="assets/images/slider/bg.png")]
		protected var TrackerBg:Class;
		
		[Embed(source="assets/images/slider/tracker.png")]
		protected var Tracker:Class;
		
		[Embed(source="assets/images/galeri/sirayla-down.png")]
		protected var SiraylaTimerClass:Class;
		
		
		private var tracker:CasaSprite;
		private var trackerBg:Bitmap;
		
		private var onceki:CasaSprite;
		private var sonraki:CasaSprite;
		private var sirayla:CasaSprite;
		private var siraylaTimer:CasaSprite;
		private var holderNav:CasaSprite;
		private var XMLLoader:BulkLoader;
		
		private var src:String;
		private var xml:XML;
		private var i:int;
		private var id:int = -1;
		
		private var items:Array=[];
		private var itemsHolder:CasaSprite;
		private var maske:Shape;
		private var len:int;
		private var w:int;
		private var h:int;

		private var slider:InnovaSlider;
		private var _interval:Interval;
		private var _intervalId:int;

		private var targetObj:Object;

		private var maske2:Shape;
		private var controller:Boolean;
		public static var panOpened:Boolean = false;
		public static var panoroma:Boolean;
		
		
		[Embed(source="assets/images/katlar/geri-bg.png")]
		protected var GeriBtnClass:Class;
		
		private var GeriBtn:CasaSprite;
		private var tfButton:ATextSingleLine;
		private var kont:InnovaKatPanaromaController;
		
		public function InnovaMainGallery(src:String,w:int=728,h:int = 768,controller:Boolean=true,panoroma:Boolean=false)
		{
			this.src = src;
			this.w = w;
			this.h = h;
			this.controller = controller;
			InnovaMainGallery.panoroma = panoroma;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onStage);
		}
		
		protected function onStage(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onStage);
			
			//TweenMax.killAll();
			this.removeEventListeners();
			this.removeAllChildrenAndDestroy(true,true);
			if(_interval)
				_interval.destroy();
			

		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			if(this.controller)
				initConstantVisuals();
			
			loadXML();
			
			TweenPlugin.activate([TweenPlugin]);
		}
		
		private function initConstantVisuals():void
		{
			holderNav = new CasaSprite();
			addChild(holderNav);
			
			//Sırayla button
			sirayla = new CasaSprite();
			sirayla.name = "sirayla";
			holderNav.addChild(sirayla);
			sirayla.addChild(new SiraylaClass() as Bitmap);
			
			
			
			//Sırayla button
			siraylaTimer = new CasaSprite();
			siraylaTimer.name = "timer";
			holderNav.addChild(siraylaTimer);
			siraylaTimer.addChild(new SiraylaTimerClass() as Bitmap);
			
			// Sırayla MAsk
			maske2 = CreateMask.Create(0,0,sirayla.width,sirayla.height);
			holderNav.addChild(maske2);
			maske2.y= maske2.height;
			siraylaTimer.mask = maske2;
			
			//Önceki button
			onceki = new CasaSprite();
			onceki.name = "onceki";
			holderNav.addChild(onceki);
			onceki.addChild(new OncekiClass() as Bitmap);
			onceki.x = 16 +sirayla.x + sirayla.width;
			
			//Sonraki button
			sonraki = new CasaSprite();
			sonraki.name = "sonraki";
			holderNav.addChild(sonraki);
			sonraki.addChild(new SonrakiClass() as Bitmap);
			sonraki.x = 16 +onceki.x + onceki.width;
			
			holderNav.addEventListener(MouseEvent.MOUSE_DOWN,onClickNav);
			this.addEventListener(MouseEvent.MOUSE_UP,onClickNavUp);
			
			var holderNavY:int = holderNav.y;
			holderNav.x = w - holderNav.width;

		}
		
		/**
		 * LOAD IMAGES.XML AND PARSE IT 
		 * 
		 */
		private function loadXML():void
		{
			XMLLoader = new BulkLoader("galeri");
			XMLLoader.add(src);
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.addEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			XMLLoader.start();
		}
		
		private function onAllProgress(e:BulkProgressEvent):void
		{
			//trace("alo : ",Math.round(e.bytesLoaded / e.bytesTotal * 100 )  );
		}
		
		private function onAllLoaded(e:Event):void
		{
			xml = XMLLoader.getContent(src);
			
			// Number of Images
			len = xml.item.src.length();

			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.removeEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			XMLLoader.clear();
			XMLLoader.removeAll();

			
			// Add holder sprite for holding array of images
			itemsHolder = new CasaSprite();
			addChild(itemsHolder);
			
			itemsHolder.y = 123;
			
			//Add mask 
			maske = CreateMask.Create(0,itemsHolder.y,w,h);
			addChild(maske);

			// Mask the content
			itemsHolder.mask = maske;
			

			loadImages();
		}
		
		private function loadImages():void
		{
			
			XMLLoader = new BulkLoader(BulkLoader.getUniqueName());
			XMLLoader.add(xml.item[i].src.toString());
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onSingleLoaded);
			XMLLoader.start();
		}
		
		protected function onSingleLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onSingleLoaded);
			
			var it:Item = new Item(XMLLoader.getBitmap(xml.item[i].src.toString()),xml.item[i].info,String(i));
			itemsHolder.addChild(it);
			items.push(it);
			
			items[i].addEventListener(MouseEvent.CLICK,onClickImgae);
			generateBoard(items[i],0,0,4,4,2,2);
			
			if(i < len-1)
			{
				
				i++;
				
				XMLLoader.clear();
				XMLLoader.removeAll();
				
				loadImages();
			}else{
				
				XMLLoader.clear();
				XMLLoader.removeAll();
				
				// WHEN LOADING FINISHED, SHOW SLIDER
				tracker = new CasaSprite();
			
				tracker.addChild(new Tracker() as Bitmap);
				
				trackerBg = new TrackerBg() as Bitmap;
				
				if(itemsHolder.height > maske.height)
				{
					slider = new InnovaSlider(itemsHolder,tracker,trackerBg,728,768,60,0xcccccc,0xffffff,null,false,true);
					addChild(slider);
				}
				
		
				setSelection(0);
			}
		}
		
		private function setSelection(selectedId:int):void
		{
			SoundCenter.play();
			
			
			
			if (id != -1) 
			{
				items[id].addEventListener(MouseEvent.CLICK,onClickImgae);
				items[id].setRectColor(0xb1b0a7);
			}
			
			id = selectedId;
			
			
			
			TweenMax.to(items[id].rect,0.1,{tint:0xffffff,ease:Strong.easeOut,onComplete:function():void{items[id].setRectColor(0x00a9d2);}});
			
			items[id].removeEventListener(MouseEvent.CLICK,onClickImgae);
			
			//
		
			if(InnovaMainGallery.panoroma)
			{
				ExternalInterface.call( "onClickPanaromaSpot", xml.item[id].large.toString(),xml.item[id].info.toString());
				
				if(!panOpened)
				{
					ExternalInterface.call( "switchy","");
					panOpened = true;
				}else{
					ExternalInterface.call("change");
				}
				
				
				TweenMax.to(itemsHolder,1,{delay:0.5,autoAlpha:0,ease:Expo.easeOut,onComplete:function():void{addGeriButton();addContorller();}});
				
			}else{
				ExternalInterface.call("changeGaleriImage",xml.item[id].large.toString(),xml.item[id].info.toString());
			}
			
			
			dispatchEvent(new Event('addedtostage'));
			
		}		
		
		//========================================================================================================
		// Add PANAROMA KONTROLLER
		//========================================================================================================
		private function addContorller():void
		{
			kont = new InnovaKatPanaromaController("");
			addChild(kont);
			kont.x = -17;
			kont.y = 506;
		}
		
		//========================================================================================================
		// Add GERİ BUTTON
		//========================================================================================================
		private function addGeriButton():void
		{
			//GERİ BUTTON
			GeriBtn = new CasaSprite();
			addChild(GeriBtn);
			
			GeriBtn.addChild(new GeriBtnClass() as Bitmap);
			GeriBtn.y = 123 ;
			//Arrow
			var arrow:Shape = drawArrow(20,34);
			GeriBtn.addChild(arrow);
			Aligner.alignCenter(arrow,GeriBtn,-arrow.width*2-15,-5);
			//GERİ TEXT
			tfButton = new ATextSingleLine("GERİ",Globals.css[9].name,Globals.css[9].color,Globals.css[9].size);
			GeriBtn.addChild(tfButton);
			Aligner.alignCenter(tfButton,GeriBtn,15,-5);
			
			GeriBtn.addEventListener(MouseEvent.CLICK,onClickGeri);
		}
		
		protected function onClickGeri(e:MouseEvent):void
		{
			GeriBtn.removeEventListener(MouseEvent.CLICK,onClickGeri);
			GeriBtn.removeAllChildrenAndDestroy(true,true);
			kont.removeAllChildrenAndDestroy(true,true);
			
			TweenMax.to(itemsHolder,1,{autoAlpha:1,ease:Expo.easeOut,onComplete:function():void{}});
		}
		
		//========================================================================================================
		// DRAW BACK BUTTON ARROW
		//========================================================================================================
		private function drawArrow(w:int,h:int):Shape
		{
			var s:Shape = new Shape();
			s.graphics.lineStyle(2,Globals.Style.global[0].color[0].@brown);
			s.graphics.moveTo(0,0);
			s.graphics.lineTo(-w,(h-1)*0.5);
			s.graphics.lineTo(0,h);
			
			return s;
		}
		
		private function onClickImgae(e:MouseEvent):void
		{
			if(this.controller)
				resetInterval();
			setSelection(e.currentTarget.name);
		}
		
		/**
		 * 
		 * DISTRIBUTES ARRAY OF ITEMS ON GRID POSITION
		 * 
		 * @param arr        = Array of images
		 * @param startX     = starting position of items on x axes
		 * @param startY     = starting position of items on y axes
		 * @param totalRows  = number of rows
		 * @param totalCols  = number of columns
		 * @param hGap       = horizontal gap between items
		 * @param vGap       = vertical gap betweem items
		 * 
		 */
		private function generateBoard(obj:DisplayObject,startX:Number,startY:Number,totalRows:Number,totalCols:Number,hGap:int,vGap:int):void {
			
	
			obj.x = startX + (hGap + obj.width) * ( i % totalCols );
			obj.y = startY + (vGap + obj.height) * Math.floor( i / totalCols );
		}
		
		/**
		 * NAVIGATION CLICK EVENTS 
		 * @param e
		 * 
		 */
		protected function onClickNav(e:MouseEvent):void
		{
			var selected:int = id;
			
			SoundCenter.play();
			
			switch(e.target.name)
			{
				case "sirayla":
				{
					animateMask();
					_intervalId = id;
					this._interval = Interval.setInterval(this._repeatingFunction, 5000);
					this._interval.repeatCount = 1;
					this._interval.start();
					dispatchEvent(new Event("timerstarted"));
					break;
				}
					
				case "onceki":
				{
					resetInterval();
					if(selected > 0)
					{
						selected--;
					}
					setSelection(selected);
					break;
				}
					
				case "sonraki":
				{
					resetInterval();
					if(selected < items.length - 1)
					{
						selected++;
					}
					setSelection(selected);
					break;
				}
			}
			
			targetObj = e.target;
			TweenMax.to(e.target,0.1,{tint:0xffffff});
			
		}
		
		private function resetInterval():void
		{
			dispatchEvent(new Event("timerstopped"));
			this._interval ? this._interval.stop() : void;
			if(maske2)
				TweenMax.to(maske2,0.2,{y:maske2.height});
		}		
		
		protected function onClickNavUp(e:MouseEvent):void
		{
			if(targetObj)
				TweenMax.to(targetObj,0.5,{tint:null});
		}
		
		private function _repeatingFunction():void
		{
			
			animateMask();
			if(_intervalId < items.length )
			{
				_intervalId++;
				var move:Number = maske2.height / items.length; 
			}
			
			if(_intervalId == items.length )
			{
				
				_intervalId = 0;
				//TweenMax.to(maske2,1,{y:maske2.height});
			}
			setSelection(_intervalId);		
			
			this._interval.reset();
			this._interval.start();
		}
		
		private function animateMask():void
		{
			TweenMax.to(maske2,5,{y:0,onComplete:function():void{
				maske2.y = maske2.height;
			}});
		}
	}
}