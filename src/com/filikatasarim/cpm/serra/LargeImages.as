package src.com.filikatasarim.cpm.serra
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.layout.Aligner;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	public class LargeImages extends CasaSprite
	{
		[Embed(source="assets/nextBtn.png")]
		protected var NextVtnClass:Class;
		
		private var Next:CasaSprite;
		
		[Embed(source="assets/preBtn.png")]
		protected var PreBtnClass:Class;
		
		private var Prev:CasaSprite;
		
		private var holder:CasaSprite;

		private var clicked:DisplayObject;
		
		private var src:String;
		
		public var catId:int,
					subCatId:int = 0;
					private var arr:Array;

					private var XMLLoader:BulkLoader;

					private var imageNum:int;
					private var id:int = 0;
					private var SubCatNum:int;

					private var subCatEnd:Boolean = false;

					private var CatNum:int;

					private var targetName:String;
		
					private var imgHolder:CasaSprite;
					
		public var pageId:int;
					
		public function LargeImages(id:int)
		{
			this.src = src;
			this.catId = catId;
			this.subCatId = subCatId;
			this.arr = arr;
			this.id = id;
			SerraGlobals.getInstance().pageId = this.id;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);

			removeEventListeners();
			holder.removeAllChildrenAndDestroy(true,true);
			null;
		}		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			holder = new CasaSprite();
			addChild(holder);
			
			imgHolder = new CasaSprite();
			addChildAt(imgHolder,0);
			
			Next = new CasaSprite();
			holder.addChild(Next);
			
			
			Next.scaleX =Next.scaleY = 0.6;
			
			
			Next.name = 'next';
			var bmp1:Bitmap = new NextVtnClass() as Bitmap;
			bmp1.smoothing = true;
			Next.addChild(bmp1);
			
			Prev = new CasaSprite();
			holder.addChild(Prev);
			Prev.name = 'prev';
			
			
			Prev.scaleX =Prev.scaleY = 0.6;
			
			
			var bmp2:Bitmap = new PreBtnClass() as Bitmap;
			bmp2.smoothing = true;
			Prev.addChild(bmp2);
			
			
			holder.alpha = 0.4;
			
			
			holder.addEventListener(MouseEvent.CLICK,onDown);
			//holder.addEventListener(MouseEvent.MOUSE_UP,onUp);
			
			Aligner.alignMiddleLeftToBounds(Prev,stage.stageHeight);
			Aligner.alignMiddleRightToBounds(Next,stage.stageWidth,stage.stageHeight);
			
			TweenMax.from(Prev,0.5,{ease:Expo.easeOut,x:-Prev.width});
			TweenMax.from(Next,0.5,{ease:Expo.easeOut,x:stage.stageWidth,onComplete:initLargeImage(this.id)});
						
		}
		
		private function RemoveEffect(_clicked:DisplayObject):void
		{
			TweenMax.to(_clicked,0.1,{tint:null,glowFilter:{color:0xffb358, alpha:0, blurX:0, blurY:0}});
		}
		
		
		protected function onDown(e:MouseEvent):void
		{
			
			clicked = e.target as DisplayObject;
			TweenMax.to(clicked,0.1,{tint:0xffb358,glowFilter:{color:0xffb358, alpha:1, blurX:30, blurY:30},onComplete:RemoveEffect,onCompleteParams:[clicked]});
			holder.removeEventListeners();
			//Globals.ContentXML.category[catId].subcategory[subcatId].pages.page[i];
			targetName = e.target.name;
			switch(e.target.name)
			{
				case 'next':
				{
					
					SerraGlobals.getInstance().pageId++;
					
					this.id = (SerraGlobals.getInstance().pageId ) ;
					//SerraGlobals.getInstance().pageId = SerraGlobals.getInstance().pageId % Globals.pageObjects.length-1;
					if(this.id > Globals.pageObjects.length-1)
					{
						id = 0;
						SerraGlobals.getInstance().pageId = 0;
					}

					initLargeImage(id);
					TweenMax.to(imgHolder.getChildAt(0),0.5,{ease:Expo.easeOut,x:-stage.stageWidth,onComplete:function():void{imgHolder.removeChildAt(0);}});
					
					
					break;
				}
					
				case 'prev':
				{
					
					SerraGlobals.getInstance().pageId--;
					
					this.id = (SerraGlobals.getInstance().pageId ) ;
					
					//SerraGlobals.getInstance().pageId = SerraGlobals.getInstance().pageId % Globals.pageObjects.length-1;
					if(this.id < 0)
					{
						id = Globals.pageObjects.length-1;
						SerraGlobals.getInstance().pageId = Globals.pageObjects.length-1;
					}
					
					initLargeImage(id);
					TweenMax.to(imgHolder.getChildAt(0),0.5,{ease:Expo.easeOut,x:stage.stageWidth,onComplete:function():void{imgHolder.removeChildAt(0);}});

					break;
				}
					
			}
			
			
			dispatchEvent(new Event('tag'));
		}
		
		
		
		private function initLargeImage(_id:int):void
		{
			XMLLoader  = new BulkLoader("image");
			XMLLoader.add(String(Globals.pageObjects[_id].src));
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			var img:Bitmap = XMLLoader.getBitmap(Globals.pageObjects[id].src,true);
			
			imgHolder.addChild(img);
			
			if(targetName == 'prev')
				TweenMax.from(img,0.5,{ease:Expo.easeOut,x:-stage.stageWidth,onComplete:AddListeners});
			else
				TweenMax.from(img,0.5,{ease:Expo.easeOut,x:stage.stageWidth,onComplete:AddListeners});
			
			XMLLoader.clear();
			XMLLoader.remove("image");
			
			
			
		}
		private function AddListeners():void
		{
			holder.addEventListener(MouseEvent.CLICK,onDown);

		}
		
		//public function 
	}
}