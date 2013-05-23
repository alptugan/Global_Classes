//------------------------------------------------------------------------------
//   Copyright 2010 
//   All rights reserved. 
//------------------------------------------------------------------------------
/**
* Class for creating scroll buttons
*
* @author alp tugan
* @version 1beta
*/

package com.alptugan.template
{
	import com.greensock.TweenNano;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	
	public class SimpleScrollButtons extends Sprite
	{
		private var _delay : int;
		
		public function set delay( ms : int ) : void
		{
			_delay = ms;
			if ( timer )
			{
				timer.delay = _delay;
			}
		}
		
		private var _movement : int;
		
		public function set movement( mov : int ) : void
		{
			_movement = mov;
		}
		
		private var SingleClick : Boolean;
		
		private var TweenTime : Number = 0.5;
		
		private var blur : BlurFilter;
		
		private var btnDown : DisplayObject;
		
		private var btnUp : DisplayObject;
		
		private var direction : int;
		
		private var scrollTarget : Object;
		
		private var switcher : Boolean = false;
		
		private var targetMask : Object;
		
		private var timer : Timer;
		
		public function SimpleScrollButtons() : void
		{
			_movement = 200;
			_delay = 0;
			
			addEventListener( Event.ADDED_TO_STAGE,onInit );
			addEventListener( Event.REMOVED_FROM_STAGE,onRemove );
		
		}
		
		public function updateSize( _targ : Sprite,_msk : DisplayObject ) : void
		{
			scrollTarget = _targ;
			targetMask = _msk;
		}
		
		/**
		 * This function registers movieclips with scroll buttons
		 *
		 * @usage scrollButtons.init(myMC, myMask)
		 *
		 * @param	targ	movieclip to scroll
		 * @param	msk		mask for scroll target
		 * @param	mov		movement in pixels
		 * @param	del		delay in miliseconds between movements
		 */
		public function initUpDown( targ : Sprite,msk : DisplayObject,_btnUp : DisplayObject,_btnDown : DisplayObject,mov : int = 200,del : int = 0,_SingleClick : Boolean = false ) : void
		{
			SingleClick = _SingleClick;
			switcher = false;
			scrollTarget = targ;
			targetMask = msk;
			_movement = mov;
			_delay = del;
			btnUp = _btnUp;
			btnDown = _btnDown;
			
			if ( SingleClick )
			{
				AddListeners();
			}
			else
			{
				btnUp.addEventListener( MouseEvent.MOUSE_DOWN,scrollUp );
				btnUp.addEventListener( MouseEvent.MOUSE_UP,stopScroll );
				btnDown.addEventListener( MouseEvent.MOUSE_DOWN,scrollDown );
				btnDown.addEventListener( MouseEvent.MOUSE_UP,stopScroll );
				timer = new Timer( _delay );
				timer.addEventListener( "timer",move );
			}
		
		}
		
		public function initLeftRight( targ : Sprite,msk : DisplayObject,btnLeft : Sprite,btnRight : Sprite,mov : int = 30,del : int = 0,_SingleClick : Boolean = false ) : void
		{
			SingleClick = _SingleClick;
			switcher = true;
			scrollTarget = targ;
			targetMask = msk;
			_movement = mov;
			_delay = del;
			btnUp = btnLeft;
			btnDown = btnRight;
			
			if ( SingleClick )
			{
				AddListeners();
			}
			else
			{
				btnUp.addEventListener( MouseEvent.MOUSE_DOWN,scrollUp );
				btnUp.addEventListener( MouseEvent.MOUSE_UP,stopScroll );
				btnDown.addEventListener( MouseEvent.MOUSE_DOWN,scrollDown );
				btnDown.addEventListener( MouseEvent.MOUSE_UP,stopScroll );
				timer = new Timer( _delay );
				timer.addEventListener( "timer",move );
			}
		}
		
		private function onInit( e : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE,onInit );
			blur = new BlurFilter();
			blur.blurX = 0;
			blur.blurY = 0;
			blur.quality = BitmapFilterQuality.MEDIUM;
		}
		
		private function scrollUp( e : Event ) : void
		{
			if ( switcher )
			{
				if ( scrollTarget.x < targetMask.x )
				{
					direction = 1;
					timer.start();
					Blur_Effect_On();
				}
			}
			else
			{
				if ( scrollTarget.y < targetMask.y )
				{
					direction = 1;
					timer.start();
					Blur_Effect_On();
				}
			}
		}
		
		private function scrollDown( e : Event ) : void
		{
			if ( switcher )
			{
				if (( scrollTarget.x + scrollTarget.width ) > ( targetMask.x + targetMask.width ))
				{
					direction = -1;
					timer.start();
					Blur_Effect_On();
				}
			}
			else
			{
				if (( scrollTarget.y + scrollTarget.height ) > ( targetMask.y + targetMask.height ))
				{
					direction = -1;
					timer.start();
					Blur_Effect_On();
				}
			}
		}
		
		private function stopScroll( e : Event ) : void
		{
			timer.stop();
			Blur_Effect_Off();
		}
		
		private function onClickUp( e : MouseEvent ) : void
		{
			direction = 1;
			if ( !this.switcher )
			{
				if (( scrollTarget.y < targetMask.y ))
				{
					Blur_Effect_On();
					btnUp.removeEventListener( MouseEvent.CLICK,onClickUp );
					btnDown.removeEventListener( MouseEvent.CLICK,onClickDown );
				}
				move( null );
			}
			else
			{
				if (( scrollTarget.x < targetMask.x ))
				{
					Blur_Effect_On();
					btnUp.removeEventListener( MouseEvent.CLICK,onClickUp );
					btnDown.removeEventListener( MouseEvent.CLICK,onClickDown );
				}
				move( null );
			}
		}
		
		private function onClickDown( e : MouseEvent ) : void
		{
			direction = -1;
			if ( !this.switcher )
			{
				if (( scrollTarget.y + scrollTarget.height ) > ( targetMask.y + targetMask.height ))
				{
					Blur_Effect_On();
					btnUp.removeEventListener( MouseEvent.CLICK,onClickUp );
					btnDown.removeEventListener( MouseEvent.CLICK,onClickDown );
				}
				move( null );
			}
			else
			{
				if (( scrollTarget.x + scrollTarget.width ) > ( targetMask.x + targetMask.width ))
				{
					Blur_Effect_On();
					btnUp.removeEventListener( MouseEvent.CLICK,onClickUp );
					btnDown.removeEventListener( MouseEvent.CLICK,onClickDown );
				}
				move( null );
			}
		}
		
		private function move( e : Event ) : void
		{
			//var myTween   : TweenNano;
			if ( switcher )
			{
				if (( direction > 0 ) && ( scrollTarget.x < targetMask.x ))
					TweenNano.to( scrollTarget,TweenTime,{ x: scrollTarget.x + _movement,onUpdate: CheckSlideVal });
				
				if (( direction < 0 ) && ( scrollTarget.x + scrollTarget.width ) > ( targetMask.x + targetMask.width ))
					TweenNano.to( scrollTarget,TweenTime,{ x: scrollTarget.x - _movement,onUpdate: CheckSlideVal });
			}
			else
			{
				if (( direction > 0 ) && ( scrollTarget.y < targetMask.y ))
					scrollTarget.y += _movement; //TweenNano.to(scrollTarget,TweenTime, {y: scrollTarget.y+_movement,onUpdate:CheckSlideVal/*,onComplete:AddListeners*/});
				
				if (( direction < 0 ) && ( scrollTarget.y + scrollTarget.height ) > ( targetMask.y + targetMask.height ))
					scrollTarget.y -= _movement; //TweenNano.to(scrollTarget,TweenTime, {y: scrollTarget.y-_movement,onUpdate:CheckSlideVal/*,onComplete:AddListeners*/});
			}
		}
		
		private function CheckSlideVal() : void
		{
			if ( switcher )
			{
				if ( scrollTarget.x > targetMask.x )
				{
					Blur_Effect_Off();
					timer.stop();
					scrollTarget.x = targetMask.x;
					
				}
				
				if ( scrollTarget.x < -scrollTarget.width + targetMask.width )
				{
					Blur_Effect_Off();
					timer.stop();
					scrollTarget.x = -scrollTarget.width + targetMask.width;
				}
			}
			else
			{
				if ( scrollTarget.y > targetMask.y )
				{
					Blur_Effect_Off();
					timer.stop();
					scrollTarget.y = targetMask.y;
				}
				
				if ( scrollTarget.y < -scrollTarget.height + targetMask.height )
				{
					Blur_Effect_Off();
					timer.stop();
					scrollTarget.y = -scrollTarget.height + targetMask.height;
					Blur_Effect_Off();
				}
			}
		
		}
		
		private function AddListeners() : void
		{
			Blur_Effect_Off();
			btnUp.addEventListener( MouseEvent.CLICK,onClickUp );
			btnDown.addEventListener( MouseEvent.CLICK,onClickDown );
		}
		
		private function Blur_Effect_On() : void
		{
			if ( switcher )
			{
				blur.blurX = 5;
			}
			else
			{
				blur.blurY = 5;
			}
			
			scrollTarget.filters = [ blur ];
		}
		
		private function Blur_Effect_Off() : void
		{
			blur.blurY = 0;
			blur.blurX = 0;
			scrollTarget.filters = [ blur ];
		}
		
		private function onRemove( e : Event ) : void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE,onRemove );
			
			if ( SingleClick )
			{
				btnUp.removeEventListener( MouseEvent.CLICK,onClickUp );
				btnDown.removeEventListener( MouseEvent.CLICK,onClickDown );
			}
			else
			{
				btnUp.removeEventListener( MouseEvent.MOUSE_DOWN,scrollUp );
				btnUp.removeEventListener( MouseEvent.MOUSE_UP,stopScroll );
				btnDown.removeEventListener( MouseEvent.MOUSE_DOWN,scrollDown );
				btnDown.removeEventListener( MouseEvent.MOUSE_UP,stopScroll );
			}
			
			scrollTarget = null;
			targetMask = null;
			btnUp = null;
			btnDown = null;
		}
	}

}
