package com.alptugan.primitives
{
	import com.alptugan.template.AButtonHandlers;
	import com.alptugan.utils.Bounds;
	import com.greensock.TweenLite;
	import com.greensock.plugins.BevelFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import org.casalib.display.CasaSprite;
	
	public class AGradientCircle extends CasaSprite
	{
		public var 
					r           : int,
					colors      : Array,
					interactive : Boolean,
					type        : String,
					id          : int;
					
		public var handler:AButtonHandlers = new AButtonHandlers();
					
		public function AGradientCircle(r:int,colors:Array, interactive:Boolean=false,type:String=GradientType.LINEAR)
		{
			this.r           = r*0.5;
			this.colors      = colors;
			this.interactive = interactive;
			this.type        = type;
			TweenPlugin.activate([BevelFilterPlugin]); 
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(e:Event):void
		{
			//colors.length = 0;
			this.graphics.clear();		
			this.removeEventListeners();
			this.colors  = null;
			//handler.disposeHandlers();
		}
		
		protected function onAdded(e:Event):void
		{
			
			
			drawCricle();
			
			if (interactive) 
			{
				this.buttonMode = true;
				//handler.scaleFac = 1.3;
				//handler.initHandlers(this);
				//add Button Event Handlers
				initHandlers();
			}
		}
		
		public function initHandlers():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
		}
		
		protected function onOut(e:MouseEvent):void
		{
			//TweenLite.to(btn, 1, {glowFilter:{color:_onColor, blurX:0, blurY:0, strength:0, alpha:1}});
			TweenLite.to(this, 0.2, {bevelFilter:{blurX:0, blurY:0, distance:0, angle:90, strength:0},scaleX:1,scaleY:1});
		}
		
		protected function onOver(e:MouseEvent):void
		{
			//TweenLite.to(btn, 0.2, {glowFilter:{color:_onColor, blurX:2, blurY:2, strength:1, alpha:1}});
			TweenLite.to(this, 0.2, {bevelFilter:{blurX:4, blurY:4, distance:1, angle:90, strength:1},scaleX:1.3,scaleY:1.3});
		}
		
		private function drawCricle():void
		{
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(r*2,r*2,0,-r,-r);
			this.graphics.beginGradientFill(type, colors, [1,1], [50,255], mtx);
			this.graphics.drawCircle(0,0,r);
			
		}
		
	}
}