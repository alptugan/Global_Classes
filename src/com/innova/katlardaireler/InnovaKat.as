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
	
	public class InnovaKat extends CasaSprite
	{
		[Embed(source="assets/images/katlar/geri-bg.png")]
		protected var GeriBtnClass:Class;
		
		[Embed(source="assets/images/katlar/message.png")]
		protected var MessageClass:Class;
		
		private var Message:CasaSprite;
		public var GeriBtn:CasaSprite;
		
		
		private var tfKatNo:ATextSingleLine;
		private var tfKat:ATextSingleLine ;
		private var katNo:String;
		
		private var tfButton:ATextSingleLine;
		
		private var tfMessage:AText;
		
		private var bmp:Bitmap;
		private var bmpPath:String;
		private var bmpHolder:CasaSprite;
		
		private var Spots : Vector.<InnovaKatSpot> = new Vector.<InnovaKatSpot>;
		
		private var XMLLoader:BulkLoader;
		
		private var daire :String;

		private var HotSpotLoader:BulkLoader;
		
		private var Holder:CasaSprite;

		private var hotSpotXML:XML;

		private var KatDetail:InnovaKatDetail;
		
		public function InnovaKat(katNo:String,bmpPath:String,daire:String)
		{
			this.katNo   = katNo;
			this.bmpPath = bmpPath;
			this.daire   = daire;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
	
		
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			removeEventListeners();
			removeAllChildren(true,true);
			
			if(XMLLoader)
			{
				XMLLoader.clear();
				XMLLoader.removeAll();
			}			
			
			
		}		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//Main Holder sprite for all ofthe visuals
			Holder = new CasaSprite();
			addChild(Holder);
			
			// kat numarasi
			tfKat = new ATextSingleLine("KAT",Globals.css[7].name,Globals.css[7].color,Globals.css[7].size);
			Holder.addChild(tfKat);
			tfKat.y = -57;
			
			tfKatNo = new ATextSingleLine(this.katNo,Globals.css[8].name,Globals.css[8].color,Globals.css[8].size);
			Holder.addChild(tfKatNo);
			tfKatNo.x = tfKat.x + tfKat.width + 15;
			tfKatNo.y = tfKat.y - ( tfKatNo.height - tfKat.height - 17);
			
			
			//GERİ BUTTON
			GeriBtn = new CasaSprite();
			Holder.addChild(GeriBtn);
			
			
			GeriBtn.visible = false;
			GeriBtn.alpha = 0;
			
			GeriBtn.addChild(new GeriBtnClass() as Bitmap);
			GeriBtn.y = tfKat.y + tfKat.height ;
			//Arrow
			var arrow:Shape = drawArrow(20,34);
			GeriBtn.addChild(arrow);
			Aligner.alignCenter(arrow,GeriBtn,-arrow.width*2-15,-5);
			//GERİ TEXT
			tfButton = new ATextSingleLine("GERİ",Globals.css[9].name,Globals.css[9].color,Globals.css[9].size);
			GeriBtn.addChild(tfButton);
			Aligner.alignCenter(tfButton,GeriBtn,15,-5);
			
			
			//MESSAGE
			Message = new CasaSprite();
			Holder.addChild(Message);
			Message.addChild(new MessageClass() as Bitmap);
			Aligner.alignMiddleHorizontalToBounds(Message,stage.stageWidth-480,0,130);
			
			tfMessage = new AText(Globals.css[10].name,Globals.Style.messages[0].kat2,Globals.css[10].width,Globals.css[10].size,Globals.css[10].color,false,false,"center");
			Message.addChild(tfMessage);
			Aligner.alignCenter(tfMessage,Message,0,0);
			
			//BMP HOLDER
			loadXML();
			
			/*Spots = new InnovaKatSpot("1+1","BAHÇELİ");
			addChild(Spots);*/
		}
		
		/**
		 * ODA HOTSPOTLARININ OLDUĞU KAT PLANININ RESMİ YÜKLENİR 
		 * 
		 */
		private function loadXML():void
		{
			XMLLoader  = new BulkLoader("mapLoader");
			XMLLoader.add(bmpPath);
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
						
			bmpHolder = new CasaSprite();
			Holder.addChild(bmpHolder);
			
			bmp = XMLLoader.getContent(bmpPath,true);
			bmpHolder.addChild(bmp);
			Aligner.alignMiddleHorizontalToBounds(bmpHolder,stage.stageWidth-525,0,330);
			
			
			// LOAD HOT SPOTS XML
			loadHotSpots();
			
			XMLLoader.clear();
			XMLLoader.remove("mapLoader");
		}
		
		//========================================================================================================
		// LOAD HOT SPOTS OF RELATED FLAT
		//========================================================================================================
		
		private function loadHotSpots():void
		{
			//BulkLoader.removeAllLoaders();
			HotSpotLoader  = new BulkLoader("hotspots");
			HotSpotLoader.add(this.daire);
			HotSpotLoader.addEventListener(BulkLoader.COMPLETE, this.onAllHotSpotsLoaded);
			HotSpotLoader.start();
		}
		
		
		private function onAllHotSpotsLoaded(e:Event):void
		{
			HotSpotLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			hotSpotXML = (HotSpotLoader.getContent(this.daire));
			
			var len:int = hotSpotXML.daire.length();
			
			for (var i:int = 0; i < len; i++) 
			{
				Spots[i] = new InnovaKatSpot(hotSpotXML.daire[i].marker.daireNum,hotSpotXML.daire[i].marker.daireInfo,int(hotSpotXML.daire[i].marker.posx),int(hotSpotXML.daire[i].marker.posy));
				Spots[i].name = String(i);
				Spots[i].addEventListener(MouseEvent.CLICK,onClickHotSpots);
				bmpHolder.addChild(Spots[i]);
			}
			
			Cache.getInstance().preKatData = hotSpotXML.toString();
			
			HotSpotLoader.clear();
			HotSpotLoader.remove("hotspots");
			
			
			
			ExternalInterface.addCallback("ContentLoaded",onContentLoaded);
			// BÜyÜK HARİTA BİLGİSİNİ KARŞIYA YOLLA
			ExternalInterface.call("onClickKatlarMap",Cache.getInstance().previousLargeBmp,Cache.getInstance().preKatData,Cache.getInstance().preivousKatInfo);
			
		}
		
		/**
		 * GERİ DÜĞMESİNİ CALLBACK ONAYI GELDİKTEN SONRA GÖSTER 
		 * 
		 */
		private function onContentLoaded():void
		{
			TweenMax.to(GeriBtn,0.5,{autoAlpha:1,ease:Expo.easeOut});
			
		}
		
		
		//========================================================================================================
		// WHEN USER CLICKS ONE OF THE FLATS 
		//========================================================================================================
		protected function onClickHotSpots(e:MouseEvent):void
		{
			GeriBtn.visible = false;
			GeriBtn.alpha = 0;
			SoundCenter.play();
			hideShowHolder(0);
			var id:int = e.target.name;
			//Spots[id].removeEventListener(MouseEvent.CLICK,onClickHotSpots);
			KatDetail = new InnovaKatDetail(hotSpotXML.daire[id].hotSpots,id,hotSpotXML.daire[id].marker[0].info);
			addChild(KatDetail);
			KatDetail.GeriBtn.addEventListener(MouseEvent.CLICK, onClickGeriBtnClicked);
		}		
		
		protected function onClickGeriBtnClicked(e:MouseEvent):void
		{
			KatDetail.GeriBtn.removeEventListener(MouseEvent.CLICK, onClickGeriBtnClicked);
			
			ExternalInterface.addCallback("ContentAddedToStage",onContentLoaded2ndTime);
			SoundCenter.play();
			
			
			if(InnovaKatDetail.panOpened)
			{
				GeriBtn.visible = false;
				GeriBtn.alpha = 0;
				
				KatDetail.alpha = 0;
				
				ExternalInterface.call( "switchy",Cache.getInstance().previousMenu);
				
				
				
				//new delayedFunctionCall(myFunctionToStartLater,{name:Cache.getInstance().previousMenu ,id:0}, 1000);
			}else{
				removeChild(KatDetail);
				KatDetail = null;
				
				//ExternalInterface.call( "onClick2ndGeri",Cache.getInstance().preDairePlanK,Cache.getInstance().preDairePlanB);
				ExternalInterface.call("onClickKatlarMap",Cache.getInstance().previousLargeBmp,Cache.getInstance().preKatData,Cache.getInstance().preivousKatInfo);
				
				
			}
			
			
		}
		
		
		private function onContentLoaded2ndTime():void
		{
			if(InnovaKatDetail.panOpened)
			{
				
				InnovaKatDetail.panOpened = false;
				removeChild(KatDetail);
				KatDetail = null;
				
				ExternalInterface.call("onClickDaire",true,false,true);
				ExternalInterface.call("onClickKatlarMap",Cache.getInstance().previousLargeBmp,Cache.getInstance().preKatData,Cache.getInstance().preivousKatInfo);
			}
			hideShowHolder(1);
		}
		/**
		 * DELAYED FUNCTION : İLK OLARAK ARKA PLANI CAĞIRACAĞIZ
		 * @param param
		 * 
		 */
		private function myFunctionToStartLater(param:Object):void {
			ExternalInterface.call( "onClickMenu", param.name ,String(param.id));
			new delayedFunctionCall(myFunctionToStartLater2,null, 200);
			
		}
		
		/**
		 * DAHA SONRA DA BÜYÜK HARİTA GÖRSELİ GELECEK 
		 * @param param
		 * 
		 */
		private function myFunctionToStartLater2(param:Object):void {
			
			ExternalInterface.call("onClickDaire",true,false);
			ExternalInterface.call("onClickKatlarMap",Cache.getInstance().previousLargeBmp,Cache.getInstance().preKatData,Cache.getInstance().preivousKatInfo);
		}
		
		private function hideShowHolder(val:Number):void
		{
			TweenMax.to(Holder,0.5,{autoAlpha:val,ease:Expo.easeOut,onComplete:function():void{GeriBtn.visible = true;
				GeriBtn.alpha = 1;}});
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