package src.com.innova.pages
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import nl.stroep.flashflowfactory.Page;
	
	import src.com.innova.Globals;
	import src.com.innova.SoundCenter;
	import src.com.innova.button.LokasyonButton;
	
	public class PageInnovaLokasyon extends Page
	{
		private var XMLLoader:BulkLoader;

		private var xml:XML;
		private var id:int = -1;
		private var buttons:Vector.<LokasyonButton> = new Vector.<LokasyonButton>;
		private var bmp : Bitmap;

		private var len:int;

		private var title:ATextSingleLine;

		
		public function PageInnovaLokasyon()
		{
			super();
			
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			title = new ATextSingleLine("LOKASYON",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
			title.x = 461;
			title.y = 72;
			addChild(title);
			
			loadXML();
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			dispatchEvent(new Event("PageRemovedFromStage"));
			XMLLoader.removeAll();
			XMLLoader.clear();
			if(XMLLoader.isFinished)
			{
				for (var i:int = 0; i < len; i++) 
				{
					buttons[i].bmp = null;
					buttons[i].removeAllChildrenAndDestroy(true,true);
					buttons[i].removeEventListeners();
				}
			}
			
		}
		
	
		private function loadXML():void
		{
			XMLLoader = new BulkLoader("lokasyon");
			XMLLoader.add("xml/lokasyon.xml");
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);			
			
			xml = XMLLoader.getContent("xml/lokasyon.xml");
						
			len = xml.item.length();
			
			
			for (var i:int = 0; i < len; i++) 
			{
				//trace(xml.item[i].name,xml.item[i].src);
				buttons[i] = new LokasyonButton(xml.item[i].name);
				buttons[i].addEventListener(MouseEvent.CLICK,onClick);
				
				addChild(buttons[i]);
				buttons[i].name = String(i);
				buttons[i].x = title.x + buttons[i].x + (buttons[i].width - 2) * i;
				buttons[i].y = 203;
				buttons[i].src = xml.item[i].src;
				XMLLoader.add(buttons[i].src.toString());
			}
			
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllImageLoaded);
			XMLLoader.start();
		}
		
		protected function onAllImageLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllImageLoaded);
			
			
			for (var i:int = 0; i < len; i++) 
			{
				//trace(xml.item[i].name,xml.item[i].src);
				buttons[i].bmp = XMLLoader.getContent(buttons[i].src.toString());
				addChild(buttons[i].bmp);
				buttons[i].bmp.visible = false;
				buttons[i].bmp.alpha = 0;
				buttons[i].bmp.x = buttons[0].x - 30;
				buttons[i].bmp.y = buttons[0].y + buttons[0].height + 30;
				buttons[i].bmp.smoothing = true;
				buttons[i].bmp.scaleX = buttons[i].bmp.scaleY = 0.6;
			}
			
			
			XMLLoader.clear();
			XMLLoader.remove("lokasyon");
			
			setClicked(0);
		}
		
		private function setClicked(ind:int):void
		{
			if(id != -1)
			{
				buttons[id].addEventListener(MouseEvent.CLICK,onClick);
				buttons[id].setUnClicked();
				TweenMax.to(buttons[id].bmp,0.3,{autoAlpha:0,ease:Strong.easeOut});
			}
			
			id = ind;
			
			buttons[id].removeEventListener(MouseEvent.CLICK,onClick);
			buttons[id].setClicked();
			TweenMax.to(buttons[id].bmp,0.3,{autoAlpha:1,ease:Strong.easeOut,onComplete:function():void{
				// TODO LOKASYON HARİTA DEGİĞİŞİM FONKSİYONU BURDAN ÇAĞIRILACAK

				ExternalInterface.call("changeLokasyon",id);
				dispatchEvent(new Event('addedtostage'));
			}});
			
			
		}
		
		protected function onClick(e:MouseEvent):void
		{
			SoundCenter.play();
			setClicked(e.target.name);
		}
	}
}