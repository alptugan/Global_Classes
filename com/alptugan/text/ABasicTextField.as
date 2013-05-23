//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.text
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ABasicTextField extends Sprite
	{
		public var Ft : TextFormat = new TextFormat();
		
		public var Tf : TextField;
		
		public var bg : uint;
		
		public var bgFill : Boolean;
		
		public var c : uint;
		
		public function ABasicTextField( c : uint = 0x000000,bg : uint = 0x000000,bgFill : Boolean = true )
		{
			this.c = c;
			this.bg = bg;
			this.bgFill = bgFill;
			addEventListener( Event.ADDED_TO_STAGE,init );
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,init );
			Tf = new TextField();
			
			Tf.selectable = false;
			Tf.multiline = false;
			Tf.wordWrap = false;
			Tf.autoSize = TextFieldAutoSize.LEFT;
			Tf.background = bgFill;
			Tf.backgroundColor = bg;
			Ft.color = c;
			Ft.font = "Arial";
			Ft.size = 9;
			Ft.letterSpacing = 1;
			Tf.defaultTextFormat = Ft;
			
			Tf.htmlText = "Dummy Text";
			addChild( Tf );
		}
	}
}
