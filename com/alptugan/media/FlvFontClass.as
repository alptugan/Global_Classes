//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Media
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.StyleSheet;
	// import flash internal classes	
	import alptugan.Events.FontLoaderEvent;
	import alptugan.Text.ATextFieldCss;
	import alptugan.utils.FontLoader;
	import alptugan.utils.FontLoaderv2;
	
	public class FlvFontClass extends Sprite
	{
		// container for the css file
		public static var cssStyleSheet : StyleSheet;
		
		public static var _font : Font,InputFont : Font
		
		private var Source : String;
		
		private var _textField : ATextFieldCss;
		
		private var cssPath : String;
		
		private var fEvt : FontLoaderEvent;
		
		// fontloader
		private var fontLoader : FontLoaderv2;
		
		// urlloader for loading css and swf with fonts
		private var urlLoader : URLLoader;
		
		public function FlvFontClass( _Source : String = "asset/Font-Arial.swf",cssPath : String = "resources/style.css" )
		{
			addEvent( this,Event.ADDED_TO_STAGE,onAdded );
			Source = _Source;
			this.cssPath = cssPath;
		
		}
		
		public function addEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.addEventListener( type,listener,false,0,true );
		}
		
		public function removeEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.removeEventListener( type,listener );
		}
		
		private function onAdded( e : Event ) : void
		{
			if ( this.cssPath == "" )
			{
				loadFonts( new URLRequest( Source ));
			}
			else
			{
				// instantiate urlloader
				urlLoader = new URLLoader();
				
				// add event listeners for handling the progress and complete events
				addEvent( urlLoader,ProgressEvent.PROGRESS,onProgress );
				addEvent( urlLoader,Event.COMPLETE,onCSSComplete );
				
				// load css file
				
				urlLoader.load( new URLRequest( this.cssPath ));
			}
			removeEvent( this,Event.ADDED_TO_STAGE,onAdded );
		}
		
		private function onCSSComplete( e : Event ) : void
		{
			// instantiate new stylesheet
			cssStyleSheet = new StyleSheet();
			// parse data from url loader into stylesheet
			cssStyleSheet.parseCSS( urlLoader.data );
			
			// load fonts
			loadFonts( new URLRequest( Source ));
			removeEvent( urlLoader,ProgressEvent.PROGRESS,onProgress );
			removeEvent( urlLoader,Event.COMPLETE,onCSSComplete );
		
		}
		
		private function loadFonts( request : URLRequest ) : void
		{
			// instantiate fontloader
			fontLoader = new FontLoaderv2();
			
			addEvent( fontLoader,ProgressEvent.PROGRESS,onProgress );
			addEvent( fontLoader,Event.COMPLETE,fontsLoaded );
			// load fonts
			fontLoader.load( request );
		}
		
		/**  font event handler **/
		private function fontsLoaded( e : Event ) : void
		{
			// loop through each loaded font and
			// output its fontstyle/fontweight and
			// font-name
			
			var _arrFonts : Array = fontLoader.fonts;
			for each ( _font in _arrFonts )
			{
				var _isBold : Boolean   = false;
				var _isItalic : Boolean = false;
				switch ( _font.fontStyle )
				{
					case FontStyle.BOLD:
						_isBold = true;
						break;
					case FontStyle.BOLD_ITALIC:
						_isBold = true;
						_isItalic = true;
						break;
					case FontStyle.ITALIC:
						_isItalic = true;
						break;
					
					case FontStyle.REGULAR:
						
						break;
				}
			}
			InputFont = _arrFonts[ 0 ];
			fEvt = new FontLoaderEvent( "fontsLoaded" );
			fEvt.customMessage = "  Font Name:   " + _font.fontName + "\n" + " Font Style:   " + _font.fontStyle + "\n" + "  Font Type:   " + _font.fontType;
			dispatchEvent( fEvt );
			removeEvent( fontLoader,ProgressEvent.PROGRESS,onProgress );
			removeEvent( fontLoader,Event.COMPLETE,fontsLoaded );
			//displayCSSTextField();
		}
		
		private function displayCSSTextField() : void
		{
			_textField = new ATextFieldCss( "Çç öÖ .şŞ ğĞ ıI iİ","uw" );
			
			_textField.y = 300;
			// add textfield to display list
			addChild( _textField );
			
			_textField.rotationX = 5;
		}
		
		private function onProgress( e : ProgressEvent ) : void
		{
			// trace progress string
			//trace();
			var pcent : Number = ( e.bytesLoaded / e.bytesTotal ) * 100;
		}
	}
}
