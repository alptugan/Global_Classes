package com.alptugan.Template
{
	import alptugan.Display.CreateMask;
	import alptugan.Events.MediaPlayerEvent;
	import alptugan.ValueObjects.ListManagerVO;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import com.kusina.ABasicTextArea;
	import com.ATextFieldCss;
	import com.AudioPlayer.Mp3_Player_v3;
	import com.kusina.FullScreenScrollBar;
	import com.kusina.Globals;
	import com.greensock.TweenMax;
	import com.greensock.easing.FastEase;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import org.libspark.ui.SWFWheel;
	
	FastEase.activate([Strong]);
	
	public class ListManagerPlayList extends Sprite
	{
		public var Source:XML, w:int, h:int, Id:int = -1, mOverColor:uint;
		public var VO:Vector.<ListManagerVO>;
		public var Items  : Vector.<Sprite>;
		public var Titles : Vector.<Sprite>;
		public var Thumbs : Vector.<Bitmap>;
		public var Holder : Sprite;
		public var Mask   : Shape;
		public var ScrollBar : FullScreenScrollBar;
		private var l:int,tl:int;
		private var BLoader : BulkLoader  = new BulkLoader("kalk");
		public function ListManagerPlayList(_Source:XML, _w:int, _h:int, _mOverColor:uint)
		{
			super();
			mOverColor = _mOverColor;
			Source = _Source;
			w      = _w;
			h      = _h;
			addEvent(this,Event.ADDED_TO_STAGE, init);
			addEvent(this,Event.REMOVED_FROM_STAGE, onRemoved);
		}
		/**Parse XML Data into a Vector of ListManagerVOs**/
		private function init(e:Event):void
		{
			removeEvent(this,Event.ADDED_TO_STAGE, init);
			
			var i:int;
			l = Source.item.length();
			tl= Source.item.thumb.length();
			VO = new Vector.<ListManagerVO>(l,true);
			
			/**Create Mask for Holder**/
			Mask = CreateMask.Create(0,0,w,h);
			addChild(Mask);
			
			/**Holder Sprite for Items on the display list**/
			Holder = new Sprite();
			addChild(Holder);
			Holder.mask = Mask;
			Items  = new Vector.<Sprite>(l,true);
			Titles = new Vector.<Sprite>(l,true);
			Source.item.thumb !=  undefined  ? Thumbs = new Vector.<Bitmap>(tl,true) : void;
			
			var TotalHeight:int = 0;
			var GapFactor  :int = 5;
			
			for(i; i < l; ++i)
			{
				/**Parse XML to VAriables**/
				VO[i]          = new ListManagerVO();
				VO[i].share    = Source.item[i].share;
				VO[i].source   = Source.item[i].source;
				VO[i].subtitle = Source.item[i].subtitle;
				VO[i].title    = Source.item[i].title;
				Source.item[i].thumb !=  undefined  ? VO[i].thumb = Source.item[i].thumb : void;
				/**Write variables to display list**/
				Titles[i]       = new ATextFieldCss(VO[i].title,"uw","content",0,false);
				Items[i]        = new ATextFieldCss(VO[i].subtitle,"uw","submenu",0,false);
				Titles[i].alpha = 0;
				Titles[i].name  = String(i);
				/**Add Interactive Listeners**/
				addEvent(Titles[i],MouseEvent.CLICK, onClick);
				addEvent(Titles[i],MouseEvent.MOUSE_OVER, onOver);
				addEvent(Titles[i],MouseEvent.MOUSE_OUT, onOut);
				/**Add Holder to display list**/
				Holder.addChild(Titles[i]);
				
				/**Positioning Sub Titles**/
				Items[i].y = Titles[i].height - 8;
				Titles[i].addChild(Items[i]);
				
				/**If there are thumbnails, add them to display list**/
				if(Source.item[i].thumb !=  undefined )
				{
					AddThumbnails(i) ;
					Titles[i].x = 50;
				}else{
					Titles[i].x = 5;
				}
				
				Titles[i].y = Titles[i].height*0.1 + TotalHeight;
				
				/**Add Mouse Over Rectangles**/
				var s:Shape = Rect(-5,-Titles[i].height*0.1-1,Titles[i].height + 8);
				s.alpha     = 0;
				Titles[i].addChildAt(s,0);
				TotalHeight += Titles[i].height + GapFactor;
				
				/**If there are thumbnails wait for them to be loaded, else show list variables with tween**/
				Source.item[i].thumb ==  undefined  ? TweenMax.to(Titles[i],0.3,{alpha:1,delay:i*0.03,ease:Strong.easeOut,onComplete:TweenDone,onCompleteParams:[i]}) : void;
			}
			
			
		}
		
		/**When All the items are added to stage check for stage height and if necessary, add scroller **/
		private function TweenDone(i:int):void
		{
			if(i == l-1)
			{
				if(Holder.height  > h)
				{
					SWFWheel.initialize(stage);
					ScrollBar = new FullScreenScrollBar(Holder, h,w,Globals.BlueLight, Globals.BlueLight, Globals.Blue, 0xffffff, 1, 15, 4, false);
					ScrollBar.x = Mask.width;
					addChild(ScrollBar);
					Mask.height = h; 
				}
			}
			
		}
		
		/**Add Thumbnails**/
		private function AddThumbnails(i:int):void
		{
			if( i < tl - 1)
			{
				BLoader.add(VO[i].thumb != "" ? VO[i].thumb : "assets/video.jpg",{id:String(i)});
			}else{
				BLoader.add(VO[i].thumb != "" ? VO[i].thumb : "assets/video.jpg",{id:String(i)});
				BLoader.addEventListener(BulkLoader.COMPLETE, onThumbsComplete,false,0,true);
				BLoader.start();
				
			}
		}
		
		private function onThumbsComplete(e:Event):void
		{
			
			for(var i:int = 0 ; i < tl; ++i)
			{
				Thumbs[i] = BLoader.getBitmap(String(i));
				Thumbs[i].y = (-3 );
				Thumbs[i].x = -50;
				Thumbs[i].width = 43;
				Thumbs[i].height = 35;
				Titles[i].addChild(Thumbs[i]);
				Thumbs[i].alpha = 0.3;
				TweenMax.to(Titles[i],0.3,{alpha:1,delay:i*0.01,ease:Strong.easeOut,onComplete:TweenDone,onCompleteParams:[i]});
			}
			BLoader.removeEventListener(BulkLoader.COMPLETE, onThumbsComplete);
		}
		
		/**Add Mouse Events when Tweens completed**/
		private function onClick(e:MouseEvent):void
		{
			if(Id != -1)
			{
				TweenMax.to(Titles[int(Id)].getChildAt(0),0.5,{alpha:0,ease:Strong.easeOut});
				Source.item[int(Id)].thumb !=  undefined ? TweenMax.to(Thumbs[int(Id)],0.5,{alpha:0.3,ease:Strong.easeOut}) : void;
				addEvent(Titles[Id],MouseEvent.CLICK, onClick);
				addEvent(Titles[Id],MouseEvent.MOUSE_OVER, onOver);
				addEvent(Titles[Id],MouseEvent.MOUSE_OUT, onOut);
			}
			
			Id = int(e.target.name);
			
			removeEvent(Titles[Id],MouseEvent.CLICK, onClick);
			removeEvent(Titles[Id],MouseEvent.MOUSE_OVER, onOver);
			removeEvent(Titles[Id],MouseEvent.MOUSE_OUT, onOut);
			//Dispatch When User Clicks an item on the playlist
			var mEvt : MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.AUDIO_CHANGED);
			mEvt.Source    = VO[Id].source;
			mEvt.Title     = VO[Id].title;
			mEvt.SubTitle  = VO[Id].subtitle;
			dispatchEvent(mEvt);
		}
		public function onResize(W:int,H:int):void
		{
			Mask.height = H; 
			
		}
		private function onOver(e:MouseEvent):void
		{
			TweenMax.to(Titles[int(e.target.name)].getChildAt(0),0.5,{alpha:1,ease:Strong.easeOut});
			Source.item[int(e.target.name)].thumb !=  undefined ? TweenMax.to(Thumbs[int(e.target.name)],0.5,{alpha:1,ease:Strong.easeOut}) : void;
			
		}
		
		private function onOut(e:MouseEvent):void
		{
			TweenMax.to(Titles[int(e.target.name)].getChildAt(0),0.5,{alpha:0,ease:Strong.easeIn});
			Source.item[int(e.target.name)].thumb !=  undefined ? TweenMax.to(Thumbs[int(e.target.name)],0.5,{alpha:0.3,ease:Strong.easeOut}) : void;
		}
		
		/**Blue Rectangle for mouse Over Events **/
		private function Rect(_x:int,_y:int, sh:int):Shape
		{
			var s:Shape = new Shape();
			with(s.graphics)
			{
				beginFill(mOverColor, 0.3);
				drawRect(_x,_y,w,sh);
				endFill();
			}
			
			return s;
		}		
		private function onRemoved(e:Event):void
		{
			removeEvent(this,Event.REMOVED_FROM_STAGE, onRemoved);
			if(BLoader != null)
			{
				BLoader.clear();
				BLoader.removeAll();
				BLoader = null;
				VO = null;
			}
			
			for(var i:int; i < Source.item.length(); ++i)
			{
				removeEvent(Titles[i],MouseEvent.CLICK, onClick);
				removeEvent(Titles[i],MouseEvent.MOUSE_OVER, onOver);
				removeEvent(Titles[i],MouseEvent.MOUSE_OUT, onOut);
				TweenMax.killTweensOf(Titles[i]);
				Holder.removeChild(Titles[i]);
				Titles[i].removeChild(Items[i]);
				
				Items[i]  = null;
				Titles[i] = null;
				
			}
			Items  = null;
			Titles = null;
			if(Thumbs != null)
				Thumbs = null;
			removeChild(Holder);
			Holder = null;
		}
		
		private function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, true);
		}
		
		private function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
		
	}
}