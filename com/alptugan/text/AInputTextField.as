//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.text
{
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.*;
	import com.alptugan.text.FontLoader.FontClass;
	import com.alptugan.utils.FontLoader;
	
	public class AInputTextField extends Sprite
	{
		public var Tf : TextField;
		
		public var TfHolder : Sprite,messageBr : Shape,messageBg : Shape;
		
		private var TfFmt : TextFormat;
		
		private var fInStr : String;
		
		private var w : int,
			h : int,
			StrokeColor : uint,
			BgColor : uint,
			TxtColor : uint,
			FontSize : Number,
			TabInt : int;
		
		public function AInputTextField( StrokeColor : uint = 0xd6d6d6,w : Number = 200,h : Number = 16,TxtColor : uint = 0,FontSize : Number = 11,BgColor : uint = 0,fInStr : String = "",TabInt : int = 0 )
		{
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,remove );
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
		}
		
		private function init( e : Event ) : void
		{
			
			removeEvent( this,Event.ADDED_TO_STAGE,init );
			TfHolder = new Sprite();
			TfFmt = new TextFormat();
			
			if ( this.FontSize != 0 )
				TfFmt.size = FontSize;
			else
				TfFmt.size = 11;
			
			if ( this.TxtColor != 0 )
				TfFmt.color = 0x606060;
			
			TfFmt.font = FontClass.InputFont.fontName;
			TfFmt.letterSpacing = 1;
			
			Tf = new TextField();
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
			Tf.x = 3;
			Tf.y = 2;
			//TfFmt.font = "Arial";
			
			if ( Tf.text == "" )
				Tf.text = this.fInStr;
			addEvent( Tf,FocusEvent.FOCUS_IN,onFocus );
			addEvent( Tf,FocusEvent.FOCUS_OUT,onFocusOut );
			
			messageBr = new Shape();
			messageBr.graphics.beginFill( this.StrokeColor );
			messageBr.graphics.drawRect( 0,0,this.w,this.h );
			messageBr.graphics.endFill();
			messageBr.name = "br";
			messageBg = new Shape();
			messageBg.graphics.beginFill( this.BgColor );
			messageBg.graphics.drawRect( 1,1,this.w - 2,this.h - 2 );
			messageBg.graphics.endFill();
			messageBg.name = "bg";
			
			TfHolder.addChild( messageBr );
			TfHolder.addChild( messageBg );
			TfHolder.addChild( Tf );
			addChild( TfHolder );
		
		}
		
		private function onFocus( e : Event ) : void
		{
			TweenLite.from( messageBr,0.5,{ blurFilter: { blurX: 15,blurY: 15 }});
			TweenLite.to( messageBr,0.5,{ tint: 0xff0000  }); //Globals.FocusOnCl
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
			removeEvent( Tf,FocusEvent.FOCUS_IN,onFocus );
			removeEvent( Tf,FocusEvent.FOCUS_OUT,onFocusOut );
			
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
			
			removeEvent( this,Event.REMOVED_FROM_STAGE,remove );
		}
		
		private function addEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.addEventListener( type,listener,false,0,true );
		}
		
		private function removeEvent( item : EventDispatcher,type : String,listener : Function ) : void
		{
			item.removeEventListener( type,listener );
		}
	}
}
/*package  alptugan.Text
{

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TextEvent;
import flash.text.*;

public class AInputTextField extends Sprite
{
public var Tf:TextField = new TextField();
public var myTextBox2:TextField = new TextField();
private var _w        : int;
private var _h        : int;
private var _color    : uint;
private var TfFmt    :TextFormat = new TextFormat();
private var BgColor   : uint;
private var TxtColor  :uint;
private var FontSize  :Number;
private var fInStr    : String;

public function AInputTextField(color:uint = 0xd6d6d6,w:Number = 200, h:Number = 16, TxtColor:uint = 0 , FontSize:Number = 0,BgColor:uint=0,fInStr:String="")
{
addEvent(this,Event.ADDED_TO_STAGE,init);
addEvent(this,Event.REMOVED_FROM_STAGE,remove);
//txtAlign            = _txtAlign;
//url                 = _url;
_w     = w;
_h     = h;
_color = color;
this.BgColor = BgColor;
this.TxtColor = TxtColor;
this.FontSize = FontSize;
this.fInStr   = fInStr;
}

private function init(e:Event):void
{
//Tf.embedFonts    = true;
removeEvent(this,Event.ADDED_TO_STAGE,init);
Tf.type          = TextFieldType.INPUT;

Tf.width         = _w;
Tf.height        = _h;
if(this.BgColor != 0)
{
Tf.background    = true;
Tf.border        = false;
Tf.backgroundColor = this.BgColor;
}else{
Tf.background    = false;
Tf.border        = true;
Tf.borderColor   = _color;
}

Tf.selectable    = true;
Tf.multiline     = true;
Tf.wordWrap      = true;
Tf.antiAliasType = AntiAliasType.ADVANCED;
//Tf.gridFitType   = GridFitType.PIXEL;

myTextBox2.x=200;

TfFmt.font = "Tahoma";

if(FontSize != 0)
TfFmt.size = FontSize;
else
TfFmt.size = 11;

if(this.TxtColor != 0)
TfFmt.color = 0x606060;

//TfFmt.font = "Neue";
TfFmt.letterSpacing = 1;
//addChild(myTextBox2);
Tf.defaultTextFormat = TfFmt;
addChild(Tf);

Tf.addEventListener(TextEvent.TEXT_INPUT,textInputHandler);
}

public function textInputHandler(event:TextEvent):void
{
myTextBox2.text=event.text;
}

private function remove(e:Event):void
{
Tf.removeEventListener(TextEvent.TEXT_INPUT,textInputHandler);
removeChild(Tf);
Tf = null;
myTextBox2 = null;
removeEvent(this,Event.REMOVED_FROM_STAGE,remove);
}

private function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
item.addEventListener(type, listener, false, 0, true);
}

private function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
item.removeEventListener(type, listener);
}
}
}*/
