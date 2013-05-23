package src.com.innova.button
{
	import com.alptugan.drawing.Arc;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	
	import src.com.innova.Globals;
	
	public class DurdurBtnClass extends CasaSprite
	{
		
		[Embed(source="assets/images/video/durdur.png")]
		protected var DurdurClass:Class;
		
		private var dur:CasaSprite;
		private var tf:ATextSingleLine;
		private var arcHolder:CasaSprite;
		private var arc1:CasaShape;
		private var arc2:CasaShape;
		
		private var _intervalId:int;
		public var _interval:Interval;
		public var bolSwitch:Boolean;

		
		public function DurdurBtnClass()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			if(_interval)
				_interval.destroy();
			removeAllChildrenAndDestroy(true,true);
		}		
		
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			dur = new CasaSprite();
			addChild(dur);
			
			dur.addChild(new DurdurClass() as Bitmap);
			
			
			// Text
			tf = new ATextSingleLine("DURDUR",Globals.css[9].name,Globals.css[9].color,Globals.css[9].size);
			addChild(tf);
			tf.x = 63;
			tf.y = 30;
			
			// Arc
			arcHolder = new CasaSprite();
			addChild(arcHolder);
			
			arc1 = new CasaShape();
			arcHolder.addChild(arc1);
			arc1.graphics.clear();
			arc1.graphics.lineStyle(1.5, Globals.css[9].color, 1, false, LineScaleMode.NORMAL, 
				CapsStyle.NONE);
			Arc.draw(arc1, 18, 36, 16, 170,95);
			arc1.x = -arc1.width-4;
			arc1.y = -arc1.height*0.5-3;
			
			arc2 = new CasaShape();
			arcHolder.addChild(arc2);
			arc2.scaleX = -1;
			arc2.graphics.clear();
			arc2.graphics.lineStyle(1.5, Globals.css[9].color, 1, false, LineScaleMode.NORMAL, 
				CapsStyle.NONE);
			Arc.draw(arc2, -22, 36, 16, 170,95);
			arc2.x = -arc2.width-4;
			arc2.y = -arc2.height*0.5-3;
			
			arcHolder.x = arcHolder.width*0.5 + 10;
			arcHolder.y = arcHolder.height *0.5 + 16;
			this._interval = Interval.setInterval(this._repeatingFunction, 10);
			this._interval.repeatCount = 1;
			switchOnOff();
			
			
		}
		
		private function _repeatingFunction():void
		{
			arcHolder.rotation = arcHolder.rotation+1;
			
			
			this._interval.reset();
			this._interval.start();
		}
		
		public function switchOnOff(color:uint=0x7ac4e0):void
		{
			if(!bolSwitch)
			{
				TweenMax.to(dur,0.5,{tint:0x7ac4e0,ease:Expo.easeOut});
				
				this._interval.start();
				_intervalId = 0;
				bolSwitch = true;
			}else{
				TweenMax.to(dur,0.5,{tint:null,ease:Expo.easeOut});
				
				bolSwitch = false;
				this._interval.stop();
				//ExternalInterface.call('onClickPanaromaMove',val,0);
			}
			
		}
	}
}