package src.com.galea
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.casalib.display.CasaSprite;
	
	public class ShiningLogo extends MovieClip
	{
		
		private var sh:s;
		
		[Embed(source="assets/logo.png")]
		public var Logo:Class;
		
		private var logo:Bitmap;
		private var i:int =0;
		
		public function ShiningLogo()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			addEventListener(Event.ENTER_FRAME,onEnter);
			// Add bottom right logo
			logo = new Logo() as Bitmap;
			addChild(logo);
			
			sh = new s();
			addChild(sh);
			
			sh.x = 160;
			sh.y = 6;
			
			
			
			TweenLite.from(logo,1,{alpha:0,delay:1});
			
		}
		
		protected function onEnter(e:Event):void
		{
			if(sh.currentFrame > 24)
			{
				if(i > 16)
				{
					i = 0;
				}else{
					i++;
					
					switch(i)
					{
						case 1:
							sh.visible = true;
							sh.x = 160;
							sh.y = 6;
							break;
						
						case 2:
							sh.visible = true;
							sh.x = 367;
							sh.y = 113;
							break;
						
						case 3:
							sh.visible = true;
							sh.x = 290;
							sh.y = 59;
							break;
						
						case 4:
							sh.visible = true;
							sh.x = 27;
							sh.y = 39;
							break;
						
						case 5:
							sh.visible = true;
							sh.x = 24;
							sh.y = 139;
							break;
						
						case 6:
							sh.visible = true;
							sh.x = 127;
							sh.y = 57;
							break;
						
						case 7:
							sh.visible = true;
							sh.x = 227;
							sh.y = 151;
							break;
						
						case 8:
							sh.visible = true;
							sh.x = 226;
							sh.y = 117;
							break;
						
						case 9:
							sh.visible = true;
							sh.x = 364;
							sh.y = 57;
							break;
						default:
							sh.visible = false;
							break;
					}
				}
			}
		}
	}
}