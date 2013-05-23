package com.alptugan.experiments.extras.tentacles
{
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	public class TentacleItem extends CasaSprite
	{
		public var view:CasaSprite;
		public var ww:int;
		public var wh:int;
		public var FT:Number;
		
		private var lineAddSprite:CasaSprite;
		private var line:Vector.<CasaShape>;
		private var topLine:CasaShape;
		private var lineNum:int = 200;
		private var linelength:Number = 20;
		private var frame:int = 0;
		private var code:Number = 1;
		private var codeChangeFrameRate:int = 60;
		private var rotateRate:Number = 10;
		
		public function TentacleItem(topSprite:CasaSprite)
		{
			FT = 1/60;
			view = topSprite;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			lineAddSprite = new CasaSprite();
			
			var coler:uint = 0xFFFFFFFF*Math.random();
			
			line = new Vector.<CasaShape>(lineNum,true);	
			
			for(var i:int=0; i<lineNum; i++)
			{
				line[i] = new CasaShape();
				var g:Graphics = line[i].graphics;
				g.lineStyle(10,coler,1-(lineNum-i+1)/lineNum,false,LineScaleMode.NONE);
				g.moveTo(0,0);
				g.lineTo(0,-1);
				lineAddSprite.addChild(line[i]);
				line[i].scaleY = linelength;
			}
			view.addChild(lineAddSprite);
			topLine = line[lineNum-1];
		}
		
		private function initLine(length:Number, num:int):void
		{
			var coler:uint = 0xFFFFFFFF*Math.random();	
			for(var i:int=0; i<line.length; i++)
			{
				lineAddSprite.removeChild(line[i]);
			}
			line = new Vector.<CasaShape>(lineNum,true);
			for(i=0; i<lineNum; i++)
			{
				line[i] = new CasaShape();
				var g:Graphics = line[i].graphics;
				g.lineStyle(5,coler,1-(lineNum-i+1)/lineNum,false,LineScaleMode.NONE);
				g.moveTo(0,0);
				g.lineTo(0,-1);
				lineAddSprite.addChild(line[i]);
				line[i].scaleY = linelength;
			}	
			topLine = line[lineNum-1];
		}
		
		public function onEnterFrame():void
		{
			for(var i:int=0; i<lineNum-1; i++)
			{
				line[i].x=line[i+1].x;
				line[i].y=line[i+1].y;
				line[i].rotation=line[i+1].rotation;
			}
			var rad:Number = topLine.rotation/180*Math.PI;
			topLine.x += Math.sin(rad)*linelength;
			topLine.y += -Math.cos(rad)*linelength;
			
			
			frame++;
			if(Math.abs(topLine.rotation) < 90)
			{
				if(frame>codeChangeFrameRate*Math.random())
				{
					frame = 0;
					code = -topLine.rotation/Math.abs(topLine.rotation);
				}
			}else{
				code*=1.1;
			}
			topLine.rotation +=code*rotateRate*Math.random();
			
			lineAddSprite.y -= (topLine.y+lineAddSprite.y)*FT*8;
			lineAddSprite.x -= (topLine.x+lineAddSprite.x)*FT*2;
		}
		
		public function resize(w:Number, h:Number):void
		{
			view.x = w/2;
			view.y = 0;
			ww = w;
			wh = h;
		}
	}
}