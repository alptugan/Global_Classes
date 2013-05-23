package src.com.azinliklarittifaki
{
	import com.alptugan.display.Gradient_Bg;
	import com.alptugan.globals.Root;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class NoisyBackground extends Root
	{

		private var bg:Gradient_Bg;

		private var bgdata:BitmapData;

		private var bgn:Bitmap;
		
		public function NoisyBackground()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE ,onAdded);
			
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE ,onAdded);
			
			bg = new Gradient_Bg(stage.stageWidth, stage.stageHeight, [0x191919,0x313131],GradientType.LINEAR);
			
			addChildAt(bg,0);
			
			bgdata = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xffffff);
			bgdata.draw(bg);
			
			bgn = new Bitmap(bgdata);
			
			bgdata.noise(20,10,30,1,true);
			addChildAt(bgn,1);
			bgn.alpha = 0.5;
		}
		
		public function updateSize(w:int,h:int):void
		{
			bgdata.dispose();
			bg.updateSize(w,h);
			
			bgdata = new BitmapData(w, h, true, 0xffffff);
			bgdata.draw(bg);
			
			
			bgn = new Bitmap(bgdata);
			
			
			bgdata.noise(20,10,30,1,true);
			
			addChildAt(bgn,1);
			bgn.alpha = 0.5;
		}
	}
}