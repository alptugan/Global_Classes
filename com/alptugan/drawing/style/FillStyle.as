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
package com.alptugan.drawing.style
{
	/**
	 * <code>FillStyle</code> describes the style used for a shapes filling.
	 * 
	 * @see org.splink.library.draw.shape.BasicShape
	 * @author Max Kugland
	 */
	public class FillStyle 
	{
		private var _fillColor:uint;
		private var _fillAlpha:Number;		
		private var _gradientData:GradientData;
		
		/**
		 * @param color the color of the shape filling
		 * @param alpha the alpha of the shape filling
		 * @param gradientData an object holding data used to create gradient fillings
		 * 
		 * @see GradientData
		 */
		public function FillStyle(color:uint = 0, alpha:Number = 1, gradientData:GradientData = null)
		{
			_fillColor = color;
			_fillAlpha = alpha;
			_gradientData = gradientData;
		}		
		
		/**
		 * @return the color of the filling
		 */
		public function getFillColor():uint
		{
			return _fillColor;
		}
		
		/**
		 * @param the color of the filling
		 */
		public function setFillColor(fillColor:uint):void
		{
			_fillColor = fillColor;
		}		
		
		/**
		 * @return the alpha value of the filling
		 */
		public function getFillAlpha():Number
		{
			return _fillAlpha;
		}
		
		/**
		 * @param the alpha value of the filling
		 */
		public function setFillAlpha(fillAlpha:Number):void
		{
			_fillAlpha = fillAlpha;
		}		
		
		/**
		 * @param gradientData an object holding data used to create gradient fillings
		 */
		public function getGradientData():GradientData
		{
			return _gradientData;
		}		
		
		/**
		 * @return gradientData an object holding data used to create gradient fillings
		 */
		public function setGradientData(gradientData:GradientData):void
		{
			_gradientData = gradientData;
		}
	}
}
