package src.com.innova.pages
{
	import com.alptugan.events.AccordionMenuEvent;
	import com.alptugan.layout.Aligner;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import nl.stroep.flashflowfactory.Page;
	import nl.stroep.flashflowfactory.events.PageEvent;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	import src.com.innova.InnovaMessage;
	import src.com.innova.button.DurdurBtnClass;
	import src.com.innova.events.AMenuAccordionEvent;
	
	public class PapgeInnovaProjFilm extends Page
	{
		[Embed(source="assets/images/giris.png")]
		protected var GirisClass:Class;
		
		private var giris:Bitmap;
		
		[Embed(source="assets/images/video/oynat.png")]
		protected var OynatClass:Class;
		
		
		private var dur:DurdurBtnClass ;
		private var oynat:CasaSprite;
		private var holder:CasaSprite;
		private var girisHolder:CasaSprite;
		
		
		public function PapgeInnovaProjFilm()
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var title:ATextSingleLine = new ATextSingleLine("PROJE FİLMİ",Globals.css[3].name,Globals.css[3].color,Globals.css[3].size);
			title.x = 461;
			title.y = 72;
			addChild(title);
			
			girisHolder = new CasaSprite();
			addChild(girisHolder);
			giris = new GirisClass() as Bitmap;
			
			girisHolder.addChild(giris);
			girisHolder.addEventListener(MouseEvent.CLICK,onClickGris);
			//Load  Message Board
			/*var welcome:InnovaMessage = new InnovaMessage(Globals.Style.messages[0].welcome[0].toString());
			addChild(welcome);*/
			
			// Holder
			holder = new CasaSprite();
			addChild(holder);
			
			oynat = new CasaSprite();
			oynat.name="oynat";
			holder.addChild(oynat);
			
			oynat.addChild(new OynatClass() as Bitmap);
			
			oynat.mouseChildren = false;
			oynat.x = title.x;
			oynat.y = title.y + title.height + 5;
			oynat.visible = false;
			oynat.alpha = 0;
			
			// durdur
			dur = new DurdurBtnClass();
			dur.mouseChildren = false;
			holder.addChild(dur);
			dur.name = "don";
			dur.x = oynat.x ;
			
			dur.y = oynat.y;
			
			Aligner.alignCenter(giris,stage,450,0);
			
			
			
			holder.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			holder.addEventListener(MouseEvent.MOUSE_UP,onUp);
			
			
			dispatchEvent(new Event('addedtostage'));
		}
		
		protected function onClickGris(e:MouseEvent):void
		{
			girisHolder.removeEventListener(MouseEvent.CLICK,onClickGris);
			
			
			var evt:AMenuAccordionEvent = new AMenuAccordionEvent(AMenuAccordionEvent.MENU_CLICKED,1,"daireler","ext");
			
			dispatchEvent(evt);
		}
		
		protected function onDown(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "don":
				{
					dur.switchOnOff();
					TweenMax.to(dur,0.5,{autoAlpha:0});
					TweenMax.to(oynat,0.5,{tint:0x7ac4e0,ease:Expo.easeOut,autoAlpha:1});
					ExternalInterface.call("stopVideo");
					break;
				}
					
				
				case "oynat":
				{
					
					dur.switchOnOff();
					TweenMax.to(dur,0.5,{autoAlpha:1});
					ExternalInterface.call("playVideo");
					break;
				}
					
					
			}
		}
		
		protected function onUp(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "don":
				{
					TweenMax.to(oynat,0.5,{tint:null,ease:Expo.easeOut});
					break;
				}
					
					
				case "oynat":
				{
					
					TweenMax.to(oynat,0.5,{tint:null,ease:Expo.easeOut,autoAlpha:0});
					break;
				}
					
					
			}
		}
		
		protected function onCompleteShow(event:PageEvent):void
		{
			trace("I^m done");
		}
		
		override protected function onRemovedFromStage(event:Event):void
		{
			dispatchEvent(new Event("PageRemovedFromStage"));
		}
	}
}