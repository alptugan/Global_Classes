//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.text
{
	import com.alptugan.text.FontLoader.FontClass;
	import com.alptugan.utils.BitmapUtil;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;

	
	public class ATextFieldCss extends Sprite
	{
		public var Y : int,
			X : int,
			xFac : Number,
			yFac : Number;
		
		public var css : String;
		
		public var rect : Shape,
			rectCl : uint;
		
		public function get textH() : Number
		{
			return BitmapUtil.getTextFieldBounds( tf ).height;
		}
		
		public function get textW() : Number
		{
			return BitmapUtil.getTextFieldBounds( tf ).width;
		}
		
		public var tf : TextField;
		
		public var tf_format : TextFormat;
		
		private var fontName : String;
		
		private var fontSize : Number;
		
		private var lineH : Number;
		
		private var mouse : String;
		
		private var selectable : Boolean;
		
		private var spacing : int;
		
		private var style : String;
		
		private var txt : String;
		
		private var txtColor : uint;
		
		private var txtColor2 : uint;
		
		//public var holder       : Sprite;  
		
		private var w : int;
		
		public function ATextFieldCss( _txt : String = "",
			_style : String = "w",
			_css : String = "content",
			/*_fontSize:Number = 41.5,
			  _txtColor:uint = 0xb89378,
			  _lineH:Number  = 0,
			  _spacing:Number= 0.5,*/
			_w : Number = 100,
			_selectable : Boolean = true,
			_rectCl : uint = 0x000000 )
		{
			
			addEventListener( Event.ADDED_TO_STAGE,init );
			addEventListener( Event.REMOVED_FROM_STAGE,remove );
			txt = _txt;
			
			txtColor2 = _rectCl;
			style = _style;
			rectCl = _rectCl;
			w = _w;
			/*
			fontSize              = _fontSize;
			txtColor              = _txtColor;
			lineH                 = _lineH;
			fontName              = _fontName;
			spacing               = _spacing;*/
			//txtAlign            = _txtAlign;
			//url                 = _url;
			css = _css;
			selectable = _selectable;
		}
		
		public function SetText( _str : String ) : void
		{
			tf.htmlText = "<span class='" + css + "'>" + _str + "</span>";
			//_str;
		}
		
		public function updateW( _n : Number ) : void
		{
			rect.width = textW + 20;
			tf.x = ( rect.width / 2 - textW / 2 );
			tf.y = ( rect.height / 2 - textH / 2 );
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,init );
			//	holder           = new Sprite();
			tf = new TextField();
			tf_format = new TextFormat();
			tf.embedFonts = true;
			//addChild(holder);
			
			tf.antiAliasType = AntiAliasType.ADVANCED;
			//  tf.gridFitType   = GridFitType.PIXEL;
			// tf.sharpness=fldSharpness;
			
			switch ( style )
			{
				
				case "w":
					tf.width = w;
					tf.selectable = selectable;
					tf.multiline = true;
					tf.wordWrap = true;
					tf.condenseWhite = true;
					//tf_format.leading       = lineH;
					tf_format.letterSpacing = spacing;
					//tf_format.size          = fontSize;		
					tf_format.color = txtColor;
					//tf_format.font          = fontName;	
					break;
				
				case "uw":
					tf.selectable = selectable;
					tf.multiline = false;
					tf.condenseWhite = true;
					tf.wordWrap = false;
					//tf_format.size          = fontSize;		
					//tf_format.color         = txtColor;
					//tf_format.font          = fontName;	
					break;
				
				case "h":
					
					tf.selectable = false;
					tf.multiline = false;
					tf.condenseWhite = true;
					
					//	tf_format.letterSpacing = 0.8;
					tf_format.size = fontSize;
					tf_format.color = txtColor2;
					//tf_format.font          = fontName;	
					break;
				
			}
			
			tf.autoSize = TextFieldAutoSize.LEFT;
			/**/
			tf.defaultTextFormat = tf_format;
			tf.styleSheet = FontClass.cssStyleSheet;
			
			tf.htmlText = "<span class='" + css + "'>" + txt + "</span>";
			
			addChild( tf ); //holder.addChild(tf);
			
			xFac = -BitmapUtil.getTextFieldBounds( tf ).x;
			yFac = -BitmapUtil.getTextFieldBounds( tf ).y;
			tf.x = xFac;
			tf.y = yFac;
			
			if ( !selectable )
			{
				//older.mouseChildren = false;
				//holder.buttonMode    = true;
				this.mouseChildren = false;
				this.buttonMode = true;
			}
			
			if ( style == "h" )
			{
				rect = new Shape();
				rect.graphics.beginFill( 0xe6e6e6 );
				rect.graphics.drawRect( 0,0,80,tf.textHeight + 8 );
				rect.graphics.endFill();
				rect.alpha = 1;
				tf.x = (( 80 - tf.textWidth ) >> 1 ) - 3;
				tf.y = (( rect.height - tf.height ) >> 1 ) - 1;
				addChildAt( rect,0 );
			}
			
			if ( style == 'hh' )
			{
				rect = new Shape();
				rect.graphics.beginFill( rectCl );
				rect.graphics.drawRect( 0,0,textW + 8,textH + 6 );
				rect.graphics.endFill();
				rect.alpha = 1;
				addChildAt( rect,0 );
				
				tf.x = ( rect.width - textW ) * 0.5 + xFac;
				tf.y = ( rect.height - textH ) * 0.5 + yFac;
			}
		}
		
		private function remove( e : Event ) : void
		{
			
			removeChild( tf ); //holder.removeChild(tf);
			//removeChild(holder);
			removeEventListener( Event.REMOVED_FROM_STAGE,remove );
			if ( style == "h" || style == "hh" )
			{
				removeChild( rect );
			}
		}
	} //class ends
} //package ends
