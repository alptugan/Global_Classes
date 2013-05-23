package src.com.filikatasarim
{
	import com.alptugan.globals.Root;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.casalib.display.CasaSprite;
	
	public class Counter extends Root
	{
		private var tx:ATextSingleLine;
		public var message:ATextSingleLine;
		public var holder :CasaSprite;
		private var color:uint = 0xffffff;
		
		private var timer : Timer ;
		private var _num:int;

		private var c:Shape;
		private var _findCol:String;
		
		public function Counter(findCol:String)
		{
			this._findCol = findCol;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		public function get findCol():String
		{
			return _findCol;
		}

		public function set findCol(value:String):void
		{
			_findCol = value;
		}

		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			// Message Text
			message = new ATextSingleLine("READY?", "roman",color,110);
			addChild(message);
			
			ShowCounter();
		}
		
		/**
		 * Shows the counter
		 * When it reaches to 0
		 * Capturing mode starts 
		 * 
		 */
		public function ShowCounter():void
		{
			holder = new CasaSprite();
			addChild(holder);
			holder.alpha = 0;
			
			c = new Shape();
			c.graphics.lineStyle(1,color);
			c.graphics.drawCircle(365*0.5,365*0.5,365*0.5);
			holder.addChild(c);
					
			tx = new ATextSingleLine("5","roman",color,65);
			tx.scaleX = tx.scaleY = 4;
			holder.addChild(tx);
			
			c.y = message.height + 30;
			c.x = (message.width - c.width - 20) >>1;
			tx.x = ( c.width - tx.width + 50 + c.x) >> 1;
			tx.y = message.height + 190 + ( c.height - tx.height  + 110) >> 1;
		}
		
		
		/**
		 * 
		 * Starts with the specified time value
		 * and counts it to 0
		 * 
		 * @param num : how many seconds in 
		 * order to catch the color
		 * 
		 */
		public function start( num:int ):void
		{
			_num   = num;
			
			TweenLite.to(holder,1,{alpha:1,onComplete:function():void{
				timer  = new Timer(1599, _num); // 1 second;
				timer.addEventListener(TimerEvent.TIMER, runOnce);
				timer.start();
			
			}});
			
			
		}
		
		
		protected function runOnce(e:TimerEvent):void
		{
			
			tx.SetText(String(_num-timer.currentCount));
			
			// After 2 seconds set the mission color
			if(timer.currentCount == 2)
			{
				message.SetText(_findCol);
			}
			
			
			// When it ends, remove the counter window
			// Keep message window.
			if(timer.currentCount == _num)
			{
				timer.removeEventListener(TimerEvent.TIMER, runOnce);
				timer.stop();
				timer.reset();
				TweenLite.to(holder,0.5,{alpha:0,onComplete:function():void{ holder.destroy(); }});
				dispatchEvent(new Event("timeIsUp"));
				
				//TweenLite.to(message,0.5,{alpha:0,y:"100",delay:0.4});
			}
			
		}
	}
}