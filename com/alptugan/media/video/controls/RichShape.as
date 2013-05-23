//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.media.video.controls
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class RichShape extends Sprite
	{
		private var _label : TextField  = new TextField();
		
		public function get label() : TextField
		{
			return _label;
		}
		
		private var format : TextFormat = new TextFormat();
		
		private var logoTextContainer : Sprite;
		
		public function RichShape( buttonActive : Boolean = false )
		{
			
			mouseChildren = false;
			
			if ( buttonActive )
			{
				buttonMode = true;
				addEventListener( MouseEvent.MOUSE_OVER,changeAlpha );
				addEventListener( MouseEvent.MOUSE_OUT,changeAlpha );
			}
		
		}
		
		public function drawRoundedRectangle( boxWidth : Number = 300,boxHeight : Number = 250,cornerRadius : uint = 4,borderColor : uint = 0x000000,beginColor : uint = 0x000000,endColor : uint = 0x000000,fillAlpha : Number = 1,borderSize : Number = 1 ) : void
		{
			
			// Creating Rounded Rectangle Manually
			// Using drawRoundRect() SUCKS -- Stroke Hinting is atrocious
			var colors : Array               = [ endColor,beginColor ];
			var fillType : String            = "radial"
			var alphas : Array               = [ 100,100 ];
			var ratios : Array               = [ 0,255 ];
			var spreadMethod : String        = "pad";
			var interpolationMethod : String = "RGB";
			var focalPointRatio : int        = 0;
			var matrix : Matrix              = new Matrix();
			
			// Start Drawing
			matrix.createGradientBox( boxWidth,boxHeight,(( -90 / 180 ) * Math.PI ),0,0 );
			graphics.lineStyle( borderSize,borderColor,1.0,true );
			graphics.beginGradientFill( fillType,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio );
			graphics.moveTo( cornerRadius,0 );
			graphics.lineTo( boxWidth - cornerRadius,0 );
			graphics.curveTo( boxWidth,0,boxWidth,cornerRadius );
			graphics.lineTo( boxWidth,cornerRadius );
			graphics.lineTo( boxWidth,boxHeight - cornerRadius );
			graphics.curveTo( boxWidth,boxHeight,boxWidth - cornerRadius,boxHeight );
			graphics.lineTo( boxWidth - cornerRadius,boxHeight );
			graphics.lineTo( cornerRadius,boxHeight );
			graphics.curveTo( 0,boxHeight,0,boxHeight - cornerRadius );
			graphics.lineTo( 0,boxHeight - cornerRadius );
			graphics.lineTo( 0,cornerRadius );
			graphics.curveTo( 0,0,cornerRadius,0 );
			graphics.lineTo( cornerRadius,0 );
			graphics.endFill();
			
			// Set 9 Slice Scaling
			if ( cornerRadius > 0 )
			{
				var sliceBound : Rectangle = new Rectangle( cornerRadius,cornerRadius,( boxWidth - ( cornerRadius * 2 )),( boxHeight - ( cornerRadius * 2 )))
				scale9Grid = sliceBound;
			}
		}
		
		public function drawRectangle( boxWidth : uint,boxHeight : uint,cornerRadius : uint = 0,beginColor : uint = 0x000000,endColor : uint = 0x000000,fillAlpha : Number = 1.0,borderSize : Number = 1 ) : void
		{
			with ( graphics )
			{
				beginFill( beginColor,fillAlpha );
				drawRect( 0,0,boxWidth,boxHeight );
				endFill();
			}
		}
		
		public function drawTriangle( w : uint = 20,h : uint = 20,beginColor : uint = 0x000000,borderColor : uint = 0x000000,borderSize : Number = 1,dir : String = 'left',name : String = 'play_button' ) : void
		{
			// Draw Triangle
			graphics.lineStyle( borderSize,borderColor,1.0,true );
			graphics.beginFill( beginColor,1 );
			graphics.moveTo( 0,h );
			graphics.lineTo( 0,0 );
			graphics.lineTo( w,( h / 2 ));
			graphics.lineTo( 0,h );
			graphics.endFill();
			
			switch ( dir )
			{
				case 'top':
					rotation = -90;
					break;
				case 'right':
					rotation = -180;
					break;
				case 'bottom':
					rotation = 90;
					break;
				default:
					break;
			}
		}
		
		public function drawPause( w : uint = 20,h : uint = 20,beginColor : uint = 0x000000,borderColor : uint = 0x000000,borderSize : Number = 0,name : String = 'pause_button' ) : void
		{
			this.name = "pause_button";
			var rectangle_one : RichShape = new RichShape();
			var rectangle_two : RichShape = new RichShape();
			var overlay : RichShape       = new RichShape();
			var holder : Sprite           = new Sprite();
			
			rectangle_one.drawRectangle((( w / 3 ) - 10 ),h / 2 + 5,0,beginColor,borderColor,1,borderSize );
			rectangle_two.drawRectangle((( w / 3 ) - 10 ),h / 2 + 5,0,beginColor,borderColor,1,borderSize );
			overlay.drawRoundedRectangle( w,h,4,0x202020,0x202020,0x000000 );
			addChild( overlay ).alpha = 1;
			addChild( holder );
			holder.addChild( rectangle_one ).x = 0;
			holder.addChild( rectangle_two ).x = rectangle_one.width + 8;
			
			rectangle_one.y = rectangle_two.y = ( h - rectangle_one.height ) >> 1;
			holder.x = ( w - holder.width ) >> 1;
		}
		
		public function setLabel( lbl : Object ) : void
		{
			
			format.font = "Arial";
			format.color = lbl.color;
			format.bold = true;
			format.size = lbl.size;
			
			_label = new TextField();
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.background = false;
			_label.border = false;
			_label.selectable = false;
			_label.alpha = lbl.alpha;
			_label.text = lbl.profile;
			_label.setTextFormat( format );
			addChild( _label );
			
			// set position
			//trace( '_label:',label.width,':',label.height );
			var y_padding : Number = 2;
			// y center
			setLabelPosition( 0,( height / 2 ) - ( label.height / 2 ) + y_padding );
		
		}
		
		public function setLabelPosition( x : int,y : int ) : void
		{
			label.x = x;
			label.y = y;
		}
		
		public function drawOutline( boxWidth : Number = 300,boxHeight : Number = 250,cornerRadius : uint = 4,borderColor : uint = 0x000000,lineAlpha : Number = 1,borderSize : Number = 1 ) : void
		{
			
			// Creating Rounded Rectangle Manually
			// Using drawRoundRect() SUCKS -- Stroke Hinting is atrocious
			
			// Start Drawing
			with ( graphics )
			{
				clear();
				lineStyle( borderSize,borderColor,lineAlpha,true );
				moveTo( cornerRadius,0 );
				lineTo( boxWidth - cornerRadius,0 );
				curveTo( boxWidth,0,boxWidth,cornerRadius );
				lineTo( boxWidth,cornerRadius );
				lineTo( boxWidth,boxHeight - cornerRadius );
				curveTo( boxWidth,boxHeight,boxWidth - cornerRadius,boxHeight );
				lineTo( boxWidth - cornerRadius,boxHeight );
				lineTo( cornerRadius,boxHeight );
				curveTo( 0,boxHeight,0,boxHeight - cornerRadius );
				lineTo( 0,boxHeight - cornerRadius );
				lineTo( 0,cornerRadius );
				curveTo( 0,0,cornerRadius,0 );
				lineTo( cornerRadius,0 );
			}
			
			// Set 9 Slice Scaling
			if ( cornerRadius > 0 )
			{
				var sliceBound : Rectangle = new Rectangle( cornerRadius,cornerRadius,( boxWidth - ( cornerRadius * 2 )),( boxHeight - ( cornerRadius * 2 )))
				scale9Grid = sliceBound;
			}
		}
		
		private function changeAlpha( event : Event ) : void
		{
			var eventType : String = event.type.toString();
			
			switch ( eventType.toLowerCase())
			{
				case 'mouseover':
					alpha = 0.9;
					break;
				default:
					this.name == "pause_button" ? alpha = 0 : alpha = 0.8;
					break;
			}
		}
	}
}