package src.com.alptugan.textexplode
{

	
	import com.alptugan.globals.Root;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	
	public class LeftMenu extends Root
	{
		private var rect:Shape = new Shape();
		private var xml:String;
		private var _X:int;
		private var _Y:int;
		
	/*	[Embed(source="data/hilllogo.jpg")]
		public var Logo:Class;
		
		
		[Embed(source="data/no.png")]
		public var No:Class;
		
		[Embed(source="data/f.png")]
		public var Face:Class;
		
		[Embed(source="data/you.png")]
		public var You:Class;
		
		[Embed(source="data/twit.png")]
		public var Twit:Class;
		
		private var holder:CasaSprite;
		private var facebook:CasaMovieClip;
		private var youtube:CasaMovieClip;
		private var twitter:CasaMovieClip;
		private var noo:CasaMovieClip;*/

		private var t:AResizableTextArea;
		
		public function LeftMenu(xml:String)
		{
			this.xml = xml;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		public function set Y(value:int):void
		{
			_Y = value;
		}

		protected function onAdded(event:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			
			rect.graphics.beginFill(0xd0072e,0.8);//d0072e
			rect.graphics.drawRect(0,0,300,stage.stageHeight);
			rect.graphics.endFill();
			addChild(rect);
			

			t = new AResizableTextArea(xml,280, stage.stageHeight-10);
			t.x = 20;
			t.y = _Y;
			addChild(t);
			
			/*var l:Bitmap = new Logo();
	
			
			holder = new CasaSprite();
			addChild(holder);
			holder.addChild(l);
			
			
			holder.buttonMode = true;
			
			holder.y = stage.stageHeight -holder.height - 60;
			
			holder.alpha = 1;*/
			
			
			//holder.addEventListener(MouseEvent.CLICK, myBtnClicked);
/*			holder.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			holder.addEventListener(MouseEvent.MOUSE_OUT, onOut);*/
			
			
			/*var gap:int = 10;
			
			facebook = new CasaMovieClip();
			facebook.name = "f";
			holder.addChild(facebook);
			
			facebook.addChild(new Face() as Bitmap);
			facebook.y = l.height + 20;
			//facebook.alpha = 0.8;
			facebook.buttonMode = true;
			facebook.x = 70;
			
			twitter = new CasaMovieClip();
			twitter.name = "t";
			//twitter.alpha = 0.8;
			twitter.buttonMode = true;
			holder.addChild(twitter);
			twitter.addChild(new Twit() as Bitmap);
			
			twitter.y = facebook.y;
			twitter.x = facebook.x + facebook.width + gap;
			
			
			youtube = new CasaMovieClip();
			youtube.name = "y";
			//youtube.alpha = 0.8;
			youtube.buttonMode = true;
			holder.addChild(youtube);
			youtube.addChild(new You() as Bitmap);
			
			youtube.y = facebook.y;
			youtube.x = twitter.x + twitter.width + gap;
			
			
			noo = new CasaMovieClip();
			noo.name = "n";
			//noo.alpha = 0.8;
			noo.buttonMode = true;
			holder.addChild(noo);
			noo.addChild(new No() as Bitmap);
			
			noo.y = facebook.y;
			noo.x = youtube.x + youtube.width + gap;
			
			*/
			initResizeHandler();
		}
		
		protected function onOut(event:MouseEvent):void
		{
			if(event.target.name !="instance47")
			TweenLite.to(event.target,0.5,{alpha:0.8});
			
		}
		
		protected function onOver(e:MouseEvent):void
		{
			if(e.target.name !="instance47")
			TweenLite.to(e.target,0.5,{alpha:1});
		}		
		
		
		
		
		/*protected function myBtnClicked(e:MouseEvent):void {
			switch (e.target.name)
			{
				case "f":
					navigateToURL(new URLRequest(String(Globals.DataXML.face[0])));
					break;
				
				case "t":
					navigateToURL(new URLRequest(String(Globals.DataXML.twit[0])));
					break;
				
				case "y":
					navigateToURL(new URLRequest(String(Globals.DataXML.you[0])));
					break;
				
				case "n":
					navigateToURL(new URLRequest(String(Globals.DataXML.no[0])));
					break;
				
				default:
					navigateToURL(new URLRequest(String(Globals.DataXML.logolink[0])));
					break;
			}
			
		}
*/
		
		
		override public function on_Resize(e:Event):void
		{
			rect.height = stage.stageHeight;
/*			if(stage.stageHeight > 755)
				holder.y = stage.stageHeight -holder.height - 60;*/
			
		}
	}
}