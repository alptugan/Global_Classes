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
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.LineStyle;

	import flash.geom.Rectangle;

	/**
	 *  Class to create elliptical shapes
	 * 
	 * @author Max Kugland
	 */
	public class EllipseShape extends RectShape {
		/**
		 * @param lineStyle the <code>LineStyle</code> of the <code>EllipseShape</code>
		 * @param fillStyle the <code>FillStyle</code> of the <code>EllipseShape</code>
		 * @param rect the rect defining the edges of the <code>EllipseShape</code>
		 * 
		 * @see org.splink.library.draw.style.LineStyle
		 * @see org.splink.library.draw.style.FillStyle
		 */
		public function EllipseShape(rect : Rectangle, fillStyle : FillStyle = null, lineStyle : LineStyle = null) {
			super(rect, fillStyle, lineStyle);
			super.prepare();
		}

		protected override function draw() : void {
			graphics.drawEllipse(_rect.x, _rect.y, _rect.width, _rect.height);
		}
	}
}
