/*
 * Copyright 2008 Max Kugland
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package  com.alptugan.drawing.shape{
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.LineStyle;

	/**
	 * A class to create polygonal shapes.
	 * 
	 * @author Max Kugland
	 */
	public class PolygonShape extends BasicShape {
		private var _pointAr : Array;

		/**
		 * @param lineStyle the <code>LineStyle</code>
		 * @param fillStyle the <code>FillStyle</code>
		 * @param pointAr an array containing <code>Point</code> objects
		 * 
		 * @see org.splink.library.draw.style.LineStyle
		 * @see org.splink.library.draw.style.FillStyle
		 */
		public function PolygonShape(pointAr : Array, fillStyle : FillStyle = null, lineStyle : LineStyle = null) {
			super(fillStyle, lineStyle);
			_pointAr = pointAr;
			
			super.prepare();
		}

		/**
		 * @param pointAr an array containing <code>Point</code> objects
		 */
		public function setPointArray(pointAr : Array) : void {
			_pointAr = pointAr;
		}

		/**
		 * Adds a new <code>Point</code> object to pointAr
		 * 
		 * @param point the new <code>Point</code>
		 */
		public function addPoint(point : Point) : void {
			_pointAr.push(point);
		}

		override protected function draw() : void {
			if(_pointAr.length < 1) return;
			var point : Point;
			point = _pointAr[0];
			graphics.moveTo(point.x, point.y);
			for (var i : int = 1;i < _pointAr.length; i++) {
				point = _pointAr[i];
				if(!(point is Point)) throw new IllegalOperationError("within pointAr must be Point objects!"); 
				graphics.lineTo(point.x, point.y);
			}
			point = _pointAr[0];
			graphics.lineTo(point.x, point.y);
		}
	}
}
