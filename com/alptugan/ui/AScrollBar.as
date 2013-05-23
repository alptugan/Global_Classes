/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : AScrollBar.as
 * Release Date : Aug 10, 2011
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/
package com.alptugan.ui
{
	import com.alptugan.globals.Root;
	import com.alptugan.template.AButtonHandlers;
	import com.alptugan.utils.Colors;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	
	public class AScrollBar extends Root
	{		
					// scroller
		private var sc          : CasaSprite = new CasaSprite(), 
					// scroller background
					scBg        : CasaSprite = new CasaSprite(),
					// mask for the content
					contentMask : CasaShape  = new CasaShape(),
					// content to be scrolled
					content     : DisplayObjectContainer;
		
					// scroller color
		private var scColor  : uint, 
					// scroller height
					scHeight : int, 
					// width of the scroller and scroller background			
					scWidth  : int; 
					
					
					// radius value of the scroller and scroller background. you can simply set values for each corner seperately in an array [top-left,top-right,bottom-right,bottom-left] 
		private var roundness  : Array,  
					// Boolean simply to add inner shadow to the scroller background
					bolFilters : Boolean,
					// Boolean for whether the scroller is pressed or not
					pressed    : Boolean; 
		
					// scroller background color
		private var scBgColor:uint, 
					// scroller background height
					scBgHeight:int; 
					
					// desired width
		private var w :int,	
					// desired height
					h:int;			
		
					// scroller height
		private var scH   : int,	
					// scroller background height
					scBgH : int,	
					// content height
					cH    : int; 	

					// default position of the content on the screen
		private var defaultPosition : int = 0,
					// gap between scroller and content
					gap             : int = 10, 
					// ease amount of the animation when srolling
					easeAmount      : int = 2,  
					scrollValue     : int;
					
					// Event dispatcher for Button handlers
		private var initButton : AButtonHandlers; 
		
		
		public function AScrollBar(content:DisplayObjectContainer, w:int,h:int,scWidth:int,scColor:uint,scBgColor:uint,roundness:Array = null,bolFilters:Boolean = true )
		{
			super();
			this.content = content;
			this.w = w;
			this.h = h;
			
			this.scWidth = scWidth;
			this.scColor = scColor;
			
			this.scBgColor = scBgColor;
			this.scBgH     = h;
			this.scHeight  = h;
			
			if(roundness == null)
			{
				this.roundness = [0,0,0,0];
			}else{
				(roundness.length == 1) ? this.roundness = [roundness[0],roundness[0],roundness[0],roundness[0]] : this.roundness = roundness;
			}
			
			this.bolFilters = bolFilters;
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);			
		}
		
		protected function onAdded(e:Event):void
		{	
			this.removeEventsForType(Event.ADDED_TO_STAGE);
						
			//Set the slider next to content
			this.x = content.x;
			this.y = content.y;
			
			//Create Mask to hide the Content
			createContentMask();
			
			//Create scroller and scroller Background. 
			createScrollerBg();
			createScroller();

			
			//init Button Handlers and set properties
			initButton = new AButtonHandlers();
			initButton.onColor = scColor;
			initButton.initHandlers(sc);
			
			
			//Then add them to the stage
			addChild(scBg);
			addChild(sc);
			
			//Add visual effects if bolFilter set true
			if (bolFilters) 
			{	
				scBg.filters = [new DropShadowFilter(1,90,scColor,0.3,4,4,1,1,true)];
			}
			
			//Init global Event Listeners
			initResizeHandler();
			initMouseLeave();
			initMouseWheel();
			initMouseUp();
			
			
			
			sc.addEventListener(MouseEvent.MOUSE_DOWN, scMouseDown, false, 0, true);
			
			scBg.addEventListener(MouseEvent.CLICK, scBgClick, false, 0, true);
			
			//After they are added to stage, adjust scroller and scroller bg relative to the content sizes
			defaultPosition = Math.round(content.y);
			adjustSize();
			
		}
				
		/**
		 * Adjust size of the sc relative to content height 
		 * 
		 */
		private function adjustSize():void
		{
			sc.y = 0;
			scBgH = scBg.height;
			
			//TODO @defaultposition for dynamic resizing of the content and mask
			cH = content.height + defaultPosition;
			
			// Set height of grabber relative to how much content
			scHeight = Math.ceil((scBgH / cH) * scBgH);
			
			// Set minimum size for grabber
			if(scHeight < 35) scHeight = 35;
			createScroller();
			
			// If scroller is taller than stage height, set its y position to the very bottom
			if ((sc.y + scHeight) > h) sc.y = h - scHeight;
			
			// If content height is less than stage height, set the scroller y position to 0, otherwise keep it the same
			sc.y = (cH < h) ? 0 : sc.y;
			
			// If content height is greater than the stage height, show it, otherwise hide it
			this.visible = (cH + 8 > h);
			
			// Distance left to scroll
			scrollValue = h - scHeight;
			
			content.y = Math.round(-((cH - h) * (sc.y / scrollValue)) + defaultPosition);
						
			if(content.height < h) { disposeMouseWheel(); } else { initMouseWheel(); }
		}
		
		/**
		 * 
		 * @param e
		 * SC MOUSE DOWN
		 */
		protected function scMouseDown(e:MouseEvent):void
		{
			pressed = true;
			sc.startDrag(false, new Rectangle(sc.x, 0, 0, h - sc.height));
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveListener, false, 0, true);
			//TweenLite.to(_grabber.getChildByName("bg"), 0.5, { tint:_grabberPressColor } );
		}
		
		/**
		 * When user clicks onto Background image of scroller
		 * @param e
		 * 
		 */
		protected function scBgClick(e:MouseEvent):void
		{
			var p : int;
			
			p = Math.ceil( e.stageY - defaultPosition );
			
			if ( p < sc.y )
			{
				if ( sc.y < sc.height )
				{
					TweenLite.to( sc,0.5,{ y: 0,onComplete: reset,overwrite: 1 });
				}
				else
				{
					TweenLite.to( sc,0.5,{ y: "-50",onComplete: reset });
				}
				
				if ( sc.y < 0 )
					sc.y = 0;
			}
			else
			{
				if (( sc.y + sc.height ) > ( h - sc.height ))
				{
					TweenLite.to( sc,0.5,{ y: h - sc.height,onComplete: reset,overwrite: 1 });
				}
				else
				{
					TweenLite.to( sc,0.5,{ y: "50",onComplete: reset });
				}
				
				if ( sc.y + sc.height > h )
					sc.y = h - sc.height;
			}
			
			function reset() : void
			{
				if ( sc.y < 0 ) sc.y = 0;
				if ( sc.y + sc.height > scBg.height ) sc.y = h - sc.height;
			}
			
			sc.addEventListener( Event.ENTER_FRAME,scrollContent,false,0,true );
		}
		
		override protected function onResize(e:Event):void
		{
			//trace(stage.stageHeight);
		}
		
		override protected function onMouseLeave(e:Event):void
		{
			onUpListener();
		}
		
		private function onUpListener():void
		{
			if (pressed)
			{
				pressed = false;
				sc.stopDrag();
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveListener);
			}
		}
		
		//============================================================================================================================
		private function onMouseMoveListener(e:MouseEvent):void
		//============================================================================================================================
		{
			e.updateAfterEvent();
			
			if (!sc.willTrigger(Event.ENTER_FRAME)) sc.addEventListener(Event.ENTER_FRAME, scrollContent, false, 0, true);
		}
		
		//============================================================================================================================
		private function scrollContent(e:Event):void
		//============================================================================================================================
		{
			var ty:Number;
			var dist:Number;
			var moveAmount:Number;
			
			ty = -((cH - h) * (sc.y / scrollValue));
			dist = ty - content.y + defaultPosition;
			moveAmount = dist / easeAmount;
			content.y += Math.round(moveAmount);
			
			if (Math.abs(content.y - ty - defaultPosition) < 1.5)
			{
				sc.removeEventListener(Event.ENTER_FRAME, scrollContent);
				content.y = Math.round(ty) + defaultPosition;
			}
			
		}
		
		/**
		 * MOUSE UP 
		 * @param e
		 * 
		 */
		override protected function  onMouseUp(e:MouseEvent):void
		{
			if (pressed)
			{
				pressed = false;
				sc.stopDrag();
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveListener);
			}
		}
		
		/**
		 * MOUSE WHEEL 
		 * @param e
		 * 
		 */
		override protected function  onMouseWheel(e:MouseEvent):void
		{
			var d:Number = e.delta;
			if (d > 0)
			{
				if ((sc.y - (d * 1)) >= 0)
				{
					sc.y -= d * 1;
				}
				else
				{
					sc.y = 0;
				}
				
				if (!sc.willTrigger(Event.ENTER_FRAME)) sc.addEventListener(Event.ENTER_FRAME, scrollContent, false, 0, true);
			}
			else
			{
				if (((sc.y + sc.height) + (Math.abs(d) * 1)) <= h)
				{
					sc.y += Math.abs(d) * 1;
				}
				else
				{
					sc.y = h - sc.height;
				}
				if (!sc.willTrigger(Event.ENTER_FRAME)) sc.addEventListener(Event.ENTER_FRAME, scrollContent, false, 0, true);
			}
		}
		
		//======================================================================================================================
		// DISPLAY OBJECTS
		//======================================================================================================================
		/**
		 *Creates Content Mask 
		 * 
		 */
		private function createContentMask():void
		{
			contentMask.graphics.clear();
			contentMask.graphics.beginFill(Colors.cRed);
			contentMask.graphics.drawRoundRectComplex(0,0,w,h,0,0,0,0);
			contentMask.graphics.endFill();
			content.mask = contentMask;
			addChild(contentMask);
		}
		
		/**
		 *Creates Scroller Background 
		 * 
		 */
		private function createScrollerBg():void
		{
			scBg.graphics.clear();
			scBg.graphics.beginFill(scBgColor);
			scBg.graphics.drawRoundRectComplex(0,0,scWidth,scBgH,roundness[0],roundness[1],roundness[2],roundness[3]);
			scBg.graphics.endFill();
			scBg.x = w + gap;
			
			
		}
		
		/**
		 *Creates Scroller 
		 * 
		 */
		private function createScroller():void
		{
			sc.graphics.clear();
			sc.graphics.beginFill(scColor);
			sc.graphics.drawRoundRectComplex(0,0,scWidth,scHeight,roundness[0],roundness[1],roundness[2],roundness[3]);
			sc.graphics.endFill();
			sc.x = scBg.x;
			sc.buttonMode = true;
			
			//this.contains(sc) == false ? addChild(sc) : void;
			
		}
	}
}