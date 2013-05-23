package src.com.innova
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.globals.Root;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	public class BackGround extends CasaSprite
	{
		private var source:String;

		private var XMLLoader:BulkLoader;

		private var bg:Bitmap;
		
		public function BackGround()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function load(source:String):void
		{
			this.source = source;
			
			
			if(!XMLLoader)
				XMLLoader  = new BulkLoader("backgrounloader");
			
			XMLLoader.add(source);
			XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			XMLLoader.start();
		}
		
		
		private function onAllLoaded(e:Event):void
		{
			XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
			
			if(this.numChildren > 0)
			{
				TweenMax.to(this.getChildAt(0),0.5,{alpha:0,ease:Strong.easeOut,onComplete:function():void{
					removeChildAt(0);
					
				}});
				
				bg = XMLLoader.getContent(source,true);
				addChild(bg);
				TweenMax.from(bg,0.5,{alpha:0,ease:Expo.easeOut});
				dispatchEvent(new Event("bgLoaded"));
			}else{
				bg = XMLLoader.getContent(source,true);
				addChild(bg);
				
				XMLLoader.remove("backgrounloader");
				
				TweenMax.from(bg,0.5,{alpha:0,ease:Strong.easeOut,onComplete:function():void{
					dispatchEvent(new Event("bgLoaded"));
					
				}});
				
			}
			
			
			
			
		}
		
	}
}