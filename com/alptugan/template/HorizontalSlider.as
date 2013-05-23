//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
package com.alptugan.template
{
	import com.alptugan.utils.Bounds;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 *
	 * @author alptugan
	 *
	 */
	public class HorizontalSlider
	{
		private var
			targ : DisplayObject,
			BtnLeft : DisplayObject,
			BtnRight : DisplayObject,
			mov : Number,
			direction : int,
			TweenTime : Number,
			_bounds:Object;
		
		public function HorizontalSlider( targ : DisplayObject, _bounds:Object ,BtnLeft : DisplayObject,BtnRight : DisplayObject,mov : Number = 200,TweenTime : Number = 0.3 )
		{
			this.targ = targ;
			this.BtnLeft = BtnLeft;
			this.BtnRight = BtnRight;
			this.mov = mov;
			this.TweenTime = TweenTime;
			this._bounds = _bounds;
			
			AddListeners();
		
		}
		
		/**
		 * SET BOUNDS OF THE SLIDER 
		 * @param value
		 * 
		 */
		public function set bounds(value:Object):void
		{
			_bounds = value;
		}

		private function init( e : Event ) : void
		{
			//removeEvent( this,Event.ADDED_TO_STAGE,init );
		}
		
		private function AddListeners() : void
		{
			//Blur_Effect_Off();
			addEvent( BtnLeft,MouseEvent.CLICK,onClickLeft );
			addEvent( BtnRight,MouseEvent.CLICK,onClickRight );
		}
		
		private function RemoveListeners() : void
		{
			removeEvent( BtnLeft,MouseEvent.CLICK,onClickLeft );
			removeEvent( BtnRight,MouseEvent.CLICK,onClickRight );
		}
		
		private function onClickLeft( e : MouseEvent ) : void
		{
			direction = 1;
			
			if (( targ.x < _bounds._x ))
			{
				//Blur_Effect_On();
				/*BtnRight.removeEventListener( MouseEvent.CLICK,onClickRight );
				BtnLeft.removeEventListener( MouseEvent.CLICK,onClickLeft );*/
			}
			move();
		}
		
		private function onClickRight( e : MouseEvent ) : void
		{
			direction = -1;
			
			if (( targ.x + targ.width ) > ( _bounds._x + _bounds._w ))
			{
				//Blur_Effect_On();
				/*BtnRight.removeEventListener( MouseEvent.CLICK,onClickRight );
				BtnLeft.removeEventListener( MouseEvent.CLICK,onClickLeft );*/
			}
			
			move();
		}
		
		private function move() : void
		{
			if (( direction > 0 ))
				TweenMax.to( targ,TweenTime,{ x: String( mov ),ease: Expo.easeOut,onUpdate: CheckSlideVal });
			
			if (( direction < 0 ))
			{
				TweenMax.to( targ,TweenTime,{ x: String( mov * direction ),ease: Expo.easeOut,onUpdate: CheckSlideVal });
				
			}
		
		}
		
		private function CheckSlideVal() : void
		{
			if ( targ.x > 0 )
			{
				//Blur_Effect_Off();
				targ.x = 0;
				
			}
			
			if ( targ.x < -targ.width + mov - 1 )
			{
				//Blur_Effect_Off();
				targ.x = -targ.width + mov - 1;
			}
		}
		
		private function onRemoved( e : Event ) : void
		{
			//removeEvent( this,Event.REMOVED_FROM_STAGE,onRemoved );
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
