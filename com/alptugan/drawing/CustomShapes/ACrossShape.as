package com.alptugan.drawing.CustomShapes
{
	import com.alptugan.globals.Root;
	import com.alptugan.utils.Colors;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	public class ACrossShape extends Root
	{
		private var 
					size:int,
					color:uint,
					onColor:uint,
					thickness:int;
		
		private var shp:CasaShape;	
		
		public function ACrossShape(color:uint = 0xffffff,onColor:uint= 0xff6347, size:int = 15, thickness:int = 1)
		{
			super();
			this.color     = color;
			this.onColor   = onColor;
			this.size      = size;
			this.thickness = thickness;
			
			this.mouseChildren = false;
			this.buttonMode    = true;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			
			shp = new CasaShape();
			shp.graphics.beginFill(0xff0000,0);
			shp.graphics.drawRect(0,0,size,size);
			shp.graphics.beginFill(this.color);
			
			for (var i:int = 0; i < this.size/thickness; i++)
			{
				shp.graphics.drawRect(i*this.thickness,i*this.thickness,this.thickness,this.thickness);
				shp.graphics.drawRect((this.size-thickness) - i*this.thickness,i*this.thickness,this.thickness,this.thickness);
			}
			shp.graphics.drawRect((this.size-thickness)*0.5,(this.size-1)*0.5,this.thickness,this.thickness);
			shp.graphics.endFill();
			
			addChild(shp);
			
			/*this.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);*/
		}
		
		protected function onOver(event:MouseEvent):void
		{
			TweenLite.to(shp,0.3,{tint:this.onColor});
		}
		
		protected function onOut(event:MouseEvent):void
		{
			TweenLite.to(shp,0.3,{tint:null});
		}
		
	}
}