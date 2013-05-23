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
package com.alptugan.drawing.shape {
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.drawing.style.GradientData;
	import com.alptugan.drawing.style.LineStyle;
	
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;

	

	/**
	 * Base class for all kinds of shapes.
	 * 
	 * @see CircleShape
	 * @see EllipseShape
	 * @see PolygonShape
	 * @see RectShape
	 * @see RoundRectShape
	 * 
	 * @author Max Kugland
	 */
	public class BasicShape extends Shape {
		private var _lineStyle : LineStyle;
		private var _fillStyle : FillStyle;

		/**
		 * @param lineStyle the <code>LineStyle</code>
		 * @param fillStyle the <code>FillStyle</code>
		 * 
		 * @see org.splink.library.draw.style.LineStyle
		 * @see org.splink.library.draw.style.FillStyle
		 */
		public function BasicShape(fillStyle : FillStyle, lineStyle : LineStyle) {
			_lineStyle = lineStyle;
			_fillStyle = fillStyle;
		}

		/**
		 * Sets a new <code>LineStyle</code>
		 * 
		 * @param lineStyle the new <code>LineStyle</code>
		 * @see LineStyle
		 */
		public function setLineStyle(lineStyle : LineStyle) : void {
			_lineStyle = lineStyle;
			
			graphics.lineStyle(_lineStyle.getLineThickness(), _lineStyle.getLineColor(), _lineStyle.getLineAlpha(), _lineStyle.getLinePixelHinting(), _lineStyle.getLineScaleMode(), _lineStyle.getCaps(), _lineStyle.getLineJoints(), _lineStyle.getLineMiterLimit());
		}

		/**
		 * Sets a new <code>FillStyle</code>
		 * 
		 * @param fillStyle the new <code>FillStyle</code>
		 * @see FillStyle
		 */
		public function setFillStyle(fillStyle : FillStyle) : void {
			_fillStyle = fillStyle;
			
			if(_fillStyle.getGradientData() != null) {
				var gd : GradientData = _fillStyle.getGradientData();
				graphics.beginGradientFill(gd.getType(), gd.getColors(), gd.getAlphas(), gd.getRatios(), gd.getMatrix(), gd.getSpreadMethod(), gd.getInterpolationMethod(), gd.getFocalPointRatio());
			}
			else graphics.beginFill(_fillStyle.getFillColor(), _fillStyle.getFillAlpha());
		}

		/**
		 * Proteded, so subclasses are able to call it
		 */
		protected function prepare() : void {
			graphics.clear();
			if(_lineStyle) {
				setLineStyle(_lineStyle);
			}
			if(_fillStyle) {
				setFillStyle(_fillStyle);
			}
			draw();
			graphics.endFill();
		}

		/**
		 * Protected, so subclasses are able to override it with their implementation
		 */
		protected function draw() : void {
			throw new IllegalOperationError(BasicShape + " the draw method is abstract.");
		}

		/**
		 * If a new <code>LineStyle</code> or <code>FillStyle</code> has been set <code>redraw</code>
		 * invokes a redraw of the shape.
		 */
		public function redraw() : void {
			prepare();
		}
	}
}