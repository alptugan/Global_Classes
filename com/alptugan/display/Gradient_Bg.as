//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.display
{
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class Gradient_Bg extends Shape
	{
		
		public static function set width( w : int ) : void
		{
			width = w;
		}
		
		public static function set height( h : int ) : void
		{
			height = h;
		}
		
		private var Colors : Array;
		
		private var Type : String;
		
		private var backgroundGradient : Sprite;
		
		private var boxHeight : Number;
		
		private var boxWidth : Number;
		
		private var square : Shape;

		private var alphas:Array;

		private var ratios:Array;

		private var spreadMethod:String;

		private var interp:String;

		private var focalPtRatio:Number;

		private var matrix:Matrix;

		private var boxRotation:Number;

		private var tx:Number;

		private var ty:Number;
		
		public function Gradient_Bg( _boxWidth : Number,
			_boxHeight : Number,
			_Colors : Array,
			_Type : String = GradientType.RADIAL )
		{
			Type = _Type;
			boxWidth = _boxWidth;
			boxHeight = _boxHeight;
			Colors = _Colors;
			addEventListener( Event.ADDED_TO_STAGE,init );
		}
		
		public function updateSize( _sw : int,_sh : int ) : void
		{
			/*square.width = _sw;
			square.height = _sh;*/
			draw(_sw,_sh);
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,init );
			
			alphas        = [ 1,1 ];
			ratios        = [ 0,255 ];
			spreadMethod = SpreadMethod.PAD;
			interp       = InterpolationMethod.RGB;
			focalPtRatio = 0;
			
			matrix       = new Matrix();
			
			boxRotation  = Math.PI / 2; // 90˚
			tx           = 0;
			ty           = 0;
			
			draw(boxWidth,boxHeight);
		}
		
		private function draw(_boxWidth:int,_boxHeight:int):void
		{
			matrix.createGradientBox( _boxWidth,_boxHeight,boxRotation,tx,ty );
			/*
			square = new Shape;
			square.graphics.beginGradientFill( Type,Colors,alphas,ratios,matrix,spreadMethod,interp,focalPtRatio );
			square.graphics.drawRect( 0,0,boxWidth,boxHeight );
			addChild( square );*/
			this.graphics.clear();
			this.graphics.beginGradientFill( Type,Colors,alphas,ratios,matrix,spreadMethod,interp,focalPtRatio );
			this.graphics.drawRect( 0,0,_boxWidth,_boxHeight );
		}
	}
}
