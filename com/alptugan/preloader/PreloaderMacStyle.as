package com.alptugan.preloader
{
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.casalib.display.CasaSprite;
	
	public class PreloaderMacStyle extends CasaSprite
	{
		[Embed(source="com/alptugan/assets/font/uni05_54.ttf", embedAsCFF="false", fontName="loader", mimeType="application/x-font", unicodeRange = "U+0025,U+0030-U+0039")]
		public var Loader:Class;
		
		private var timer:Timer = new Timer(65);
		private var slices:int;
		private var radius:int;
		private var holder:CasaSprite;
		//Info Section
		private var info:Boolean;
		private var txtPercent:ATextSingleLine;
		private var w:int;
		private var h:int;
		private var color:uint;
		
		public function PreloaderMacStyle(slices:int = 12, radius:int = 6,info:Boolean = false,_w:int = 2, _h:int = 6,_color:uint=0x666666)
		{
			this.slices = slices;
			this.radius = radius;
			this.info   = info;
			this.w		= _w;
			this.h 		= _h;
			this.color	= _color;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			draw();
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start();
			
			
		}
		
		private function onTimer(event:TimerEvent):void
		{
			holder.rotation = (holder.rotation + (360 / slices)) % 360;
		}
		
		
		private function draw():void
		{
			var i:int = slices;
			var degrees:int = 360 / slices;
			
			holder= new CasaSprite();
			addChild(holder);
			
			while (i--)
			{
				var slice:Shape = getSlice();
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
				var radianAngle:Number = (degrees * i) * Math.PI / 180;
				slice.rotation = -degrees * i;
				slice.x = Math.sin(radianAngle) * radius;
				slice.y = Math.cos(radianAngle) * radius;
				holder.addChild(slice);
			}
			
			if (this.info) 
			{
				txtPercent = new ATextSingleLine('% 100','loader',color,8,false,false,true,'left');
				addChild(txtPercent);
				txtPercent.y = holder.height ;
				
				txtPercent.x = (((holder.width - txtPercent.tf.textWidth) *0.5) - txtPercent.tf.textWidth*0.5 + 2);
				
			}
		}
		private function getSlice():Shape
		{
			var slice:Shape = new Shape();
			slice.graphics.beginFill(color);
			slice.graphics.drawRoundRect(-1, 0, w, h, 12, 12);
			slice.graphics.endFill();
			return slice;
		}
		
		public function onProgress(bytesLoaded:Number,bytesTotal:Number):void
		{
			/* Here we use some local variables to make better-reading code */
			
			var loadedBytes:int = Math.round(bytesLoaded / 1024);
			var totalBytes:int = Math.round(bytesTotal / 1024);
			var percent:int = (loadedBytes / totalBytes) * 100;
			
			
			txtPercent.SetText("% "+percent);
			txtPercent.x = (((holder.width - txtPercent.tf.textWidth) *0.5) - txtPercent.tf.textWidth*0.5 + 2);
			/* Sets the loading data to the textfield */
			
			//dataTextField.text = String(loadedBytes + " of " + totalBytes + "KB Loaded\n" + percent + "% Complete");
		}
	}
}