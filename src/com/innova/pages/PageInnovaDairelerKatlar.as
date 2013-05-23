package src.com.innova.pages
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Cache;
	import src.com.innova.Globals;
	import src.com.innova.SoundCenter;
	import src.com.innova.events.KatControllerEvent;
	import src.com.innova.katlardaireler.InnovaKat;
	import src.com.innova.katlardaireler.InnovaKatController;
	import src.com.innova.katlardaireler.valueObjects.KatVO;
	
	public class PageInnovaDairelerKatlar extends Page
	{

		private var katController:InnovaKatController;
		private var katData:Vector.<KatVO> = new Vector.<KatVO>;

		private var title:ATextSingleLine;

		private var XMLLoader:BulkLoader;

		private var kat:InnovaKat;
		private var LargeMaps:String;
		public function PageInnovaDairelerKatlar()
		{
			super();
		}
		
		
		override protected function onRemovedFromStage(event:Event):void
		{

				
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			if(katController)
			{
				katController.destroy();
			}
			
			if(title)
			{
				title.destroy();
			}
			
			if(kat)
				kat.destroy();
			
			dispatchEvent(new Event("PageRemovedFromStage"));
		}
		
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			loadXML();
			
		}
		

		private function loadXML():void
		{
			XMLLoader  = new BulkLoader("karlariyukle");
			XMLLoader.add("xml/daireler.xml");
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			var xml:XML = XMLLoader.getContent("xml/daireler.xml");
			var len:int = xml.item.length();
			
			// LARGE PATH
			LargeMaps= xml.largeSrc[0];
			
			
			for (var i:int = 0; i < len; i++) 
			{
				katData[i]     = new KatVO();
				katData[i].src = xml.item[i].src;
				katData[i].daireSrc = xml.item[i].xml;
				katData[i].info     = xml.item[i].info;
			}
			

			XMLLoader.clear();
			XMLLoader.remove("karlariyukle");
			dispatchEvent(new Event('addedtostage'));
			
			ShowKatlarSpace();
			
		}
		
		private function ShowKatlarSpace():void
		{
			title = new ATextSingleLine("DAİRELER / KATLAR",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
			title.x = 461;
			title.y = 72;
			addChild(title);
			
			//Katlar
			katController = new InnovaKatController();
			katController.x = 659;
			katController.y = 160;
			addChild(katController);
			
			
			katController.addEventListener(KatControllerEvent.DEVAM_CLICK,onClickDevam);
			
			
		}
		
		/**
		 * DEVAMA TIKLAYINCA İLGİLİ KATA GİDER 
		 * @param e
		 * 
		 */
		protected function onClickDevam(e:KatControllerEvent):void
		{
			//HideController();
			katController.removeEventListener(KatControllerEvent.DEVAM_CLICK,onClickDevam);
			
			katController.destroy();
			title.destroy();
			
			RunKatlar(int(e.katNo));
			//katController.cleanMessage();
		}
		
		protected function RunKatlar(no:int):void
		{
			Cache.getInstance().preivousKatInfo = katData[no].info;
			
			// INNOVA KAT BİR SONRAKİ ALT MENÜ CLASS I
			kat = new InnovaKat(String(no),katData[no].src,katData[no].daireSrc);
			addChild(kat);
			
			kat.GeriBtn.addEventListener(MouseEvent.CLICK,onClickGeri);
			
			kat.x = title.x;
			kat.y = title.y + title.height;
			
			//STORE THE LAST OPENED LARGE FLAT IMAGE
			Cache.getInstance().previousLargeBmp = LargeMaps+String(no)+".png";
			
		}
		
		/**
		 * INNOVA KAT İÇİNDEKİ GERİ DÜĞMESİNİN HANDLER I
		 * ASASÖR SİSTEMİNİ GERİ GETİRİYOR
		 * @param e
		 * 
		 */
		protected function onClickGeri(e:MouseEvent):void
		{
			
			kat.GeriBtn.removeEventListener(MouseEvent.CLICK,onClickGeri);
			ExternalInterface.call("onClickDaire",false,true);
			SoundCenter.play();
			//ShowController();
			ShowKatlarSpace();
			
			
			kat.removeAllChildren(true,true);
			kat = null;	
		}
		
		private function ShowController():void
		{
			TweenMax.to(title,0.5,{autoAlpha:1,ease:Expo.easeOut});
			TweenMax.to(katController,0.5,{autoAlpha:1,ease:Expo.easeOut});
		}
		
		private function HideController():void
		{
			TweenMax.to(title,0.5,{autoAlpha:0,ease:Expo.easeOut});
			TweenMax.to(katController,0.5,{autoAlpha:0,ease:Expo.easeOut});
		}
	}
}