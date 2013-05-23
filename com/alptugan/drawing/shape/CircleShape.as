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
package com.alptugan.drawing.shape{
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.LineStyle;
	
	import flash.geom.Point;



	/**
	 * Class to create circular shapes
	 * 
	 * @author Max Kugland
	 */
	public class CircleShape extends BasicShape {
		private var _point : Point;
		private var _radius : Number;

		/**
		 * @param lineStyle the <code>LineStyle</code> of the <code>CircleShape</code>
		 * @param fillStyle the <code>FillStyle</code> of the <code>CircleShape</code>
		 * @param point the midpoint of the <code>CircleShape</code>
		 * @param radius the radius of the <code>CircleShape</code>
		 * 
		 * @see org.splink.library.draw.style.LineStyle
		 * @see org.splink.library.draw.style.FillStyle
		 */
		public function CircleShape(point : Point, radius : Number, fillStyle : FillStyle = null, lineStyle : LineStyle = null) {
			super(fillStyle, lineStyle);
			_point = point;
			_radius = radius;
			
			super.prepare();
		}

		/**
		 * @param point the midpoint of the <code>CircleShape</code>
		 */
		public function setPoint(point : Point) : void {
			_point = point;
		}

		/**
		 * @param radius the radius of the <code>CircleShape</code>
		 */
		public function setRadius(radius : Number) : void {
			_radius = radius;
		}

		protected override function draw() : void {
			graphics.drawCircle(_point.x, _point.y, _radius);
		}
	}
}