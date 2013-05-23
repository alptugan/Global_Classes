package src.net.jwproduction
{
	import com.alptugan.text.AText;
	import com.alptugan.ui.AScrollBarJPG;
	import com.alptugan.utils.Bounds;
	import com.alptugan.utils.Colors;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import org.casalib.display.CasaBitmap;
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.DataLoad;
	import org.casalib.load.GroupLoad;
	import org.casalib.load.ImageLoad;
	
	public class ATextWithImage extends CasaSprite
	{
		private var 
					source : String,
					w      : int,
					h      : int;
					
		public var xml       : XML,
					dataLoad  : DataLoad,
					groupLoad : GroupLoad;
					
		private var img    : CasaBitmap;
		private var title  : AText;
		private var note   : AText;
		private var mail   : AText;
		private var content: AText;
		private var imgLoader:ImageLoad;
		private var scroller:AScrollBarJPG;
		
		public function ATextWithImage(source:String,w:int,h:int)
		{
			this.source = source;
			this.w      = w;
			this.h      = h;
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			this.removeEventListeners();
			
			// LOAD XML
			loadXML();
			
		}
		
		private function loadXML():void
		{
			dataLoad = new DataLoad(source);
			dataLoad.addEventListener(LoadEvent.COMPLETE, XMLonComplete);
			dataLoad.start();
		}
		
		protected function XMLonComplete(e:LoadEvent):void
		{
			dataLoad.destroy();
			dataLoad.removeEventListeners();
			// set xml variable
			xml = dataLoad.dataAsXml;
			
			dispatchEvent(new Event("xmlLoaded"));
			
			startLoading();
		}
		
		/**
		 *
		 * START TO LOAD IMAGES 
		 * 
		 */
		private function startLoading():void
		{
			//GROUP LOADER FOR ALL OF THE IMAGES
			this.groupLoad = new GroupLoad();
			
			// HOLDER SPRITE FOR IMAGES
		/*	imgHolder      = new CasaSprite();
			addChild(imgHolder);*/
			
		
			imgLoader   = new ImageLoad(String(xml.img[0]));

			// SET ALPHAS TO 0
			imgLoader.loader.alpha = 0;
			
			// ADD IMAGES TO DISPLAY LIST
			addChild(imgLoader.loader);
			
			// ADD THEM TO THE GROUPLOAD
			groupLoad.addLoad(imgLoader);
			
			this.groupLoad.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this.groupLoad.addEventListener(LoadEvent.PROGRESS, this.onProgress);
			this.groupLoad.addEventListener(LoadEvent.COMPLETE, this.onComplete);
			this.groupLoad.start();
		}
		
		protected function onError(e:IOErrorEvent):void {
			trace("There was an error");
			this.groupLoad.removeLoad(this.groupLoad.erroredLoads[0]);
		}
		
		protected function onProgress(e:LoadEvent):void {
			trace("Group is " + e.progress.percentage + "% loaded at " + e.Bps + "Bps.");
		}
		
		protected function onComplete(e:LoadEvent):void 
		{	
			// WHEN GROUP LOADING IS FINISHED DESTROY GROUP LOADER
			groupLoad.destroyProcesses(true);
			groupLoad.destroyLoads();
			groupLoad.destroy();
			
			// AFTER ALL OF THE IMAGES LOADED AND ADDED TO STAGE SHOW THE FIRST ONE
			TweenLite.to(imgLoader.loader,0.5,{alpha:1});
			
			title = new AText("helvetica-bold",String(xml.title[0]),w - 50,12,Colors.cJWOrange,true,"left");
			title.x = imgLoader.loader.width + 5;
			title.y = 10;
			addChild(title);			
			
			
			note  = new AText("roman",String(xml.note[0]),w - 50,10,Colors.cWhite,true);
			note.y = title.y + title.height -10;
			note.x = title.x;
			addChild(note);
			
			mail   = new AText("roman",String(xml.mail[0]),w - 50,10,Colors.cJWOrange,true);
			mail.y = note.y + note.height-8;
			mail.x = note.x;
			addChild(mail);
			
			content   = new AText("roman",String(xml.content[0]), w, 12, Colors.cWhite,true,"left",2);
			content.y = imgLoader.loader.height + 8;
			addChild(content);
			
			scroller = new AScrollBarJPG(content,w,h,2,0x8d8d8d,Colors.cGrayI,[3],false,true);
			addChild(scroller);
			
			dispatchEvent(new Event("contentLoaded"));
		}

		
	}
}