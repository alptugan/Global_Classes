package src.com.azinliklarittifaki.gallery
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.display.CreateMask;
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.LineStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.preloader.PreloaderMacStyle;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import nl.stroep.flashflowfactory.enum.Alignment;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.util.AlignUtil;
	
	import src.com.azinliklarittifaki.events.GalleryItemEvent;
	
	public class Item extends CasaSprite
	{
		private var rect  : RectShape;
		private var maske : Shape;
		private var bmp   : Bitmap;
		private var bmpSource:String;
		private var bmpHolder:CasaSprite;
		
		private var w     : int;
		private var h     : int;
		private var id    : int;
		private var stColor : uint;
		private var pre:PreloaderMacStyle;
		private var XMLLoader:BulkLoader;
		
		public function Item(i:int,bmpSource:String,w:int,h:int,stColor:uint = 0xffffff)
		{
			this.w         = w;
			this.bmpSource = bmpSource;
			this.h         = h;
			this.id        = i;
			this.stColor   = stColor;

			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		
			
			this.mouseChildren = false;
			this.buttonMode    = true;
			
			XMLLoader = new BulkLoader("image"+String(id));
			XMLLoader.add(this.bmpSource);
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onSingleLoaded);
			XMLLoader.addEventListener(BulkProgressEvent.PROGRESS, this.onSingleProgress);
			XMLLoader.start();
			
			
			
			dispatchEvent(new GalleryItemEvent(GalleryItemEvent.LOADING_ONSTART));
			
		}
		
		protected function onSingleLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onSingleLoaded);
			XMLLoader.removeEventListener(BulkProgressEvent.PROGRESS, this.onSingleProgress);
			
			var bmp:Bitmap = XMLLoader.getBitmap(this.bmpSource);
			
			// Draw rectangle w+1 and h+1 to make borders
			rect = new RectShape(new Rectangle(0,0,w+1,h+1),new FillStyle(0,1),new LineStyle(1,stColor,1,true,"normal","none","miter"));
			addChild(rect);
			rect.filters = [new GlowFilter(0x000000,1,40,40,2)];
			rect.alpha = 0.;
			/*	
			var myGlow:GlowFilter = new GlowFilter();
			rect.filters = [myGlow];
			*/
			// Add mask and move it x+1 and y+1 to fit into rectangle
			maske = CreateMask.Create(0,0,w,h);
			addChild(maske);
			maske.x = 1;
			maske.y = 1;
			bmp.mask = maske;
			
			// Holder sprite for bmp to make it place into center
			bmpHolder = new CasaSprite();
			addChild(bmpHolder);
			
			bmpHolder.alpha     = 0.3;
			
			bmpHolder.x = w*0.5 + 1;
			bmpHolder.y = h*0.5 + 1;
			
			bmp.width = w;
			bmp.height = h;
			
			bmpHolder.addChild(bmp);
			
			setRegistrationPoint(bmp, w*0.5,h*0.5,false);
			
			// X point shape
			var mark:Shape = new Shape();
			mark.graphics.lineStyle(1, 0xffffff);
			mark.graphics.moveTo(-3, -3);
			mark.graphics.lineTo(3, 3);
			mark.graphics.moveTo(-3, 3);
			mark.graphics.lineTo(3, -3);
			addChild(mark);
			mark.x = bmpHolder.x;
			mark.y = bmpHolder.y;
			
			bmp.smoothing = true;
			
			//remove and clean cache and memory
			XMLLoader.remove("image"+String(id));
			XMLLoader.clear();
			
			
			
			//dispatch that item is loaded
			dispatchEvent(new GalleryItemEvent(GalleryItemEvent.LOADING_ONCOMPLETE));
			
			
		}
		
		protected function onSingleProgress(e:BulkProgressEvent):void
		{
			//pre.onProgress(e.bytesLoaded,e.bytesTotal);
		}		
		
	
		
		protected function onOut(event:MouseEvent):void
		{
			TweenMax.to(rect,0.5,{alpha:0,ease:Expo.easeOut});
			TweenMax.to(bmpHolder,0.5,{scaleX:1,scaleY:1,alpha:0.3,ease:Expo.easeOut});
		}
		
		protected function onOver(event:MouseEvent):void
		{
			TweenMax.to(rect,0.5,{alpha:1,ease:Expo.easeOut});
			TweenMax.to(bmpHolder,0.5,{scaleX:1.2,scaleY:1.2,alpha:1,ease:Expo.easeOut});
			//setChildIndex(this.parent,10);
		}
		
		protected function setRegistrationPoint(s:Object, regx:Number, regy:Number, showRegistration:Boolean ):void
		{
			//translate movieclip 
			s.transform.matrix = new Matrix(1, 0, 0, 1, -regx, -regy);
	
			
			//registration point.
			if (showRegistration)
			{
				var mark:Shape = new Shape();
				mark.graphics.lineStyle(1, 0xffffff);
				mark.graphics.moveTo(-3, -3);
				mark.graphics.lineTo(3, 3);
				mark.graphics.moveTo(-3, 3);
				mark.graphics.lineTo(3, -3);
				s.parent.addChild(mark);
			}
		}
		
		
		private function addPreloader():void
		{
			
		}	
		
		//========================================================================================================
		// PUBLIC METHODS
		//========================================================================================================
		public function addListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
		}
		
		

	}
}