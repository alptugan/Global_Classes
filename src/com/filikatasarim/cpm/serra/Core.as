package src.com.filikatasarim.cpm.serra
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import flashx.textLayout.elements.BreakElement;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.filikatasarim.cpm.serra.events.CategoryEvent;
	import src.com.filikatasarim.cpm.serra.events.SubCategoryEvent;
	import src.com.filikatasarim.cpm.serra.items.CatItem;
	import src.com.filikatasarim.cpm.serra.items.TagItem;
	
	
	public class Core extends CasaSprite
	{
		//[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-Bd.otf", embedAsCFF="false", fontName="medium", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-LtCn.otf", embedAsCFF="false", fontName="medium", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Roman:Class;
		
		[Embed(source="assets/serra.png")]
		protected var SerraClass:Class;
		
		private var Serra:CasaSprite;
		private var sh:int;
		private var sw:int;

		private var cat:Categories;
		
		private var TagHolder:CasaSprite;

		private var catId:int;

		private var catName:String;

		private var selectedTag:TagItem;

		private var subcat:SubCategories;
		
		private var ContentHolder:CasaSprite;
		private var subcatName:String;
		private var subcatId:int;

		private var large:LargeImages;
		private var catTxt:ATextSingleLine;
		
		public function Core()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			initBg();
			initLogo();
			loadXML();
		}
		
		private function initBg():void
		{
			sw = stage.stageWidth;
			sh = stage.stageHeight;
			var bg:RectShape = new RectShape(new Rectangle(0,0,sw,sh),new FillStyle(0xffffff));
			addChild(bg);
		}
		
		private function initLogo():void
		{
			Serra = new CasaSprite();
			addChild(Serra);
			
			Serra.addChild(new SerraClass() as Bitmap);
			Aligner.alignToCenterTopToBounds(Serra,stage.stageWidth,0,36);
			
			catTxt = new ATextSingleLine('',FontNamesFB.medium,0x857040,22);
			addChild(catTxt);
			catTxt.alpha = 0.7;
			catTxt.x = Serra.x + 62;
			catTxt.y = Serra.height + Serra.y - 20;
		}
		
		private function loadXML():void
		{
			Globals.GlobalXML();
			Globals.XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			Globals.XMLLoader.addEventListener(BulkLoader.PROGRESS, Globals.onAllProgress);
			Globals.XMLLoader.start();
		}
		
		
		private function onAllLoaded(e:Event):void
		{
			Globals.XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			Globals.XMLLoader.removeEventListener(BulkLoader.PROGRESS, Globals.onAllProgress);
			Globals.onAllXMLLoaded();
			
			//trace(Globals.ContentXML);
			
			SerraGlobals.getInstance().catLen = Globals.ContentXML.category.length();
			
			for (var i:int = 0; i < SerraGlobals.getInstance().catLen; i++) 
			{
				SerraGlobals.getInstance().cat[i] = Globals.ContentXML.category[i].@name;
				SerraGlobals.getInstance().catThumbs[i] = Globals.ContentXML.category[i].@thumb;
				
				/*for (var j:int = 0; j < SerraGlobals.getInstance().cat[i].catLen; j++) 
				{
					SerraGlobals.getInstance().subcatLen =
				}*/
			}
			
			ContentHolder = new CasaSprite();
			addChild(ContentHolder);
			
			
			
			TagHolder = new CasaSprite();
			addChild(TagHolder);
			
			
			
			
			initCategories();
		}
		
		
		private function initCategories():void
		{
			cat = new Categories(SerraGlobals.getInstance().cat,SerraGlobals.getInstance().catThumbs);
			ContentHolder.addChild(cat);
			cat.addEventListener(CategoryEvent.CATEGORY_SELECTED,onCatSelected);
		}
		
		
		/**
		 * WHEN CATEGORY IS CLIKED REMOVE EVERTHING
		 * ADD TAGS
		 * ADD RELATED SUBCATEGORY CLASS TO DISPLAY LIST 
		 * @param e
		 * 
		 */
		protected function onCatSelected(e:CategoryEvent):void
		{
			cat.removeEventListener(CategoryEvent.CATEGORY_SELECTED,onCatSelected);
			catName = e.catName;
			catId = int(e.catId);
			
			
			/*catId = getCatId(SerraGlobals.getInstance().pageId);
			catName = Globals.ContentXML.category[catId].@name;
			*/
			SerraGlobals.getInstance().catName = catName;
			//trace('catName : ',catName);
			
			addTagItem('SERRA');
			catTxt.SetText(catName);
			catTxt.x = (stage.stageWidth - catTxt.width) *0.5 - 35;
			catTxt.y = Serra.height + Serra.y - 30;
			initSubCategories();
		}
		
		
		
		
		private function initSubCategories():void
		{
			SerraGlobals.getInstance().subcatLen = Globals.ContentXML.category[catId].subcategory.length();
			
			for (var i:int = 0; i < SerraGlobals.getInstance().subcatLen; i++) 
			{
				SerraGlobals.getInstance().subcat[i] = Globals.ContentXML.category[catId].subcategory[i].@name;
				SerraGlobals.getInstance().subcatThumbs[i] = Globals.ContentXML.category[catId].subcategory[i].@thumb;
			}
			
			subcat = new SubCategories(SerraGlobals.getInstance().subcat,SerraGlobals.getInstance().subcatThumbs);
			ContentHolder.addChild(subcat);
			subcat.addEventListener(SubCategoryEvent.SUBCATEGORY_SELECTED,onSubCatSelected);
			//addTagItem(catName);
			
		}
		
		protected function onSubCatSelected(e:SubCategoryEvent):void
		{
			subcat.removeEventListener(SubCategoryEvent.SUBCATEGORY_SELECTED,onSubCatSelected);
			
			subcatName = e.subcatName;
			subcatId = int(e.subcatId);
			
			addTagItem(SerraGlobals.getInstance().catName);
			//addTagItem(Globals.ContentXML.category.subcategory.pages.page.(@id==String(SerraGlobals.getInstance().pageId)).parent().parent().parent().@name);
			initLargeImages();
		}
		
		private function initLargeImages():void
		{
			/*SerraGlobals.getInstance().imagesLen = Globals.ContentXML.category[catId].subcategory[subcatId].pages.page.length();
			
			for (var i:int = 0; i < SerraGlobals.getInstance().imagesLen; i++) 
			{
				SerraGlobals.getInstance().images[i] = Globals.ContentXML.category[catId].subcategory[subcatId].pages.page[i];
			}*/
			
			large = new LargeImages(Globals.ContentXML.category[catId].subcategory[subcatId].pages.page[0].@id);
			large.addEventListener('tag',OnUpdateTag);
			ContentHolder.addChild(large);
			
		
		}
		
		protected function OnUpdateTag(e:Event):void
		{
			
			//trace(Globals.ContentXML.category.subcategory.pages.page.(@id==String(SerraGlobals.getInstance().pageId)).parent().parent().parent().@name);
			TagHolder.removeChildAt(1);
			
			catId = getCatId(SerraGlobals.getInstance().pageId);
			subcatId = getSubCatId(SerraGlobals.getInstance().pageId);
			SerraGlobals.getInstance().catName = Globals.ContentXML.category.subcategory.pages.page.(@id==String(SerraGlobals.getInstance().pageId)).parent().parent().parent().@name;
			addTagItem(SerraGlobals.getInstance().catName);
			
			catTxt.SetText(catName);
			catTxt.x = (stage.stageWidth - catTxt.width) *0.5 - 35;
			catTxt.y = Serra.height + Serra.y - 30;
		}		
		
		protected function addTagItem(src:String):void
		{
			var tag:TagItem = new TagItem(src);
			tag.x = TagHolder.width + 10;
			tag.name = src;
			tag.catId = catId;
			tag.subCatId = subcatId;
			tag.addEventListener(MouseEvent.CLICK,onClickTag);
			//tag.addEventListener(MouseEvent.MOUSE_UP,onMouseUpTag);
			TagHolder.addChild(tag);
			
			Aligner.alignBottomMiddleToBounds(TagHolder,sw,sh,0,-10);
		}
		
		private function getCatId(idd:int):int
		{
			var catIDReturn:int = -1;
			for (var i:int = 0; i < Globals.ContentXML.category.length(); i++) 
			{
				
				//trace('komencero : ',Globals.ContentXML.category[i].subcategory.pages.page.length());
				for (var j:int = 0; j < Globals.ContentXML.category[i].subcategory.pages.page.length(); j++) 
				{
					
					if(Globals.ContentXML.category[i].subcategory.pages.page[j].@id == String(idd))
					{
						catIDReturn = i;
						break;
					}
						
				}
				if(catIDReturn != -1)
					break;
				
			}
			
			return catIDReturn;
		}
		
		private function getSubCatId(idd:int):int
		{
			var catSubIDReturn:int = -1;
			for (var i:int = 0; i < Globals.ContentXML.category.subcategory.length(); i++) 
			{
				
				//trace('komencero : ',Globals.ContentXML.category[i].subcategory.pages.page.length());
				for (var j:int = 0; j < Globals.ContentXML.category.subcategory[i].pages.page.length(); j++) 
				{
					
					if(Globals.ContentXML.category.subcategory[i].pages.page[j].@id == String(idd))
					{
						catSubIDReturn = i;
						break;
					}
					
				}
				if(catSubIDReturn != -1)
					break;
				
			}
			
			return catSubIDReturn;
		}
		
		protected function onClickTag(e:MouseEvent):void
		{
			subcat.reset();
			selectedTag = TagHolder.getChildByName(e.target.name) as TagItem;
			TweenMax.to(selectedTag,0.1,{tint:0xbe9f58,glowFilter:{color:0xbe9f58, alpha:1, blurX:30, blurY:30}});
			
			while(ContentHolder.numChildren > 0)
				ContentHolder.removeChildAt(0);
		
			if(e.target.name == 'SERRA' )
			{
				catTxt.SetText('');
				catTxt.x = (stage.stageWidth - catTxt.width) *0.5 - 35;
				catTxt.y = Serra.height + Serra.y - 30;
				catId = 0;
				subcatId = 0;
				while(TagHolder.numChildren > 0)
					TagHolder.removeChildAt(0);
				
				initCategories();
			}else{
				//trace(selectedTag.catId,selectedTag.subCatId);
				//catId = selectedTag.catId;
				catTxt.SetText(SerraGlobals.getInstance().catName);
				catTxt.x = (stage.stageWidth - catTxt.width) *0.5 - 35;
				catTxt.y = Serra.height + Serra.y - 30;
				catId = getCatId(SerraGlobals.getInstance().pageId);
				initSubCategories();
				
				
			}
			
			
			selectedTag.removeAllChildrenAndDestroy(true,true);
		}
		
		protected function onMouseUpTag(e:MouseEvent):void
		{
			TweenMax.to(selectedTag,0.1,{tint:null,glowFilter:{color:0xffb358, alpha:0, blurX:0, blurY:0}});
			selectedTag.removeAllChildrenAndDestroy(true,true);
		}
		
		
	}
}