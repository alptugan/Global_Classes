//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.text.TextArea
{
	import com.greensock.TweenNano;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.alptugan.display.CreateMask;
	import com.alptugan.primitives.Triangle;
	import com.alptugan.template.SimpleScrollButtons;
	import com.alptugan.text.ATextFieldCss;
	
	public class ABasicTextArea extends Sprite
	{
		public var Str : String;
		
		public var Text : ATextFieldCss;
		
		public var TextMask : Shape;
		
		public var TfHeight : int;
		
		public var TfWidth : int;
		
		public function ABasicTextArea( _Str : String,_TfWidth : int = 560,_TfHeight : int = 350 )
		{
			Str = _Str;
			TfHeight = _TfHeight;
			TfWidth = _TfWidth;
			addEventListener( Event.ADDED_TO_STAGE,init );
			addEventListener( Event.REMOVED_FROM_STAGE,onRemove );
		}
		
		public function updateSize( W : int,H : int ) : void
		{
			TextMask.height = H;
			if ( Text.height > TextMask.height && TextMask.height < TfHeight )
			{
				
			}
		}
		
		private function init( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,init );
			TextMask = CreateMask.Create( 0,0,TfWidth,TfHeight );
			
			addChild( TextMask );
			Text = new ATextFieldCss( Str,"w","content",TfWidth );
			Text.alpha = 0;
			Text.x = TextMask.x;
			Text.y = TextMask.y;
			Text.mask = TextMask;
			addChild( Text );
			
			TweenNano.to( Text,0.5,{ alpha: 1,onComplete: function() : void
			{
				if ( Text.height > TextMask.height )
				{
					TextMask.height = TfHeight - 50;
					var DownBtn : Triangle             = new Triangle( "down",21,16,0x666666 );
					DownBtn.alpha = 0;
					DownBtn.buttonMode = true;
					addChild( DownBtn );
					
					//if Up and Down Buttons are added, then move down the mask and TextField
					
					DownBtn.x = TextMask.x + TextMask.width - DownBtn.width - 5;
					DownBtn.y = TextMask.y + TextMask.height + 5;
					
					TweenNano.to( DownBtn,0.5,{ alpha: 1 });
					
					var UpBtn : Triangle               = new Triangle( "down",21,16,0x666666 );
					UpBtn.alpha = 0;
					UpBtn.scaleY = -1;
					UpBtn.buttonMode = true;
					addChild( UpBtn );
					UpBtn.x = DownBtn.x;
					UpBtn.y = -UpBtn.height + 5;
					
					TweenNano.to( UpBtn,0.5,{ alpha: 1 });
					
					var scroller : SimpleScrollButtons = new SimpleScrollButtons();
					addChild( scroller );
					scroller.initUpDown( Text,TextMask,UpBtn,DownBtn,2 );
				}
			}});
		}
		
		private function onRemove( e : Event ) : void
		{
			removeChild( Text );
			TextMask.graphics.clear();
			removeChild( TextMask );
			TextMask = null;
			Text = null;
			Str = null;
			removeEventListener( Event.REMOVED_FROM_STAGE,onRemove );
		}
	}
}
