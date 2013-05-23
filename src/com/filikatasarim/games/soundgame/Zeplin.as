package src.com.filikatasarim.games.soundgame
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	public class Zeplin extends CasaSprite
	{
		private var zeplin : Bitmap;
		private var zeplinSticker:Bitmap;
		
		//Dalga sıklığı
		private var freq:Number = 1;
		
		// Dalga büyüklüğü
		private var amp:Number = 5;
		
		private var yaxis : Number = 0;
		
		private var ropeLen : Number = 200;
		
		private var switchVal:Boolean = false;
		
		public function Zeplin()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onStartAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		public function onRemoved(e:Event=null):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.removeEventListeners();
			graphics.clear();
			
			while(this.numChildren > 0)
				removeChildAt(0);
			
			null;
			
			trace("Zeplin is removed from stage\n-----------------------------------------------------");
		}
		
		protected function onStartAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onStartAddedToStage);
			trace("Zeplin added to stage\n-----------------------------------------------------");
			
			zeplin = Assets.getTexture("zeplinClass");
			this.addChild(zeplin);
			
			zeplinSticker = Assets.getTexture("zeplinStickerClass");
			this.addChild(zeplinSticker);
			zeplinSticker.x = zeplin.x + zeplin.width + ropeLen;
			
			/*graphics.lineStyle(1,0,0.5);
			graphics.moveTo(zeplin.width-1,zeplin.height*0.5);
			graphics.lineTo(zeplinSticker.x,zeplinSticker.height*0.5);*/
			
			yaxis = zeplin.height*0.5;
			//initialize();
		}
		
		private function getRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}    
		
		public function update():void
		{
			var currentDate:Date = new Date();
			//0002 is speed -25 vertical limit
			zeplin.y = - (Math.cos(currentDate.getTime() * 0.002) * 3);
			zeplinSticker.y = - (Math.cos(currentDate.getTime() * 0.002) * 3);
			
			graphics.clear();
			graphics.lineStyle(2, 0xff0000, 0.4);
			graphics.moveTo(zeplin.width-1,yaxis);
			
			for(var i:int=0; i<=ropeLen; i++){
				var ang:Number = 2 * Math.PI * freq * i/ropeLen;
				graphics.lineTo(zeplin.width-1 + i, yaxis - amp*Math.sin(ang));
				
			}
			
			if(!switchVal)
			{
				amp = amp - 0.1;
				if(amp < -5)
				{
					switchVal = true;
					amp = -5;
				}
			}else{
				amp = amp + 0.1;
				if(amp > 5)
				{
					switchVal = false;
					amp = 5;
				}
			}
		}
		
		
	}
}