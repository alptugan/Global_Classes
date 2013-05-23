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
	 * <code>LineStyle</code> describes the style used for a shapes border.
	 * 
	 * @see org.splink.library.draw.shape.BasicShape
	 * @author Max Kugland
	 */
	public class LineStyle 
	{
		private var _lineThickness:Number;
		private var _lineColor:uint;
		private var _lineAlpha:Number;
		private var _linePixelHinting:Boolean;
		private var _lineScaleMode:String;
		private var _lineJoints:String;
		private var _lineMiterLimit:Number;
		private var _caps:String;

		/**
		 * @param thickness indicates the thickness of the line in points
		 * @param color a hexadecimal color value indicating the color of a line
		 * @param alpha a number that indicates the alpha value of the color of the line
		 * @param pixelHinting specifies whether to hint strokes to full pixels
		 * @param scaleMode valid values are:
		 *	 	LineScaleMode.NORMAL Always scale the line thickness when the object is scaled (default). 
		 *		LineScaleMode.NONE Never scale the line thickness. 
		 *		LineScaleMode.VERTICAL Do not scale the line thickness if the object is scaled vertically
		 *		LineScaleMode.HORIZONTAL Do not scale the line thickness if the object is scaled horizontally 
		 * @param caps valid values are:
		 * 		CapsStyle.NONE
		 *		CapsStyle.ROUND
		 *		CapsStyle.SQUARE
		 * @param joints valid values are:
		 * 		JointStyle.BEVEL
		 *		JointStyle.MITER
		 *		JointStyle.ROUND
		 * @param miterLimit a number between 0 and 255 that indicates the limit at which a miter is 
		 * cut off.
		 * 
		 * @see flash.display.Graphics
		 */		
		public function LineStyle(thickness:Number = 0, color:uint = 0, alpha:Number = 0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = "round",joints:String = "round", miterLimit:Number = 3) 
		{
			_lineThickness = thickness;
			_lineColor = color;
			_lineAlpha = alpha;
			_linePixelHinting = pixelHinting;
			_lineScaleMode = scaleMode;
			_caps = caps;
			_lineJoints = joints;
			_lineMiterLimit = miterLimit;
		}		

		/**
		 * @return the lineThickness indicating the thickness of the line in points
		 */
		public function getLineThickness():Number
		{
			return _lineThickness;
		}

		/**
		 * @param lineThickness indicates the thickness of the line in points
		 */
		public function setLineThickness(lineThickness:Number):void
		{
			_lineThickness = lineThickness;
		}		

		/**
		 * @return a hexadecimal color value indicating the color of a line
		 */
		public function getLineColor():uint
		{
			return _lineColor;
		}

		/**
		 * @param lineColor a hexadecimal color value indicating the color of a line
		 */
		public function setLineColor(lineColor:uint):void
		{
			_lineColor = lineColor;
		}		

		/**
		 * @return a number that indicates the alpha value of the color of the line
		 */
		public function getLineAlpha():Number
		{
			return _lineAlpha;
		}

		/**
		 * @param lineAlpha a number that indicates the alpha value of the color of the line
		 */
		public function setLineAlpha(lineAlpha:Number):void
		{
			_lineAlpha = lineAlpha;
		}		

		/**
		 * @return a Boolean value which specifies whether to hint strokes to full pixels or not
		 */
		public function getLinePixelHinting():Boolean
		{
			return _linePixelHinting;
		}

		/**
		 * @param linePixelHinting specifies whether to hint strokes to full pixels or not
		 */
		public function setLinePixelHinting(linePixelHinting:Boolean):void
		{
			_linePixelHinting = linePixelHinting;
		}		

		/**
		 * @return the lineScaleMode. valid values are: 
		 *	 	LineScaleMode.NORMAL Always scale the line thickness when the object is scaled (default). 
		 *		LineScaleMode.NONE Never scale the line thickness. 
		 *		LineScaleMode.VERTICAL Do not scale the line thickness if the object is scaled vertically
		 *		LineScaleMode.HORIZONTAL Do not scale the line thickness if the object is scaled horizontally 
		 */
		public function getLineScaleMode():String
		{
			return _lineScaleMode;
		}

		/**
		 * @param lineScaleMode valid values are:
		 *	 	LineScaleMode.NORMAL Always scale the line thickness when the object is scaled (default). 
		 *		LineScaleMode.NONE Never scale the line thickness. 
		 *		LineScaleMode.VERTICAL Do not scale the line thickness if the object is scaled vertically
		 *		LineScaleMode.HORIZONTAL Do not scale the line thickness if the object is scaled horizontally 
		 */
		public function setLineScaleMode(lineScaleMode:String):void
		{
			_lineScaleMode = lineScaleMode;
		}

		/**
		 * @return caps valid values are:
		 * 		CapsStyle.NONE
		 *		CapsStyle.ROUND
		 *		CapsStyle.SQUARE
		 */
		public function getCaps():String
		{
			return _caps;
		}

		/**
		 * @param caps valid values are:
		 * 		CapsStyle.NONE
		 *		CapsStyle.ROUND
		 *		CapsStyle.SQUARE
		 */
		public function setCaps(caps:String):void
		{
			_caps = caps;
		}

		/**
		 * @return lineJoints valid values are:
		 * 		JointStyle.BEVEL
		 *		JointStyle.MITER
		 *		JointStyle.ROUND
		 */
		public function getLineJoints():String
		{
			return _lineJoints;
		}

		/**
		 * @param lineJoints valid values are:
		 * 		JointStyle.BEVEL
		 *		JointStyle.MITER
		 *		JointStyle.ROUND
		 */
		public function setLineJoints(lineJoints:String):void
		{
			_lineJoints = lineJoints;
		}		

		/**
		 * @return a number between 0 and 255 that indicates the limit at which a miter is cut off
		 */
		public function getLineMiterLimit():Number
		{
			return _lineMiterLimit;
		}

		/**
		 * @param lineMiterLimit a number between 0 and 255 that indicates the limit at which a miter is 
		 * cut off
		 */
		public function setLineMiterLimit(lineMiterLimit:Number):void
		{
			_lineMiterLimit = lineMiterLimit;
		}
	}
}
