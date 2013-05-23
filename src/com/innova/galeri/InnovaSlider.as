package src.com.innova.galeri
{
	import com.alptugan.globals.Root;
	import com.alptugan.utils.Colors;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaBitmap;
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	
	public class InnovaSlider extends Root
	{
		// scroller
		private var sc          : CasaSprite = new CasaSprite(), 
			// scroller background
			scBg        : CasaSprite = new CasaSprite(),
			
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
		private var defaultPositionY : int = 0,
			defaultPositionX         : int = 0,
			// gap between scroller and content
			gap             : int = 10, 
			// ease amount of the animation when srolling
			easeAmount      : int = 2,  
			scrollValue     : int;
		
		// Event dispatcher for Button handlers
	//private var initButton : AButtonHandlers; 
		
		// JPG EMBED
		private var JPG : Boolean;
		
		private var tracker :DisplayObject;
		private var bg:Bitmap;
		private var oteleme:Number = 10;
		
		public function InnovaSlider(content:DisplayObjectContainer, tracker:DisplayObject,bg:Bitmap,w:int,h:int,scWidth:int,scColor:uint=0x666666,scBgColor:uint=0xffffff,roundness:Array = null,bolFilters:Boolean = true,JPG:Boolean=false )
		{
			this.content = content;
			this.w = w;
			this.h = h;
			
			this.scWidth = scWidth;
			this.scColor = scColor;
			
			this.scBgColor = scBgColor;
			this.scBgH     = h;
			this.scHeight  = h;
			
			this.tracker = tracker;
			this.bg      = bg;
			
			this.JPG       = JPG;
			if(roundness == null)
			{
				this.roundness = [0,0,0,0];
			}else{
				(roundness.length == 1) ? this.roundness = [roundness[0],roundness[0],roundness[0],roundness[0]] : this.roundness = roundness;
			}
			
			this.bolFilters = bolFilters;
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);	
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);			
		}
		
		protected function onRemoved(e:Event):void
		{
			this.removeEventListeners();
		}
		
		protected function onAdded(e:Event):void
		{	
			this.removeEventsForType(Event.ADDED_TO_STAGE);
			
			//Set the slider next to content
			this.x = content.x;
			this.y = content.y;
			
		
			
			//Create scroller and scroller Background. 
			createScrollerBg();
			
			// Add jpg Scroller
			if (JPG) 
			{
				sc.addChild(tracker);
				scBg.addChild(bg);
				
				bg.height = h;
				//sc.filters = [new DropShadowFilter(1,45,0x000000,0.8,6,6,1,1)];
			}
			
			createScroller();
			
			
			//init Button Handlers and set properties
		/*	initButton = new AButtonHandlers();
			initButton.onColor = scColor;
			initButton.initHandlers(sc);
			
			*/
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
			defaultPositionY = Math.round(content.y);
			defaultPositionX = Math.round(content.x);
			adjustSize();
			
		}
		
		/**
		 * Adjust size of the sc relative to content height 
		 * 
		 */
		private function adjustSize():void
		{
			sc.y = oteleme;
			scBgH = scBg.height;
			
			//TODO @defaultposition for dynamic resizing of the content and mask
			cH = content.height + defaultPositionY;
			
			if (!JPG) 
			{
				// Set height of grabber relative to how much content
				scHeight = Math.ceil((scBgH / cH) * scBgH);
				
				// Set minimum size for grabber
				if(scHeight < 35) scHeight = 35;
				
				
				createScroller();
			}else{
				scHeight = sc.height;
			}
			
			
			// If scroller is taller than stage height, set its y position to the very bottom
			if ((sc.y + scHeight) > h) sc.y = h - scHeight;
			
			// If content height is less than stage height, set the scroller y position to 0, otherwise keep it the same
			sc.y = (cH < h) ? 0 : sc.y ;
			
			// If content height is greater than the stage height, show it, otherwise hide it
			this.visible = (cH + 8 > h);
			
			// Distance left to scroll
			scrollValue = h - scHeight;
			
			content.y = Math.round(-((cH - h) * ((sc.y - oteleme) / scrollValue)) + defaultPositionY);
			
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
			sc.startDrag(false, new Rectangle(sc.x, oteleme, 0, h - sc.height));
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
			
			p = Math.ceil( e.stageY - defaultPositionY );
			
			if ( p < sc.y + oteleme )
			{
				if ( sc.y + oteleme < sc.height )
				{
					TweenLite.to( sc,0.5,{ y: oteleme,onComplete: reset,overwrite: 1 });
				}
				else
				{
					TweenLite.to( sc,0.5,{ y: "-50",onComplete: reset });
				}
				
				if ( sc.y+ oteleme < 0 )
					sc.y = oteleme;
			}
			else
			{
				if (( sc.y + sc.height+ oteleme ) > ( h - sc.height ))
				{
					TweenLite.to( sc,0.5,{ y: h - sc.height+ oteleme,onComplete: reset,overwrite: 1 });
				}
				else
				{
					TweenLite.to( sc,0.5,{ y: "50",onComplete: reset });
				}
				
				if ( sc.y + sc.height+ oteleme > h )
					sc.y = h - sc.height+ oteleme;
			}
			
			function reset() : void
			{
				if ( sc.y + oteleme < 0 ) sc.y = oteleme;
				if ( sc.y + sc.height+ oteleme > scBg.height ) sc.y = h - sc.height+ oteleme;
			}
			
			sc.addEventListener( Event.ENTER_FRAME,scrollContent,false,0,true );
		}

		
		override protected function on_MouseLeave(e:Event):void
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
			
			ty = -((cH - h) * ((sc.y-oteleme) / scrollValue));
			dist = ty - content.y + defaultPositionY;
			moveAmount = dist / easeAmount;
			content.y += Math.round(moveAmount);
			
			if (Math.abs(content.y - ty - defaultPositionY) < 1.5)
			{
				sc.removeEventListener(Event.ENTER_FRAME, scrollContent);
				content.y = Math.round(ty) + defaultPositionY;
			}
			
		}
		
		/**
		 * MOUSE UP 
		 * @param e
		 * 
		 */
		override protected function  on_MouseUp(e:MouseEvent):void
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
		override protected function  on_MouseWheel(e:MouseEvent):void
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
					sc.y = oteleme;
				}
				
				if (!sc.willTrigger(Event.ENTER_FRAME)) sc.addEventListener(Event.ENTER_FRAME, scrollContent, false, 0, true);
			}
			else
			{
				if (((sc.y + sc.height) + (Math.abs(d) * 1)) <= h)
				{
					sc.y += Math.abs(d) * 1 + oteleme;
				}
				else
				{
					sc.y = h - sc.height + oteleme;
				}
				if (!sc.willTrigger(Event.ENTER_FRAME)) sc.addEventListener(Event.ENTER_FRAME, scrollContent, false, 0, true);
			}
		}
		
		//======================================================================================================================
		// DISPLAY OBJECTS
		//======================================================================================================================
		
		
		/**
		 *Creates Scroller Background 
		 * 
		 */
		private function createScrollerBg():void
		{
			
			if(!JPG)
			{
				scBg.graphics.clear();
				scBg.graphics.beginFill(scBgColor);
				scBg.graphics.drawRoundRectComplex(0,0,scWidth,scBgH,roundness[0],roundness[1],roundness[2],roundness[3]);
				scBg.graphics.endFill();
				scBg.x =defaultPositionX+ w + gap;
			}else{
				scBg.x =defaultPositionX+ w + gap;
				
			}
		
			
			
		}
		
		/**
		 *Creates Scroller 
		 * 
		 */
		private function createScroller():void
		{
			if(!JPG)
			{
				sc.graphics.clear();
				sc.graphics.beginFill(scColor);
				sc.graphics.drawRoundRectComplex(0,0,scWidth,scHeight,roundness[0],roundness[1],roundness[2],roundness[3]);
				sc.graphics.endFill();
				sc.x = defaultPositionX+ scBg.x;
			}else{
				sc.x =defaultPositionX+ scBg.x - (sc.width - scWidth) * 0.5 + 5;
			}
			
			sc.buttonMode = true;
			
			//this.contains(sc) == false ? addChild(sc) : void;
			
		}
	}
}