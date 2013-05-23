package src.com.innova.katlardaireler
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Cache;
	import src.com.innova.Globals;
	import src.com.innova.SoundCenter;
	import src.com.innova.katlardaireler.valueObjects.PanaromaVO;
	
	public class InnovaKatDetail extends CasaSprite
	{
		[Embed(source="assets/images/katlar/geri-bg.png")]
		protected var GeriBtnClass:Class;
		
		
		public var GeriBtn:CasaSprite;
		private var tfButton:ATextSingleLine;
		
		//title
		private var tfTitle : AText;
		//Square 2
		private var pow:ATextSingleLine;
		
		//XML LIST
		private var datalist:XMLList;
		private var panaromaVo:Vector.<PanaromaVO> = new Vector.<PanaromaVO>;
		
		//title of the selected Flat
		private var title:String;
		
		
		//small thumb src
		private var small:String;
		private var smallBmp:Bitmap;
		
		//large pic
		private var large:String;
		private var largeBmp:Bitmap;
		private var largeHolder:CasaSprite;
		private var sideImage:String;
		private var XMLLoader:BulkLoader;

		private var panLen:int;
		
		// Panaroma Markers
		private var Markers : Vector.<InnovaKatDetailSpot> = new Vector.<InnovaKatDetailSpot>;
		public static var panOpened:Boolean = false;
		private var id:int;
		private var w:Number;
		private var h:Number;

		/**
		 * 
		 */
		private var kont:InnovaKatPanaromaController;
		private var info:String;
		
		public function InnovaKatDetail(datalist:XMLList,id:int,info:String)
		{
			this.datalist = datalist;
			this.y = -96;
			this.info = info;
			this.id = id;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			panaromaVo.length = 0;
			removeEventListeners();
			
		/*
			removeChild(pow);
			pow = null;
			*/
			GeriBtn.removeAllChildrenAndDestroy(true,true);
			
			if(XMLLoader)
			{
				XMLLoader.clear();
				XMLLoader.remove("imageloaderpanaroma");
			}
			
			if(kont)
			{
				removeChild(kont);
				kont = null;
			}
			
			
			largeHolder.removeAllChildrenAndDestroy(true,true);
			trace('InnovaKatDetail is removed from stage');
		}
		
		//========================================================================================================
		// PARSE XML DATA
		//========================================================================================================
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			parseXMLList();	
			
		}
		
		//========================================================================================================
		// parseXMLList
		//========================================================================================================
		private function parseXMLList():void
		{
			//title = datalist.title;
			small = datalist.thumb;
			large = datalist.large;
			sideImage = datalist.side;
			
			panLen = datalist.panaroma.length();
			
			for (var i:int = 0; i < panLen; i++) 
			{
				
				panaromaVo[i] = new PanaromaVO();
				panaromaVo[i]._info = datalist.panaroma[i].daireInfo;
				panaromaVo[i]._x = datalist.panaroma[i].posx;
				panaromaVo[i]._y = datalist.panaroma[i].posy;
				panaromaVo[i]._src = datalist.panaroma[i].src;				
			}
						
			LoadImages();
			addTitle();
			addGeriButton();
		}		
		
		//========================================================================================================
		// Load Images 
		//========================================================================================================
		private function LoadImages():void
		{
			//BulkLoader.removeAllLoaders();
			XMLLoader  = new BulkLoader("imageloaderpanaroma");
			XMLLoader.add(small);
			XMLLoader.add(large);
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			// load thumb small image
			/*smallBmp = XMLLoader.getContent(small);
			addChild(smallBmp);
			Aligner.alignToRight(smallBmp,this.parent,-160);
			*/
			// load large bmp holder
			largeHolder = new CasaSprite();
			addChild(largeHolder);
			
			// load large bmp
			largeBmp = XMLLoader.getContent(large);
			largeHolder.addChild(largeBmp);
			Aligner.alignMiddleHorizontalToBounds(largeHolder,stage.stageWidth-515,0,330);
			
			XMLLoader.clear();
			XMLLoader.remove("imageloaderpanaroma");
			
			
			addHotSpotMarkers()
			
		}
		
		
		//========================================================================================================
		// Add TITLE
		//========================================================================================================
		private function addTitle():void
		{
			//Title
			tfTitle = new AText(Globals.css[7].name,this.info,400,Globals.css[7].size,Globals.css[7].color);
			addChild(tfTitle);
			tfTitle.y = -10;
			// pow
			/*pow     = new ATextSingleLine("2",Globals.css[7].name,Globals.css[7].color,20);
			addChild(pow);
			pow.x = tfTitle.y + tfTitle._tf.textWidth + 10;
			pow.y = tfTitle.y + 5;*/
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
			GeriBtn.y = tfTitle.y + tfTitle.height ;
			//Arrow
			var arrow:Shape = drawArrow(20,34);
			GeriBtn.addChild(arrow);
			Aligner.alignCenter(arrow,GeriBtn,-arrow.width*2-15,-5);
			//GERİ TEXT
			tfButton = new ATextSingleLine("GERİ",Globals.css[9].name,Globals.css[9].color,Globals.css[9].size);
			GeriBtn.addChild(tfButton);
			Aligner.alignCenter(tfButton,GeriBtn,15,-5);
			
			
		}
		
		
		//========================================================================================================
		// Add HOT SPOT MARKERS
		//========================================================================================================
		private function addHotSpotMarkers():void
		{
			
			
			for (var i:int = 0; i < panLen; i++) 
			{
				Markers[i] = new InnovaKatDetailSpot(panaromaVo[i]._info,int(panaromaVo[i]._x),int(panaromaVo[i]._y));
				Markers[i].name = String(i);
				Markers[i].addEventListener(MouseEvent.CLICK,onClickMarkers);
				Markers[i].scaleX = Markers[i].scaleY = 0.7;
				largeHolder.addChild(Markers[i]);
				
				Markers[i].orjH = Markers[i].height;
				Markers[i].orjW = Markers[i].width;
				Markers[i].orjX = int(panaromaVo[i]._x);
				Markers[i].orjY = int(panaromaVo[i]._y)
			}
			
			/*Cache.getInstance().preDairePlanB = large;
			Cache.getInstance().preDairePlanK = small;*/
			
			//convert it to xml in order to send it via external interface
			var data:String = datalist.toXMLString(); 
			data = "<your_root_tag>"+data+"</your_root_tag>"; 
			Cache.getInstance().preDaireData = data;
			ExternalInterface.call("onClickDairePlani",sideImage,large,data,id,info);
			
		}
		
		protected function onClickMarkers(e:MouseEvent):void
		{
			GeriBtn.alpha = 0;
			GeriBtn.visible = false;
			SoundCenter.play();
			var id:int = e.target.name;
			
			var src:String = panaromaVo[id]._src;
			w = largeBmp.width;
			h = largeBmp.height;
			
			ExternalInterface.call( "onClickPanaromaSpot", src);
			if(!panOpened)
			{
				//Markers[id].removeEventListener(MouseEvent.CLICK,onClickMarkers);
				
				kont = new InnovaKatPanaromaController(panaromaVo[id]._info);
				addChild(kont);
				kont.x = -17;
				kont.y = 506;
				
				TweenMax.to(largeHolder,0.5,{scaleX:0.6,scaleY:0.6,y:kont.y - h + largeBmp.height*0.3,ease:Expo.easeOut,onComplete:function():void{
					
					TweenMax.to(largeHolder,0.5,{x:(stage.stageWidth - largeHolder.width) - 500,ease:Expo.easeOut});
					/*
					
					for (var i:int = 0; i < panLen; i++) 
					{
						TweenMax.to(Markers[i],0.5,{scaleX:1.6,scaleY:1.6,ease:Expo.easeOut});
					}*/
					TweenMax.to(GeriBtn,0.5,{delay:0.2,autoAlpha:1,ease:Expo.easeOut});
				}});
				
				
				ExternalInterface.call( "switchy","");
				
				
				panOpened = true;
			}else{
				TweenMax.to(GeriBtn,0.5,{delay:0.2,autoAlpha:1,ease:Expo.easeOut});
				kont.resett(panaromaVo[id]._info);
				kont.grid.drawCanvas();
				ExternalInterface.call("change");
			}
			
			
			
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
	}
}