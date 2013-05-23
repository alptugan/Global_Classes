/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : AButtonHandlers.as
 * Release Date : Aug 14, 2011
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/
package com.alptugan.template
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.BevelFilterPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;

	public class AButtonHandlers extends EventDispatcher
	{
		
		private var btn:CasaSprite;
		private var _onColor:uint;
		private var _scaleFac:Number = 1;
		
		public function AButtonHandlers()
		{
			
		}
		//======================================================================================================================
		// GETTER and SETTER
		//======================================================================================================================

		/**
		 * 
		 * @return scale factor when mouse over
		 * 
		 */
		public function get scaleFac():Number
		{
			return _scaleFac;
		}

		public function set scaleFac(value:Number):void
		{
			_scaleFac = value;
		}
		
		/**
		 * 
		 * @return Color value of the  tween
		 * 
		 */		
		public function get onColor():uint
		{
			return _onColor;
		}

		/**
		 * 
		 * @param value set Color value when mouse over
		 * 
		 */
		public function set onColor(value:uint):void
		{
			_onColor = value;
		}

		public function initHandlers(btn:CasaSprite):void
		{
			this.btn = btn;
			this.btn.buttonMode = true;
			
			//activate Glow Filter Tweens
			TweenPlugin.activate([GlowFilterPlugin]);
			
			TweenPlugin.activate([BevelFilterPlugin]); 
			//add Button Event Handlers
			btn.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			btn.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			btn.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onOut(e:MouseEvent):void
		{
			//TweenLite.to(btn, 1, {glowFilter:{color:_onColor, blurX:0, blurY:0, strength:0, alpha:1}});
			TweenLite.to(btn, 0.2, {bevelFilter:{blurX:0, blurY:0, distance:0, angle:90, strength:0},scaleX:1,scaleY:1});
		}
		
		protected function onClick(e:MouseEvent):void
		{
			dispatchEvent(e);
		}
		
		protected function onOver(e:MouseEvent):void
		{
			//TweenLite.to(btn, 0.2, {glowFilter:{color:_onColor, blurX:2, blurY:2, strength:1, alpha:1}});
			TweenLite.to(btn, 0.2, {bevelFilter:{blurX:4, blurY:4, distance:1, angle:90, strength:1},scaleX:scaleFac,scaleY:scaleFac});
		}
		
		/**
		 * 
		 * @param _btn : Button on the stage
		 * 
		 * Remove all Handlers and kill tweens of current target
		 * 
		 */
		public function disposeHandlers():void
		{
			btn.removeEventListener(MouseEvent.MOUSE_OVER,onOver);
			btn.removeEventListener(MouseEvent.MOUSE_OVER,onOut);
			btn.removeEventListener(MouseEvent.MOUSE_OVER,onClick);
			TweenLite.killTweensOf(btn,true);
		}
	}
}