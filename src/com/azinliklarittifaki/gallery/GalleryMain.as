package src.com.azinliklarittifaki.gallery
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.globals.Root;
	import com.alptugan.layout.Aligner;
	import com.alptugan.preloader.PreloaderMacStyle;
	import com.alptugan.template.AHorizontalSlider;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.azinliklarittifaki.LeftRightButton;
	import src.com.azinliklarittifaki.events.GalleryEvent;
	import src.com.azinliklarittifaki.events.GalleryItemEvent;
	import src.com.azinliklarittifaki.gallery.control.ControllerEvent;
	
	public class GalleryMain extends Root
	{		
		private var XMLLoader:BulkLoader;
		
		public var src:String;
		public var xml:XML;
		private var i:int  = 0;
		public var id:int = -1;
		
		private var items:Array=[];
		private var itemsHolder:CasaSprite;
		private var len:int;

		private var sourcePath:String;

		private var rigthBtn:LeftRightButton;

		private var leftBtn:LeftRightButton;

		private var detail:ItemDetail;
		
		private var isDetailed:Boolean = false;

		private var pre:PreloaderMacStyle;

		private var it:Item;
		
		public function GalleryMain(src:String)
		{
			this.src = src;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			items[i].removeEventListener(GalleryItemEvent.LOADING_ONCOMPLETE,onSingleLoaded);
			items.length = 0;
			XMLLoader.pauseAll();
			XMLLoader.removeAll();
			XMLLoader.clear();
		}		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			loadXML();
			
			addPreloader();
		}
		
		private function addPreloader():void
		{
			pre = new PreloaderMacStyle(12,6,true);
			addChild(pre);
			Aligner.alignCenter(pre,stage);
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
			pre.onProgress(e.bytesLoaded ,e.bytesTotal);
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
			
			pre.destroy();
			
			loadImages();
		}
		
		private function loadImages():void
		{	
			//Sourcepath of a single image
			sourcePath = xml.basePathThumbs[0].toString() + xml.item[i].src.toString() ;
			
			//Single item Class
			it = new Item(i,sourcePath,138,85);
			itemsHolder.addChild(it);
			it.name = String(i);
			
			//Push items into a array
			items.push(it);
			
			
			//Listen items loading status, when it finishes add new item to the display list
			items[i].addEventListener(GalleryItemEvent.LOADING_ONCOMPLETE,onSingleLoaded);
		}
		
		
		
		
		protected function onSingleLoaded(e:GalleryItemEvent):void
		{
			items[i].removeEventListener(GalleryItemEvent.LOADING_ONCOMPLETE,onSingleLoaded);
			
			//Create grid view
			generateBoard(items[i],0,0,3,3,0,0);
			
			//Align itemsHolder to the center of the stage
			Aligner.alignMiddleVerticalToBounds( itemsHolder,H);
			
			//trace(i%3 , ' : ' , items[i].x,items[i].width);
		
			if(items[i].x + items[i].width > stage.stageWidth && i%9 == 0)
			{
				TweenMax.to(itemsHolder,0.5,{x:itemsHolder.x - 512 ,ease:Expo.easeOut});
			}
			
			
			if(i < len - 1)
			{
				i++;
				loadImages();
			}else{
				
				
				
				
				//right Left Buttons
				rigthBtn = new LeftRightButton({w:17,h:190,color:0xffffff,direction:"right",tw:5,th:9,tcolor:0x000000});
				addChild(rigthBtn);
				
				
				leftBtn = new LeftRightButton({w:17,h:190,color:0xffffff,direction:"left",tw:5,th:9,tcolor:0x000000});
				addChild(leftBtn);
				
				
				//After everthing is loaded add mouse Listeners to the items
				for (var j:int = 0; j < items.length; j++) 
				{
					items[j].addEventListener(MouseEvent.CLICK,onClickImgae);
					items[j].addListeners();
				}
				
				
				// Horizontal Slider
				var slider:AHorizontalSlider = new AHorizontalSlider(itemsHolder,leftBtn,rigthBtn,items[0].width,items.length / 3,3);
				
				on_Resize(null);
				
				setSelection(0);
				
				/*XMLLoader.clear();
				XMLLoader.removeAll();*/
			}
		}
		
		
		/**
		 * USER CLICK IMAGE AAND DETAILED VIEW COMES TO SCREEN
		 * @param e : click evet
		 * 
		 */
		private function onClickImgae(e:MouseEvent):void
		{			
			setSelection(e.currentTarget.name);
		}
		
		private function setSelection(selectedId:int):void
		{
			if (id != -1) 
			{
				items[id].addEventListener(MouseEvent.CLICK,onClickImgae);
			}
			
			id = selectedId;
			items[id].removeEventListener(MouseEvent.CLICK,onClickImgae);
			

			
			// Show detailed image
			detail = new ItemDetail(xml,id);
			addChild(detail);
			detail.addEventListener(ControllerEvent.CLICKED,onclickController);
			detail.addEventListener(GalleryEvent.IMAGE_ONCOMPLETE,onDetailedComplete);
			isDetailed = true;
			
			// Hide İtemsHolder and NavigaitonItems
			hideNavigationItems();

		}		
		
		protected function onDetailedComplete(event:Event):void
		{
			detail.addEventListener(ControllerEvent.CLICKED,onclickController);
		}
		
		protected function onclickController(e:ControllerEvent):void
		{
			switch(e.action)
			{
				case "l":
				{
					if(id > 0)
					{
						id--;
					}
					detail.removeEventListener(ControllerEvent.CLICKED,onclickController);
					detail.gotoImage(id);
					break;
				}
					
				case "r":
				{
					if(id < items.length - 1)
					{
						id++;
					}
					detail.removeEventListener(ControllerEvent.CLICKED,onclickController);
					detail.gotoImage(id);
					break;
				}
					
				case "t":
				{
					showNavigation();
					if(!items[id].hasEventListener(MouseEvent.CLICK))
						items[id].addEventListener(MouseEvent.CLICK,onClickImgae);
					break;
				}
					
				case "i":
				{
				
					if(detail.fullScreen.info.alpha == 1)
					{
						detail.hideInfo();
					}else{
						detail.showInfo();
						//trace("okoko" +detail.fullScreen.info.alpha);
					}
					break;
				}
					
					
			}
		}
		
		private function hideNavigationItems():void
		{
			TweenLite.to(itemsHolder,0.5,{y:H,ease:Expo.easeInOut});
			TweenLite.to(leftBtn,1,{x:-leftBtn.width,ease:Expo.easeInOut,delay:0.2});
			TweenLite.to(rigthBtn,1,{x:W+rigthBtn.width,ease:Expo.easeInOut,delay:0.2});
			TweenLite.from(detail,0.5,{y:-1000,alpha:0,ease:Expo.easeOut,delay:0.3});
		}
		
		public function showNavigation():void
		{
			isDetailed = false;
			TweenLite.to(itemsHolder,0.5,{x:0,y:(H-itemsHolder.height) >> 1,ease:Expo.easeOut});
			TweenLite.to(leftBtn,1,{x:0,ease:Expo.easeOut,delay:0.3});
			TweenLite.to(rigthBtn,1,{x:W-rigthBtn.width,ease:Expo.easeOut,delay:0.3});
			TweenLite.to(detail,0.5,{y:-detail.height - 100,ease:Expo.easeOut,onComplete:function():void{
				detail.removeAllChildrenAndDestroy(true,true);
				detail.removeEventListeners();
			}});
		}
		
		
		
		/**
		 * OVERRIDE STAGE RESIZE EVENT AND PLACE THE ITEMS 
		 * @param e
		 * 
		 */
		override protected function on_Resize(e:Event):void{
			
			if(isDetailed == false)
			{
				if(rigthBtn || leftBtn)
				{
					Aligner.alignMiddleRightToBounds( rigthBtn,stage.stageWidth,stage.stageHeight);
					Aligner.alignMiddleLeftToBounds(leftBtn,H);
				}
				
				
				if(itemsHolder)
				{
					Aligner.alignMiddleVerticalToBounds( itemsHolder,H);
				}
			}else{
				itemsHolder.y = H;
				leftBtn.x = -leftBtn.width;
				rigthBtn.x = W+rigthBtn.width;
			}
			
			if(pre)
				Aligner.alignCenter(pre,stage);
			
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
			
			
			obj.x = startX + (hGap + obj.width) * Math.floor( i / totalCols );
			obj.y = startY + (vGap + obj.height) * ( i % totalCols );
		}
	}
}