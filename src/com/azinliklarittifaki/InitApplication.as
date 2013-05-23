package src.com.azinliklarittifaki
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.events.AccordionMenuEvent;
	import com.alptugan.globals.Root;
	import com.alptugan.media.Mp3BgPlayer;
	import com.alptugan.preloader.PreloaderMacStyle;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import nl.stroep.flashflowfactory.PageFactory;
	import nl.stroep.flashflowfactory.PageSettings;
	import nl.stroep.flashflowfactory.enum.Alignment;
	import nl.stroep.flashflowfactory.transitions.FadeTransition;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.util.StringUtil;
	
	import src.com.azinliklarittifaki.gallery.GalleryMain;
	import src.com.azinliklarittifaki.pages.*;
	
	
	/*
	<    &lt;
	>    &gt;
	"   &quo;
	'   &apos;
	&   &amp;
	*/
	public class InitApplication extends Root
	{
		[Embed(source="com/alptugan/assets/font/uni05_54.ttf", embedAsCFF="false", fontName="regular", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Roman:Class;
		
		[Embed(source="com/alptugan/assets/font/uni05_64.ttf", embedAsCFF="false", fontName="bold", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Bold:Class;
		
		[Embed(source="assets/mail.png")]
		protected var MailClass:Class;
		
		private var mailBtn:CasaSprite;
		
		
		private var topmenu:Header;
		
		private var bg:NoisyBackground;
		private var pageFactory:PageFactory;

		private var sound:Mp3SpeakerPlayer;

		private var lastClicked:String;
		private var lastId:int;
		
		public function InitApplication()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			initStage();
			initBackground();
			loadXML();
			//initDebugView();
			
		}
		
	
		
		private function initBackground():void
		{
			bg = new NoisyBackground();
			addChild(bg);
		}
		
		private function loadXML():void
		{
			Globals.GlobalXML();
			Globals.XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			Globals.XMLLoader.addEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			Globals.XMLLoader.start();
		}
		
		private function onAllProgress(e:BulkProgressEvent):void
		{
			//trace("alo : ",Math.round(e.bytesLoaded / e.bytesTotal * 100 )  );
		}
		
		private function onAllLoaded(e:Event):void
		{
			Globals.XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			Globals.XMLLoader.removeEventListener(BulkLoader.PROGRESS, this.onAllProgress);
			Globals.onAllXMLLoaded();
			
			initMenu();
			//trace(Globals.Style);
		}
		
		private function initMenu():void
		{
			sound = new Mp3SpeakerPlayer();
			addChild(sound);
			alignRight(sound,-20,35);
			
			topmenu = new Header(Globals.MenuXpos,Globals.MenuYpos);
			addEventListener(AccordionMenuEvent.MENU_ADDED_TO_STAGE,onMenuAddedToStage,true);
			addChild(topmenu);
			topmenu.Menu.MainMenuClicked(4);
			addEventListener(AccordionMenuEvent.CONTENT_ADDED_TO_STAGE, onMenuItemClicked,true);
			
			
			FontNamesFB.regular = 'regular';
			
			pageFactory = new PageFactory();
			
			
			Giris;
			Bilgi;
			Dusler;
			Fotograflar;
			Notlar;
			Mail;
			
			var basePath:String = "src.com.azinliklarittifaki.pages."
				
			// add your pages here
			var menuLen:int = Globals.Style.menu.item.length();
			
			for (var i:int = 0; i < menuLen; i++) 
			{
				var ClassReference:Class = getDefinitionByName(basePath + StringUtil.toTitleCase(Globals.Style.menu.item[i].@query)) as Class;
				
				pageFactory.add("/"+Globals.Style.menu.item[i].@query,ClassReference,Globals.Style.menu.item[i].@query);
			}
			
			pageFactory.add('/mail',Mail);
			
			pageFactory.defaultSettings = new PageSettings( 
				new FadeTransition(),   // transition (there are more transitions + you can easily create your own)
				Strong.easeOut,         // easing of the in-transition 
				Strong.easeIn,           // easing of the out-transition 
				1,                       // duration of the in-transition 
				0.7,                     // duration of the out-transition 
				Alignment.LEFT_TOP, // alignment of the page on the stage
				Alignment.LEFT_TOP       // centerpoint position of the page
			);
			
			
			pageFactory.defaultPageName = "/fotograflar";
			lastClicked = "fotograflar";
			lastId = 4;
			// add page holder to stage
			addChild( pageFactory.view );
			
			// load intropage
			pageFactory.init();
			
			
			
		}		
		
		protected function onMenuAddedToStage(e:AccordionMenuEvent):void
		{
			removeEventListener(AccordionMenuEvent.MENU_ADDED_TO_STAGE,onMenuAddedToStage,true);
			mailBtn = new CasaSprite();
			mailBtn.mouseChildren = false;
			mailBtn.buttonMode    = true;
			addChild(mailBtn);
			
			mailBtn.addChild(new MailClass() as Bitmap);
			mailBtn.graphics.beginFill(0xff0000,0.);
			mailBtn.graphics.drawRect(-2,-2,mailBtn.width+4,mailBtn.height+4);
			mailBtn.graphics.endFill();
			mailBtn.alpha = 0.5;
			mailBtn.x = topmenu.Menu.x + topmenu.Menu.width + 40;
			mailBtn.y = 40;
			mailBtn.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			mailBtn.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			mailBtn.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			mailBtn.removeEventListener(MouseEvent.MOUSE_OUT,onOut);
			mailBtn.removeEventListener(MouseEvent.CLICK,onClick);
			PageFactory.gotoPage('/mail');
			
			topmenu.Menu.MouseActive(lastId,'');
		}
		
		protected function onOut(e:MouseEvent):void
		{
			TweenLite.to(mailBtn,0.5,{alpha:0.5,ease:Expo.easeOut});
		}
		
		protected function onOver(e:MouseEvent):void
		{
			TweenLite.to(mailBtn,0.5,{alpha:1,ease:Expo.easeOut});
		}
		
		protected function onMenuItemClicked(e:AccordionMenuEvent):void
		{
			if(!mailBtn.hasEventListener(MouseEvent.CLICK))
			{
				TweenLite.to(mailBtn,0.5,{alpha:0.5,ease:Expo.easeOut});
				mailBtn.addEventListener(MouseEvent.MOUSE_OUT,onOut);
				mailBtn.addEventListener(MouseEvent.CLICK,onClick);
			}
			lastClicked = e.name;
			lastId = e.mainId;
			PageFactory.gotoPage("/"+e.name);
		}
		
		override protected function on_Resize(e:Event):void
		{
			bg ? bg.updateSize(W,H) : void;
			sound ? alignRight(sound,-20,35) : void;
		}
		
		
	}
}