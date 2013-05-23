package src.com.innova.katlardaireler 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class ScrollingLayer extends Sprite
	{
		protected var scrollingBitmap:BitmapData;
		protected var _parallaxAmount:Number = 1;
		public var canvas:Graphics;
		protected var matrix:Matrix;
		
		
		public function ScrollingLayer() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event):void 
		{
			matrix = this.transform.matrix.clone();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			canvas = this.graphics;
			drawCanvas();
			
		}
		
		public function move(dx:Number, dy:Number):void {
			matrix.translate(dx, dy);
			drawCanvas();
		}
		
		public function get dy():Number { return matrix.ty; }
		
		public function set dy(value:Number):void 
		{
			matrix.ty = value * _parallaxAmount;
			drawCanvas();
		}
		
		public function drawCanvas(xVal:int=0,yVal:int=0):void
		{
			canvas.clear();
			canvas.beginBitmapFill(scrollingBitmap, matrix, true, false);
			canvas.drawRect(xVal,yVal,797, scrollingBitmap.height);			
		}
		
		public function get dx():Number { return matrix.tx; }
		
		public function set dx(value:Number):void 
		{
			matrix.tx = value * _parallaxAmount;
			drawCanvas();
		}
		
		public function get parallaxAmount():Number { return _parallaxAmount; }
		
		public function set parallaxAmount(value:Number):void 
		{
			_parallaxAmount = value;
		}
		
	}

}