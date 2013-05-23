//------------------------------------------------------------------------------
//   Copyright 2011 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.Template
{
	import com.greensock.TweenMax;
	import com.greensock.easing.FastEase;
	import com.greensock.easing.Strong;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import com.alptugan.display.CreateMask;
	import com.alptugan.text.ATextFieldCss;
	import com.alptugan.text.TextArea.ABasicTextArea;
	import com.alptugan.valueObjects.ListManagerVO;
	import com.alptugan.ui.SWFWheel;
	FastEase.activate([ Strong ]);
	
	public class ListManager extends Sprite
	{
		public var Holder : Sprite;
		
		public var Items : Vector.<Sprite>;
		
		public var Mask : Shape;
		
		public var ScrollBar : FullScreenScrollBar;
		
		public var Source : XML,w : int,h : int,Id : int = -1,mOverColor : uint;
		
		public var VO : Vector.<ListManagerVO>;
		
		public function ListManager( _Source : XML,_w : int,_h : int,_mOverColor : uint )
		{
			super();
			mOverColor = _mOverColor;
			Source = _Source;
			w = _w;
			h = _h;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		public function onResize( W : int,H : int ) : void
		{
			Mask.height = H;
		}
		
		/**Parse XML Data into a Vector of ListManagerVOs**/
		private function init( e : Event ) : void
		{
			removeEvent( this,Event.ADDED_TO_STAGE,init );
			
			var i : int;
			var l : int           = Source.item.length();
			
			
			VO = new Vector.<ListManagerVO>( l,true );
			
			/**Create Mask for Holder**/
			Mask = CreateMask.Create( 0,0,w,h );
			addChild( Mask );
			
			/**Holder Sprite for Items on the display list**/
			Holder = new Sprite();
			addChild( Holder );
			Holder.mask = Mask;
			Items = new Vector.<Sprite>( l,true );
			
			var TotalHeight : int = 0;
			
			for ( i;i < l;++i )
			{
				/**Parse XML to VAriables**/
				VO[ i ] = new ListManagerVO();
				VO[ i ].id = Source.item[ i ].id;
				VO[ i ].name = Source.item[ i ].name;
				VO[ i ].link = Source.item[ i ].link;
				
				/**Write variables to display list**/
				Items[ i ] = new ATextFieldCss( VO[ i ].name,"uw","content",0,false );
				Items[ i ].alpha = 0;
				Items[ i ].name = String( i );
				/**Add Interactive Listeners**/
				addEvent( Items[ i ],MouseEvent.CLICK,onClick );
				addEvent( Items[ i ],MouseEvent.MOUSE_OVER,onOver );
				addEvent( Items[ i ],MouseEvent.MOUSE_OUT,onOut );
				Holder.addChild( Items[ i ]);
				Items[ i ].y = Items[ i ].height * 0.3 + TotalHeight;
				Items[ i ].x = 5;
				var s : Shape = Rect( -5,-Items[ i ].height * 0.3 );
				s.alpha = 0;
				Items[ i ].addChildAt( s,0 );
				TotalHeight += Items[ i ].height;
				
				TweenMax.to( Items[ i ],1,{ alpha: 1,delay: i * 0.05,ease: Strong.easeOut /*,onComplete:RemoveRects,onCompleteParams:[i]*/ });
			}
			
			if ( Holder.height > h )
			{
				SWFWheel.initialize( stage );
				ScrollBar = new FullScreenScrollBar( Holder,h,w,Globals.Blue,Globals.BlueLight,Globals.Blue,0xffffff,1,15,4,false );
				addChild( ScrollBar );
				Mask.height = h;
				Mask.width = w;
				ScrollBar.x = Mask.width;
			}
		}
		
		private function RemoveRects( k : int ) : void
		{
			TweenMax.to( Items[ k ].getChildAt( 0 ),0.3,{ alpha: 0,delay: k * 0.02,ease: Strong.easeOut });
		}
		
		/**Add Mouse Events when Tweens completed**/
		private function onClick( e : MouseEvent ) : void
		{
			if ( Id != -1 )
			{
				TweenMax.to( Items[ int( Id )].getChildAt( 0 ),0.5,{ alpha: 0,ease: Strong.easeOut });
				addEvent( Items[ Id ],MouseEvent.CLICK,onClick );
				addEvent( Items[ Id ],MouseEvent.MOUSE_OVER,onOver );
				addEvent( Items[ Id ],MouseEvent.MOUSE_OUT,onOut );
				
			}
			
			Id = int( e.target.name );
			removeEvent( Items[ Id ],MouseEvent.CLICK,onClick );
			removeEvent( Items[ Id ],MouseEvent.MOUSE_OVER,onOver );
			removeEvent( Items[ Id ],MouseEvent.MOUSE_OUT,onOut );
			
			if ( VO[ Id ].link != "http://" )
			{
				navigateToURL( new URLRequest( String( VO[ Id ].link )),"_blank" );
			}
		}
		
		private function onOver( e : MouseEvent ) : void
		{
			TweenMax.to( Items[ int( e.target.name )].getChildAt( 0 ),0.5,{ alpha: 1,ease: Strong.easeOut });
		}
		
		private function onOut( e : MouseEvent ) : void
		{
			TweenMax.to( Items[ int( e.target.name )].getChildAt( 0 ),0.5,{ alpha: 0,ease: Strong.easeIn });
		}
		
		/**Blue Rectangle for mouse Over Events**/
		private function Rect( _x : int,_y : int ) : Shape
		{
			var s : Shape = new Shape();
			with ( s.graphics )
			{
				beginFill( mOverColor,0.3 );
				drawRect( _x,_y,w,29 );
				endFill();
			}
			
			return s;
		}
		
		private function onRemoved( e : Event ) : void
		{
			removeEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
			
			VO = null;
			for ( var i : int;i < Source.item.length();++i )
			{
				removeEvent( Items[ i ],MouseEvent.CLICK,onClick );
				removeEvent( Items[ i ],MouseEvent.MOUSE_OVER,onOver );
				removeEvent( Items[ i ],MouseEvent.MOUSE_OUT,onOut );
				TweenMax.killTweensOf( Items[ i ]);
				Holder.removeChild( Items[ i ]);
				Items[ i ] = null;
			}
			Items = null;
			removeChild( Holder );
			Holder = null;
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
