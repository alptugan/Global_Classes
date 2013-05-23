package src.com.filikatasarim.cpm.serra
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.layout.Aligner;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.filikatasarim.cpm.serra.events.CategoryEvent;
	import src.com.filikatasarim.cpm.serra.items.CatItem;
	
	public class Categories extends CasaSprite
	{
		private var w:int,
					h:int;
		
		private var arr:Array = [];
		private var arrThumb:Array = [];
		private var item:Vector.<CatItem> = new Vector.<CatItem>;

		private var XMLLoader:BulkLoader;

		private var len:int;
		private var holder:CasaSprite;

		private var selectedId:int;
		private var colNum:int;
		
		public function Categories(arr:Array,arrThumb:Array)
		{
			this.arr = arr;
			this.arrThumb = arrThumb;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			
		}
		
		public function reset():void
		{
			this.arr.length = 0;
			this.arrThumb.length = 0;
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			w = stage.stageWidth;
			h = stage.stageHeight;
			
			len = arr.length;
			//trace(len,arrThumb[0]);
			
			XMLLoader  = new BulkLoader("loader_name");
			
			for (var i:int = 0; i < len; i++) 
			{
				//trace(arrThumb[i]);
				XMLLoader.add(String(arrThumb[i]));
			}
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			var bmp:Bitmap;
			holder = new CasaSprite();
			addChild(holder);
			
			
			if(len <= 6)
				colNum = 3;
			else
				colNum = 4;
				
			
			
			
			for (var i:int = 0; i < len; i++) 
			{
				bmp = XMLLoader.getBitmap(String(arrThumb[i]));
				item[i] = new CatItem(String(arr[i]),bmp);
				item[i].id = i;
				item[i].mouseChildren = false;
				//item[i].addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
				holder.addChild(item[i]);
				
				if(len == 5 && i >= 3)
				{
					generateBoard(item[i],bmp.width*0.5,250,i,colNum,40,40);
				}
				else if(len == 7 && i >= 4)
				{
					generateBoard(item[i],bmp.width*0.5,250,i,colNum,40,40);
				}
				else
					generateBoard(item[i],0,250,i,colNum,40,40);
					
				TweenMax.to(item[i],0.5,{ease:Expo.easeOut,x:item[i].X,y:item[i].Y,delay:0.1*i,alpha:1,onComplete:AnimFinished,onCompleteParams:[i]});
			}
			//Aligner.alignCenterMiddleToBounds(holder,w,h,0,180);
			holder.addEventListener(MouseEvent.CLICK,onClickCat);
			
			XMLLoader.clear();
			XMLLoader.remove("loader_name");
			
		}
		
		private function AnimFinished(_i:int):void
		{
			if(_i == len-1)
			{
				holder.addEventListener(MouseEvent.CLICK,onClickCat);
				var evt:CategoryEvent = new CategoryEvent(CategoryEvent.CATEGORY_COMPLETE,"","");
				dispatchEvent(evt);
			}
		}
		
		protected function onClickCat(e:MouseEvent):void
		{
			selectedId = e.target.id;
			//holder.removeEventListener(MouseEvent.CLICK,onClickCat);
			TweenMax.to(item[selectedId],0.1,{tint:0x857040,glowFilter:{color:0x857040, alpha:1, blurX:20, blurY:20},onComplete:Selected});
			var evt:CategoryEvent = new CategoryEvent(CategoryEvent.CATEGORY_SELECTED,String(arr[selectedId]),String(selectedId));
			dispatchEvent(evt);
		}
		
		protected function Selected():void
		{
			TweenMax.to(item[selectedId],0.1,{tint:null,glowFilter:{color:0x857040, alpha:0, blurX:0, blurY:0}});
			removeAllChildrenAndDestroy(true,true);
			
		}
		
		public  function generateBoard(obj:CatItem,startX:Number,startY:Number,id:Number,totalCol:Number,hGap:int,vGap:int):void {
			
		/*	obj.x = startX + (hGap + obj.width) * (id % totalCol );
			obj.y = startY + (vGap + obj.height) * Math.floor( id / totalCol );*/
			
			obj.x = w-obj.width>>1;
			obj.y = h-obj.height>>1;
			obj.X = (w-(obj.width+vGap)*totalCol+vGap)*0.5 + startX + (hGap + obj.width) * (id % totalCol );
			obj.Y = (h-(obj.height+vGap)*totalCol+vGap)*0.5 + startY + (vGap + obj.height) * Math.floor( id / totalCol );
		}
	}
}