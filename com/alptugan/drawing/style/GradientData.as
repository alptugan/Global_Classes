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
	import flash.geom.Matrix;	
	/**
	 * <code>GradientData</code> holds information which is used to create gradient fillings.
	 * 
	 * Sample usage:
	 * var m:Matrix = new Matrix();
	 * m.createGradientBox(100, 100, ((270 / 180) * Math.PI), 0, 0);
	 * var gd:GradientData = new GradientData(GradientType.LINEAR, [0x000000,0xffffff], [100,0], [0,255], m);
	 * 
	 * @author max kugland
	 */
	public class GradientData 
	{
		private var _type:String; 
		private var _colors:Array;
		private var _alphas:Array;
		private var _ratios:Array;
		private var _matrix:Matrix;
		private var _spreadMethod:String;
		private var _interpolationMethod:String;
		private var _focalPointRatio:Number;
		
		
		/**
		 * @param type there are two valid types to use: GradientType.LINEAR or GradientType.RADIAL. 
		 * @param colors an array of RGB hexadecimal color values to be used in the gradient
		 * @param alphas an array of alpha values for the corresponding colors in the colors array
		 * @param ratios an array of color distribution ratios; valid values are 0 to 255
		 * @param matrix a transformation matrix as defined by the flash.geom.Matrix class
		 * @param spreadMethod specifies which spread method to use, either: 
		 * 		SpreadMethod.PAD, 
		 * 		SpreadMethod.REFLECT
		 * 		SpreadMethod.REPEAT
		 * @param interpolationMethod specifies which value to use, either:
		 * 		 InterpolationMethod.linearRGB
		 * 		 InterpolationMethod.RGB 
		 * @param focalPointRatio a number that controls the location of the focal point of the gradient
		 * 
		 * @see flash.display.Graphics
		 */
		public function GradientData(type:String,colors:Array,alphas:Array,ratios:Array,matrix:Matrix = null,spreadMethod:String = "pad",interpolationMethod:String = "rgb",focalPointRatio:Number = 0) 
		{
			_type = type;
			_colors = colors;
			_alphas = alphas;
			_ratios = ratios;
			_matrix = matrix;
			_spreadMethod = spreadMethod;
			_interpolationMethod = interpolationMethod;
			_focalPointRatio = focalPointRatio;
		}
		
		/**
		 * @return one of the two valid types: GradientType.LINEAR or GradientType.RADIAL. 
		 */
		public function getType():String 
		{ 
			return _type; 
		}
		
		/**
		 * @param type there are two valid types to use: GradientType.LINEAR or GradientType.RADIAL. 
		 */
		public function setType(value:String):void 
		{ 
			_type = value; 
		}
		
		/**
		 * @return an array of RGB hexadecimal color values to be used in the gradient
		 */
		public function getColors():Array 
		{ 
			return _colors; 
		}

		/**
		 * @param colors an array of RGB hexadecimal color values to be used in the gradient
		 */
		public function setColors(colors:Array):void 
		{ 
			_colors = colors; 
		}
		
		/**
		 * @return an array of alpha values for the corresponding colors in the colors array
		 */
		public function getAlphas():Array 
		{ 
			return _alphas; 
		}
		
		/**
		 * @param alphas an array of alpha values for the corresponding colors in the colors array
		 */
		public function setAlphas(alphas:Array):void 
		{ 
			_alphas = alphas; 
		}
		
		/**
		 * @return an array of color distribution ratios; valid values of elements within the array
		 * are between 0 to 255
		 */
		public function getRatios():Array 
		{ 
			return _ratios; 
		}
		
		/**
		 * @param ratios an array of color distribution ratios; valid values are 0 to 255
		 */
		public function setRatios(ratios:Array):void 
		{ 
			_ratios = ratios; 
		}
		
		/**
		 * @return the gradients transformation matrix as defined by the flash.geom.Matrix class
		 */
		public function getMatrix():Matrix 
		{ 
			return _matrix; 
		}
		
		/**
		 * @param matrix a transformation matrix as defined by the flash.geom.Matrix class
		 */
		public function setMatrix(matrix:Matrix):void 
		{ 
			_matrix = matrix; 
		}
		
		/**
		 * @return the gradients spreadMethod, either: 
		 * 		SpreadMethod.PAD, 
		 * 		SpreadMethod.REFLECT
		 * 		SpreadMethod.REPEAT
		 */
		public function getSpreadMethod():String 
		{ 
			return _spreadMethod; 
		}
		
		/**
		 * @param spreadMethod specifies which spread method to use, either: 
		 * 		SpreadMethod.PAD, 
		 * 		SpreadMethod.REFLECT
		 * 		SpreadMethod.REPEAT
		 */
		public function setSpreadMethod(spreadMethod:String):void 
		{ 
			_spreadMethod = spreadMethod; 
		}
		
		/**
		 * @return the gradients interpolationMethod, either:
		 * 		 InterpolationMethod.linearRGB
		 * 		 InterpolationMethod.RGB 
		 */
		public function getInterpolationMethod():String 
		{ 
			return _interpolationMethod; 
		}
		
		/**
		 * @param interpolationMethod specifies which value to use, either:
		 * 		 InterpolationMethod.linearRGB
		 * 		 InterpolationMethod.RGB 
		 */
		public function setInterpolationMethod(interpolationMethod:String):void 
		{ 
			_interpolationMethod = interpolationMethod; 
		}
		
		/**
		 * @return a number that controls the location of the focal point of the gradient
		 */
		public function getFocalPointRatio():Number 
		{ 
			return _focalPointRatio; 
		}
		
		/**
		 * @param focalPointRatio a number that controls the location of the focal point of the gradient
		 */
		public function setFocalPointRatio(focalPointRatio:Number):void 
		{ 
			_focalPointRatio = focalPointRatio; 
		}
	}
}