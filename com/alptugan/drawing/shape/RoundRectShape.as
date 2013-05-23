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
	import flash.geom.Rectangle;

	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.LineStyle;
	/**
	 *  A class to create rectangular shapes with rounded corners.
	 * 
	 * @author Max Kugland
	 */
	public class RoundRectShape extends BasicShape {
		private var _rect : Rectangle;
		private var _tl : Number;
		private var _tr : Number;
		private var _bl : Number;
		private var _br : Number;

		/**
		 * @param lineStyle the <code>LineStyle</code>
		 * @param fillStyle the <code>FillStyle</code>
		 * @param rect the <code>Rectangle</code> to draw
		 * @param tl the top left corner radius		 * @param tr the top right corner radius		 * @param bl the bottom left corner radius		 * @param br the bottom right corner radius
		 * 
		 * @see org.splink.library.draw.style.LineStyle
		 * @see org.splink.library.draw.style.FillStyle
		 */
		public function RoundRectShape(rect : Rectangle, fillStyle : FillStyle = null, lineStyle : LineStyle = null, tl : Number = 5, tr : Number = 5, bl : Number = 5, br : Number = 5) {
			super(fillStyle, lineStyle);
			_rect = rect;
			_tl = tl;
			_tr = tr;
			_bl = bl;
			_br = br;
			
			super.prepare();
		}

		/**
		 * @param rect the <code>Rectangle</code> to draw
		 */
		public function setRect(rect : Rectangle) : void {
			_rect = rect;
		}

		/**
		 * @param tl the top left corner radius
		 * @param tr the top right corner radius
		 * @param bl the bottom left corner radius
		 * @param br the bottom right corner radius
		 */
		public function setCornerRadius(tl : Number = 5, tr : Number = 5, bl : Number = 5, br : Number = 5) : void {
			_tl = tl;
			_tr = tr;
			_bl = bl;
			_br = br;
		}

		override protected function draw() : void {
			graphics.drawRoundRectComplex(_rect.x, _rect.y, _rect.width, _rect.height, _tl, _tr, _bl, _br);
		}
	}
}
