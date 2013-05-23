package src.com.innova.panaroma
{
	import com.alptugan.drawing.Arc;
	import com.alptugan.text.ATextSingleLine;
	import com.bigspaceship.tween.easing.Expo;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	
	import src.com.innova.Globals;
	
	
	public class DonButtonClass extends CasaSprite
	{
		[Embed(source="assets/images/panaroma/don.png")]
		protected var DonClass:Class;
		
		private var Don:CasaSprite;
		private const txt:String = "DÖN";
		private var tf:ATextSingleLine;
		private var arc1:CasaShape;
		private var arc2:CasaShape;
		private var arcHolder:CasaSprite;
		
		public var _interval:Interval;
		private var _intervalId:int;
		public var bolSwitch:Boolean;
		private var val:Number = 0;
		
		public function DonButtonClass()
		{
			this.mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE,onremoved);
		}
		
		protected function onremoved(e:Event):void
		{
			if(_interval)
			_interval.destroy();
			removeAllChildrenAndDestroy(true,true);
		}		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			Don = new CasaSprite();
			addChild(Don);
			
			Don.addChild(new DonClass() as Bitmap);
			
			// Text
			tf = new ATextSingleLine(txt,Globals.css[9].name,Globals.css[9].color,Globals.css[9].size);
			addChild(tf);
			tf.x = 55;
			tf.y = 23;
			
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
			
			//ExternalInterface.addCallback('getPan',getPan);
			
			
		}
		
		private function getPan(pal:int):void
		{
			val = pal;
			ExternalInterface.call('Debugger','Geloloy'+pal);
		}
		
		private function _repeatingFunction():void
		{

				_intervalId++;
				arcHolder.rotation = arcHolder.rotation+1;
			
				if (ExternalInterface.available) 
				{
					val = val + 0.1;
					//ExternalInterface.call('onClickPanaromaMove',val,0);
				}
				
			this._interval.reset();
			this._interval.start();
		}
		
		public function switchOnOff(color:uint=0x7ac4e0):void
		{
			if(!bolSwitch)
			{
				TweenMax.to(Don,0.5,{tint:color,ease:Expo.easeOut});
				
				this._interval.start();
				_intervalId = 0;
				bolSwitch = true;
			}else{
				TweenMax.to(Don,0.5,{tint:null,ease:Expo.easeOut});
				
				bolSwitch = false;
				this._interval.stop();
				//ExternalInterface.call('onClickPanaromaMove',val,0);
			}
			
		}
	}
}