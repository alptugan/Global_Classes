//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.drawing
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;
	import com.alptugan.text.ATextFieldCss;
	
	/**
	 *
	 * @author alptugan
	 *
	 */
	public class ToolTip extends Sprite
	{
		private var Eff : Boolean,GFilter : GlowFilter;
		
		private var cornerR : int = 6;
		
		private var fCl : uint;
		
		private var h : int;
		
		private var sCl : uint;
		
		private var w : int,
			str : String,
			tf : ATextFieldCss;
		
		public function ToolTip( str : String,w : int,h : int,cornerR : int,sCl : int,fCl : int,Eff : Boolean = true )
		{
			this.w = w;
			this.h = h;
			this.sCl = sCl;
			this.fCl = fCl;
			this.cornerR = cornerR;
			this.Eff = Eff;
			this.str = str;
			addEvent( this,Event.ADDED_TO_STAGE,init );
			addEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
		}
		
		public function setSize( w : int,h : int ) : void
		{
			
			with ( graphics )
			{
				clear();
				lineStyle( 1,sCl,1,true );
				beginFill( fCl );
				moveTo( 0,0 );
				lineTo( -6,-6 );
				lineTo( -w * 0.5 + cornerR,-6 ); //
				curveTo( -w * 0.5,-6,-w * 0.5,-6 - cornerR );
				lineTo( -w * 0.5,-h - 6 + cornerR );
				curveTo( -w * 0.5,-h - 6,-w * 0.5 + cornerR,-h - 6 );
				lineTo( w * 0.5 - cornerR,-h - 6 ); //
				curveTo( w * 0.5,-h - 6,w * 0.5,-h - 6 + cornerR );
				lineTo( w * 0.5,-6 - cornerR );
				curveTo( w * 0.5,-6,w * 0.5 - cornerR,-6 );
				lineTo( 6,-6 );
				lineTo( 0,0 );
				endFill();
			}
			
			tf.y = -tf.height - (( h - tf.height ) * 0.5 ) - 3;
			tf.x = -tf.width * 0.5;
		}
		
		private function init( e : Event ) : void
		{
			
			with ( graphics )
			{
				lineStyle( 1,sCl,1,true );
				beginFill( fCl );
				moveTo( 0,0 );
				lineTo( -6,-6 );
				lineTo( -w * 0.5 + cornerR,-6 ); //
				curveTo( -w * 0.5,-6,-w * 0.5,-6 - cornerR );
				lineTo( -w * 0.5,-h - 6 + cornerR );
				curveTo( -w * 0.5,-h - 6,-w * 0.5 + cornerR,-h - 6 );
				lineTo( w * 0.5 - cornerR,-h - 6 ); //
				curveTo( w * 0.5,-h - 6,w * 0.5,-h - 6 + cornerR );
				lineTo( w * 0.5,-6 - cornerR );
				curveTo( w * 0.5,-6,w * 0.5 - cornerR,-6 );
				lineTo( 6,-6 );
				lineTo( 0,0 );
				endFill();
			}
			
			if ( this.Eff )
			{
				GFilter = new GlowFilter( 0x000000,0.2,8,8,2 );
				this.filters = [ GFilter ];
			}
			tf = new ATextFieldCss( str,"w","list",w,false );
			addChild( tf );
			
			str != "" ? setSize( tf.width + 10,tf.height + 10 ):void;
			removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		/*lineStyle(1,sCl);
		beginFill(fCl);
		moveTo(0,0);
		lineTo(-6,-6);
		lineTo(-w*0.5 , -6);
		lineTo(-w*0.5 ,-h-6);
		lineTo(w*0.5 ,-h-6);
		lineTo(w*0.5 ,-6);
		lineTo(6,-6);
		lineTo(0,0);
		endFill();*/
		private function onRemoved( e : Event ) : void
		{
			this.graphics.clear();
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