//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing.Navigation
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import com.alptugan.drawing.ToolTip;
	import com.alptugan.events.ShareBtnEvents;
	import com.alptugan.primitives.Cross;
	import com.alptugan.text.ATextFieldCss;
	
	public class ShareButton extends Sprite
	{
		public var RoundRect : Shape;
		
		public var Txt : ATextFieldCss;
		
		//public var f : facebook,t : twitter;
		
		private var CubeCl : uint,CubeWH : int,eWH : int,RectW : int,RectH : int,TtW : int,TtH : int,tt : ToolTip,ttGap : int = 2;
		
		private var RoundCube : Shape;
		
		private var bdCross : Shape,Thickness : int,c : uint,Length : int;
		
		private var str : String;
		
		public function ShareButton( str : String,
			Thickness : int,
			Length : int,
			c : uint,
			CubeCl : uint,
			CubeWH : int,
			eWH : int,
			RectW : int,
			RectH : int,
			TtW : int = 44,
			TtH : int = 27 )
		{
			this.Thickness = Thickness;
			this.Length = Length;
			this.c = c;
			this.CubeCl = CubeCl;
			this.CubeWH = CubeWH;
			this.RectW = RectW;
			this.RectH = RectH;
			this.eWH = eWH;
			this.str = str;
			this.TtW = TtW;
			this.TtH = TtH;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		private function init( e : Event ) : void
		{
			
			//Write Text
			Txt = new ATextFieldCss( str,"uw","header",0,false );
			addChild( Txt );
			Txt.x = 3;
			Txt.y = 3;
			Txt.alpha = 0.5;
			
			//First Draw Bckground of Button
			RoundRect = new Shape();
			with ( RoundRect.graphics )
			{
				beginFill( c );
				drawRoundRect( 0,0,Txt.tf.width + CubeWH + 8,RectH,eWH,eWH );
				endFill();
			}
			
			addChildAt( RoundRect,0 );
			
			//Draw Square
			RoundCube = new Shape();
			with ( RoundCube.graphics )
			{
				beginFill( CubeCl );
				drawRoundRect( 0,0,CubeWH,CubeWH,eWH,eWH );
				endFill();
			}
			RoundCube.x = ( RoundRect.width - RoundCube.width ) - 2;
			RoundCube.y = ( RoundRect.height - RoundCube.height ) * 0.5;
			addChild( RoundCube );
			
			//Draw Cross
			bdCross = new Shape();
			with ( bdCross.graphics )
			{
				beginFill( c,1 );
				
				lineStyle( Thickness,c,1,true );
				moveTo( 0,Length * 0.5 );
				lineTo( Length,Length * 0.5 );
				moveTo( Length * 0.5,0 );
				lineTo( Length * 0.5,Length );
				endFill();
			}
			bdCross.x = RoundCube.x + Length * 0.5;
			bdCross.y = RoundCube.y + Length * 0.5;
			addChild( bdCross );
			
			addEvent( this,MouseEvent.MOUSE_OVER,onthisOver );
			addEvent( this,MouseEvent.MOUSE_OUT,onthisOut );
			
			//	this.mouseChildren = false;
			this.buttonMode = true;
			drawHolderRect();
			//Add Pop up menu
			tt = new ToolTip( "",TtW,TtH,6,0x0074d9,0xffffff );
			tt.x = bdCross.width + bdCross.x - 4;
			tt.y = -ttGap;
			tt.scaleX = 0;
			tt.scaleY = 0;/*
			f = new facebook();
			f.name = "f";
			t = new twitter();
			tt.addChild( f );
			t.name = "t";
			f.y = ( -TtH - 6 ) + 6;
			t.x = ( -TtW * 0.5 ) + 5;
			f.x = ( -TtW * 0.5 ) + 24
			t.y = f.y;
			tt.addChild( t );
			addChild( tt );
			*/
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function onthisOver( e : MouseEvent ) : void
		{
			TweenLite.to( Txt,0.5,{ alpha: 1,ease: Expo.easeOut });
			TweenLite.to( tt,0.5,{ ease: Elastic.easeInOut,scaleX: 1,scaleY: 1 });
			//addEvent( t,MouseEvent.CLICK,onClickShare );
			//addEvent( f,MouseEvent.CLICK,onClickShare );
		
		}
		
		private function onthisOut( e : MouseEvent ) : void
		{
			TweenLite.to( Txt,0.5,{ alpha: 0.5,ease: Expo.easeOut });
			TweenLite.to( tt,0.5,{ ease: Elastic.easeOut,scaleX: 0,scaleY: 0 });
			//removeEvent( t,MouseEvent.CLICK,onClickShare );
			//removeEvent( f,MouseEvent.CLICK,onClickShare );
		}
		
		private function onClickShare( e : MouseEvent ) : void
		{
			//dispatchEvent(new Event(MouseEvent.CLICK));
			var sEvt : ShareBtnEvents = new ShareBtnEvents( ShareBtnEvents.ON_CLICK );
			if ( e.target.name == "f" )
			{
				sEvt.getSocialNetName = "f";
				dispatchEvent( sEvt );
			}
			else
			{
				sEvt.getSocialNetName = "t";
				dispatchEvent( sEvt );
			}
		}
		
		private function drawHolderRect() : Shape
		{
			var s : Shape = new Shape();
			with ( s.graphics )
			{
				beginFill( 0,0.0 );
				drawRect( 0,-TtH - 6 - this.ttGap,RoundRect.width > TtW ? RoundRect.width + ( RoundRect.width - TtW ) + 10 : TtW + 3,TtH + RoundRect.height + this.ttGap + 6 );
				endFill();
			}
			
			addChild( s );
			
			return s;
		}
		
		private function onRemoved( e : Event ) : void
		{
			removeEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
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
