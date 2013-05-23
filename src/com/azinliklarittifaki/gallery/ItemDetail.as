package src.com.azinliklarittifaki.gallery
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.globals.Root;
	import com.alptugan.layout.Aligner;
	import com.alptugan.preloader.PreloaderMacStyle;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.stroep.flashflowfactory.enum.Alignment;
	
	import src.com.azinliklarittifaki.events.GalleryEvent;
	import src.com.azinliklarittifaki.gallery.control.Control;
	import src.com.azinliklarittifaki.gallery.control.ControllerEvent;
	
	public class ItemDetail extends Root
	{
		
		private var control:Control;
		private var laoder:BulkLoader;

		private var bmp:Bitmap;
		
		private var xml:XML;
		private var id:int;
		private var detailedSourcePath:String;

		public var fullScreen:ItemFullScreen;
		
		private var pre:PreloaderMacStyle;
		
		public function ItemDetail(xml:XML,id:int)
		{
			this.xml = xml;
			this.id  = id;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function addPreloader():void
		{
			pre = new PreloaderMacStyle(12,6,true);
			addChild(pre);
			Alignment.setAlignment(pre,Alignment.CENTER_MIDDLE,Alignment.CENTER_MIDDLE);
		}	
		
		 protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		
			detailedSourcePath =  xml.basePathLarge[0].toString() + xml.item[id].src.toString();
			
						
			// Control Unit
			control = new Control();
			addChild(control);
			control.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			control.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			control.addEventListener(MouseEvent.CLICK, onClick);
			
			Aligner.alignMiddleHorizontalToBounds(control,W,0,82);
			
			loadImageLarge(detailedSourcePath);
		}
		 
		 public function loadImageLarge(_detailedSourcePath:String):void
		 {
			 detailedSourcePath = _detailedSourcePath;
			 laoder  = new BulkLoader("detail");
			 laoder.add(detailedSourcePath);
			 laoder.addEventListener(BulkLoader.COMPLETE, this.onDetailedLoaded);
			 laoder.addEventListener(BulkLoader.PROGRESS, this.onProgress);
			 laoder.start();
			 addPreloader();
			 dispatchEvent(new GalleryEvent(GalleryEvent.IMAGE_ONSTART));
		 }
		 
		protected function onDetailedLoaded(e:Event):void
		{
			laoder.removeEventListener(BulkLoader.COMPLETE, this.onDetailedLoaded);
			laoder.removeEventListener(BulkLoader.PROGRESS, this.onProgress);
			
			bmp = laoder.getBitmap(detailedSourcePath);
			
			// Larger size of the phtogoraph loads
			fullScreen = new ItemFullScreen(bmp,xml.item[id].info.toString());
			addChild(fullScreen);
			
			trace(id,xml.item[id].info.toString());
			laoder.clear();
			laoder.removeAll();
			pre.destroy();
			dispatchEvent(new GalleryEvent(GalleryEvent.IMAGE_ONCOMPLETE));
		}
		
		/**
		 * PROGRESS EVENT DISPLAY A LOADER FOR THE PHOTOS 
		 * @param e
		 * 
		 */
		protected function onProgress(e:BulkProgressEvent):void
		{
			pre.onProgress(e.bytesLoaded,e.bytesTotal);
		}
		
		
		
		/**
		 * ON CLICK CONTROLLER PANEL 
		 * @param event
		 * 
		 */
		protected function onClick(event:MouseEvent):void
		{
			var evt:ControllerEvent = new ControllerEvent(ControllerEvent.CLICKED,event.target.name);
			dispatchEvent(evt);
			
			if(event.target.name == "i" && fullScreen.info.alpha == 0)
			{
			}
		}
		
		
		//========================================================================================================
		// PUBLIC METHODS
		//========================================================================================================
		public function showInfo():void
		{
			TweenLite.to(fullScreen.info,0.5,{/*y:fullScreen.info.y+5,*/autoAlpha:1,ease:Expo.easeOut,overwrite:0});
		}
		
		public function hideInfo():void
		{
			TweenLite.to(fullScreen.info,0.5,{/*y:fullScreen.infoPosY,*/autoAlpha:0,ease:Expo.easeOut});
		}
		
		public function gotoImage(_id:int):void
		{
			TweenLite.to(fullScreen,0.5,{alpha:0,ease:Expo.easeOut,onComplete:function():void
			{
				removeChildAt(1);
				
			}});
			this.id = _id;
			loadImageLarge(xml.basePathLarge[0].toString() + xml.item[_id].src.toString());
		}
		
		
		override protected function on_Resize(e:Event):void
		{
			if(control) Aligner.alignMiddleHorizontalToBounds(control,W,0,82);
		}
		
		protected function onOver(event:MouseEvent):void
		{
			TweenLite.to(event.target,0.5,{alpha:0.8,ease:Strong.easeOut});
		}
		
		protected function onOut(event:MouseEvent):void
		{
			TweenLite.to(event.target,0.5,{alpha:0.3,ease:Strong.easeOut});
		}
		
		
		
	}
}