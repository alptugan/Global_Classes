package src.com.innova
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.menu.AMenuAccordion;
	
	public class ConstantVisuals extends CasaSprite
	{
		public var logo:Bitmap;
		private var mlogo:Bitmap;
		private var menuBg:RectShape;
		private var Footer:Bitmap;
		private var menuShadow:Bitmap;
		
		private var XMLLoader:Object;
		
		public var soundIcon:Bitmap;
		public var soundBg:Bitmap;
		public var soundActive:Bitmap;
		public var soundTracker:Bitmap;
		public var Player:InnovaSoundPlayer;
		public var Exit:CasaSprite;
		public var MainVolume:Number ;
		public var menu:AMenuAccordion;
		
		public function ConstantVisuals()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			loadXML();
		}
		
		
		private function loadXML():void
		{
			XMLLoader = new BulkLoader("Cons");
			XMLLoader.add(String(Globals.Style.assets[0].logo[0]),{id:"css"});
			XMLLoader.add(String(Globals.Style.assets[0].sub[0]));
			XMLLoader.add(String(Globals.Style.assets[0].mlogo[0]));
			XMLLoader.add(String(Globals.Style.assets[0].menushadow[0]));
			XMLLoader.add(String(Globals.Style.assets[0].soundicon[0]));
			XMLLoader.add(String(Globals.Style.assets[0].soundbg[0]));
			XMLLoader.add(String(Globals.Style.assets[0].soundactive[0]));
			XMLLoader.add(String(Globals.Style.assets[0].soundtracker[0]));
			XMLLoader.add(String(Globals.Style.assets[0].exit[0]));
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			//XMLLoader.addEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			
			XMLLoader.start();
		}
		/*
		private function onAllProgress(e:BulkProgressEvent):void
		{
			//trace("alo : ",Math.round(e.bytesLoaded / e.bytesTotal * 100 )  );
		}
		*/
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
		//	XMLLoader.removeEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			
			logo = XMLLoader.getBitmap(Globals.Style.assets[0].logo[0]);
			addChild(logo);
			
			
			//Footer
			Footer = XMLLoader.getBitmap(Globals.Style.assets[0].sub[0]);
			
			addChild(Footer);
			Footer.y = stage.stageHeight-Footer.height;
		
			// Menu Shadow
			
			menuShadow = XMLLoader.getBitmap(Globals.Style.assets[0].menushadow[0]);
			menuShadow.height = stage.stageHeight;
			menuShadow.x = logo.width-2;
			addChildAt(menuShadow,0);
			
			
			//Menu
			menu = new AMenuAccordion(Globals.css[1].name,Globals.css[1].size,Globals.css[1].color);
			menu.y = 160;
			menu.addEventListener(Event.ADDED_TO_STAGE,onMenuAddedToStage);
			addChild(menu);
			
			// Sound player
			soundIcon = XMLLoader.getBitmap(Globals.Style.assets[0].soundicon[0]);
			//addChild(soundIcon);
			
			soundBg = XMLLoader.getBitmap(Globals.Style.assets[0].soundbg[0]);
			//addChild(soundBg);
			Aligner.alignLeft(soundBg,soundIcon,47);

			soundActive = XMLLoader.getBitmap(Globals.Style.assets[0].soundactive[0]);
			//addChild(soundActive);
			Aligner.alignLeft(soundActive,soundIcon,47);
			
			soundTracker = XMLLoader.getBitmap(Globals.Style.assets[0].soundtracker[0]);
			//addChild(soundTracker);
			
			
			// Sound PLayer with volume
			MainVolume = Globals.Style.global.volume;
			if(MainVolume > 1.)
				MainVolume = 1.;
			Player = new InnovaSoundPlayer(Globals.Style.assets[0].sound[0],soundIcon,soundBg,soundActive,soundTracker,MainVolume);
			
			Player.addEventListener("loaded",onLoaded);
			addChild(Player);
			
			// Exit Button
			Exit = new CasaSprite();
			Exit.x = 40;
			Exit.y = 961;
			Exit.addEventListener(MouseEvent.CLICK,onClickExit);
			addChild(Exit);
			Exit.addChild(new Bitmap(XMLLoader.getBitmapData(Globals.Style.assets[0].exit[0])));
			
			
			Aligner.alignToCenterOf(Player,Footer,-34,30);
				
			XMLLoader.clear();
			XMLLoader.removeAll();
			
			
			
		}
		
		protected function onClickExit(e:MouseEvent):void
		{
			//Exit.removeEventListener(MouseEvent.CLICK,onClickExit);
			ExternalInterface.call("onClickExit");
		}
		
		protected function onLoaded(e:Event):void
		{
			Player.removeEventListener("loaded",onLoaded);
			//Player.stop();
		}
		
		public function setSubMenu(id:int):void
		{
			trace("submenu : ",id);
			menu.setSubMenu(id);
		}
		
		public function setMenu(id:int):void
		{
			trace("goro : ",id);
			menu.MainMenuClicked(id);
		}
		
		protected function onMenuAddedToStage(e:Event):void
		{
			menu.removeEventListener(Event.ADDED_TO_STAGE,onMenuAddedToStage);
			dispatchEvent(new Event("menu_added"));
		}
	}
}