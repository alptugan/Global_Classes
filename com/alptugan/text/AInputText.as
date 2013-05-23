package com.alptugan.text
{
	import com.alptugan.utils.BitmapUtil;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;
	
	public class AInputText extends CasaSprite
	{
		public var Tf : CasaTextField;
		
		public var TfHolder : CasaSprite,messageBr : CasaShape,messageBg : CasaShape;
		
		private var TfFmt : TextFormat;
		
		private var fInStr : String;
		
		private var w : int,
		h : int,
		StrokeColor : uint,
		focInColor  : uint,
		BgColor : uint,
		TxtColor : uint,
		FontSize : Number,
		TabInt : int,
		fontName:String;
		
		public function AInputText(fontName:String,StrokeColor : uint = 0xd6d6d6, focInColor:uint = 0x333333,w : Number = 200,h : Number = 16,TxtColor : uint = 0,FontSize : Number = 11,BgColor : uint = 0,fInStr : String = "",TabInt : int = 0 )
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE,init );
			addEventListener( Event.REMOVED_FROM_STAGE,remove );
			//txtAlign            = _txtAlign;
			//url                 = _url;
			this.w = w;
			this.h = h;
			this.StrokeColor = StrokeColor;
			this.BgColor = BgColor;
			this.TxtColor = TxtColor;
			this.FontSize = FontSize;
			this.fInStr = fInStr;
			this.TabInt = TabInt;
			this.fontName = fontName;
			this.focInColor = focInColor;
		}
		
		private function init( e : Event ) : void
		{
			
			removeEventListener( Event.ADDED_TO_STAGE,init );
			TfHolder = new CasaSprite();
			TfFmt = new TextFormat();
			
			if ( this.FontSize != 0 )
				TfFmt.size = FontSize;
			else
				TfFmt.size = 11;
			
			if ( this.TxtColor != 0 )
				TfFmt.color = 0x606060;
			
			TfFmt.font = fontName;
			TfFmt.letterSpacing = 1;
			
			Tf = new CasaTextField();
			Tf.type = TextFieldType.INPUT;
			Tf.width = this.w;
			Tf.height = this.h;
			Tf.tabIndex = this.TabInt;
			/*if(this.BgColor != 0)
			{
			Tf.background    = true;
			Tf.border        = false;
			Tf.backgroundColor = this.BgColor;
			}else{
			Tf.background    = false;
			Tf.border        = true;
			Tf.borderColor   = this.StrokeColor;
			}*/
			
			Tf.selectable = true;
			Tf.multiline = true;
			Tf.wordWrap = true;
			Tf.defaultTextFormat = TfFmt;
			Tf.antiAliasType = AntiAliasType.ADVANCED;
			Tf.embedFonts = true;
			
			//TfFmt.font = "Arial";
			
			if ( Tf.text == "" )
				Tf.text = this.fInStr;
			Tf.addEventListener( FocusEvent.FOCUS_IN,onFocus );
			Tf.addEventListener( FocusEvent.FOCUS_OUT,onFocusOut );
			
			messageBr = new CasaShape();
			messageBr.graphics.beginFill( this.StrokeColor );
			messageBr.graphics.drawRect( 0,0,this.w,this.h );
			messageBr.graphics.endFill();
			messageBr.name = "br";
			
			messageBg = new CasaShape();
			messageBg.graphics.beginFill( this.BgColor );
			messageBg.graphics.drawRect( 1,1,this.w - 2,this.h - 2 );
			messageBg.graphics.endFill();
			messageBg.name = "bg";
			
			TfHolder.addChild( messageBr );
			TfHolder.addChild( messageBg );
			TfHolder.addChild( Tf );
			addChild( TfHolder );
			
			Tf.x = -BitmapUtil.getTextFieldBounds( Tf ).x + 4;
			
			if(this.fInStr.toLowerCase() == "message" || this.fInStr.toLowerCase() == "mesaj")
				Tf.y = 4;
			else
				Tf.y = (TfHolder.height - BitmapUtil.getTextFieldBounds( Tf ).height) * 0.5 - BitmapUtil.getTextFieldBounds( Tf ).y;
			
			
		}
		
		private function onFocus( e : Event ) : void
		{
			TweenLite.from( messageBr,0.5,{ blurFilter: { blurX: 15,blurY: 15 }});
			TweenLite.to( messageBr,0.5,{ tint: focInColor });
			if ( Tf.text == "" || Tf.text == this.fInStr )
				Tf.text = "";
		}
		
		private function onFocusOut( e : Event ) : void
		{
			if ( Tf.text == "" )
				Tf.text = this.fInStr;
			TweenLite.to( messageBr,0.5,{ tint: this.StrokeColor });
		}
		
		private function remove( e : Event ) : void
		{
			Tf.removeEventListener(FocusEvent.FOCUS_IN,onFocus );
			Tf.removeEventListener(FocusEvent.FOCUS_OUT,onFocusOut );
			
			TfHolder.removeChild( Tf );
			TfHolder.removeChild( messageBr );
			TfHolder.removeChild( messageBg );
			removeChild( TfHolder );
			messageBg.graphics.clear();
			messageBr.graphics.clear();
			messageBg = null;
			messageBr = null;
			Tf = null;
			TfHolder = null;
			
			removeEventListener( Event.REMOVED_FROM_STAGE,remove );
		}
		
		
	}
}