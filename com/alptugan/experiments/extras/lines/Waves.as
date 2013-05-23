package com.alptugan.experiments.extras.lines
{
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import org.casalib.display.CasaMovieClip;
	import org.casalib.display.CasaSprite;
	
	public class Waves extends CasaSprite
	{
		
		private var _startPt:Point;
		private var _endPt:Point
		private var _halfPt:Point;
		private const _numLines:uint = 3
		private const _maxSpeed:Number = 6;
		private const _minSpeed:Number = 3;
		private const _radiusMin:Number = 20;
		private const _radiusMax:Number = 60;
		private const _glow:GlowFilter = new GlowFilter(0x000000, 0.7, 5, 5, 5, 1000);
		
		private var _angleLeft:Array = new Array();
		private var _angleRight:Array = new Array();
		private var _radiLeft:Array = new Array();
		private var _radiRight:Array = new Array();
		
		
		public function Waves()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_startPt  = new Point( -100, stage.stageHeight / 2);
			
			_endPt    = new Point(stage.stageWidth + 100, stage.stageHeight / 2);
			
			_halfPt   = new Point(Math.abs(_startPt.x - _endPt.x) / 2, Math.abs(_startPt.y - _endPt.y) / 2);
			
			for (var i:int = 0; i < _numLines; i++)
			{
				_radiLeft.push(_radiusMin + ((_radiusMax - _radiusMin) / (_numLines -1) ) * i);
				_radiRight.push(_radiusMax - ((_radiusMax - _radiusMin) / (_numLines -1) ) * i);
				_angleLeft.push((360 / _numLines) * i);
				_angleRight.push(360 - (360 / _numLines) * i);
			}            
			for (var j:int = 0; j < _numLines; j++)
			{
				var line:CasaMovieClip = new CasaMovieClip();
				line.angle1 = _angleLeft[j];
				line.radius1 = _radiLeft[j];
				line.speed1 = Math.random() * (_maxSpeed - _minSpeed) + _minSpeed;
				line.angle2 = _angleRight[j];
				line.radius2 = _radiRight[j];
				line.speed2 = Math.random() * (_maxSpeed - _minSpeed) + _minSpeed;
				line.colour = 0x33FFFF;
				line.addEventListener(Event.ENTER_FRAME, onLoop);
				line.filters = [_glow]
				addChild(line);        
			}
			
		}
		
		private function onLoop (evt:Event):void
		{
			var line:CasaMovieClip = CasaMovieClip(evt.target);        
			line.tx1 = _startPt.x + _halfPt.x / 2 + Math.cos(line.angle1 * (Math.PI / 180)) * line.radius1;
			line.ty1 = _startPt.y + Math.sin(line.angle1 * (Math.PI / 180)) * line.radius1;
			line.tx2 = _endPt.x - _halfPt.x / 2 + Math.cos(line.angle2 * (Math.PI / 180)) * line.radius2;
			line.ty2 = _endPt.y + Math.sin(line.angle2 * (Math.PI / 180)) * line.radius2;
			line.midx = (line.tx2 + line.tx1) / 2;
			line.midy = (line.ty2 + line.ty1) / 2;
			line.angle1 += line.speed1;
			line.angle2 += line.speed2;
			
			line.graphics.clear();
			line.graphics.lineStyle(3, line.colour);
			line.graphics.moveTo(_startPt.x, _startPt.y);
			line.graphics.curveTo(line.tx1, line.ty1, line.midx, line.midy);
			line.graphics.curveTo(line.tx2, line.ty2, _endPt.x, _endPt.y);
		}
	}
}