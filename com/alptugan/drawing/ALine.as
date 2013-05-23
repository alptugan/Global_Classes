package com.alptugan.drawing
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ALine extends Shape
	{
		private var
					_coord     : Point,
					_color     : uint,
					_thickness : int;
					
		public function ALine(coord:Point,thickness:int = 1, color:uint=0xffffff)
		{
			this._color     = color;
			this._coord     = coord;
			this._thickness = thickness;
			
			this.graphics.lineStyle(this._thickness,this._color,1,true);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(this._coord.x,this._coord.y);
		}
		
		public function update(coord:Point,thickness:int, color:uint):void
		{
			this.graphics.clear();
			this.graphics.lineStyle(thickness,color,1,true);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(coord.x,coord.y);
		}
		
		//========================================================================================================
		// GETTERS & SETTERS
		//========================================================================================================
		public function get coord():Point
		{
			return _coord;
		}

		public function set coord(value:Point):void
		{
			_coord = value;
		}

		public function get thickness():int
		{
			return _thickness;
		}

		public function set thickness(value:int):void
		{
			_thickness = value;
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		

	}
}