package src.com.innova
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.media.Mp3BgPlayer;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class InnovaSoundPlayer extends CasaSprite
	{
		private var icon:DisplayObject;
		private var bg:DisplayObject;
		private var active:DisplayObject;
		private var tracker:DisplayObject;
		
		private var tholder:CasaSprite;
		
		private var dragging:Boolean;
		private var startX:Number;
		private var bounds:Rectangle;
		private var _src:String;

		private var player:Mp3BgPlayer;

		private var vol:Number;
		private var MainVolume:Number;
		
		
		public function InnovaSoundPlayer(source:String,icon:DisplayObject,bg:DisplayObject,active:DisplayObject,tracker:DisplayObject,volume:Number)
		{
			this.icon    = icon;
			this.bg      = bg;
			this.active  = active;
			this.tracker = tracker;
			this._src    = source;
			this.MainVolume = volume;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			player = new Mp3BgPlayer(_src,true,false);
			addChild(player);
			
			addChild(this.icon);
			addChild(this.bg);
			addChild(this.active);
			
			// Tracker
			tholder = new CasaSprite();
			var trackerRect:RectShape = new RectShape(new Rectangle(-40,-40,100,100),new FillStyle(0,0.));
			
			addChild(tholder);
			tholder.addChild(trackerRect);
			tholder.addChild(this.tracker);
			
			startX = bg.x;
			
			tholder.x = startX + bg.width*MainVolume;
			//tholder.x = startX;
			
			
			bounds = new Rectangle(startX,0,this.bg.width-this.tracker.width+10);
			
			tholder.addEventListener(MouseEvent.MOUSE_DOWN, dragTracker);
			stage.addEventListener(MouseEvent.MOUSE_UP, ReleaseTracker);
			
			player.addEventListener("loaded", onSoundLoaded);
			
			adjustVolume(null);
		}
		
		protected function onSoundLoaded(e:Event):void
		{
			player.removeEventListener("loaded", onSoundLoaded);
			dispatchEvent(e);
		}	
	
		/**
		 * START DRAGGING 
		 * @param e
		 * 
		 */
		protected function dragTracker(e:MouseEvent):void
		{
			tholder.addEventListener(Event.ENTER_FRAME, adjustVolume);
			
			tholder.startDrag(false,bounds);
			dragging = true;
			
		}
		
		protected function adjustVolume(event:Event):void
		{
			vol = (tholder.x + startX*(-1)) / bg.width;
			
			// Set width of the active bar
			active.width   = (tholder.x + 4 +startX*(-1));
			
			player.volume = vol;
			SoundCenter.volume = vol;
			// Set sound volume
			if(Cache.getInstance().previousMenu == "projefilm")
				ExternalInterface.call('setVolume',vol);
			
			Cache.getInstance().volume = vol;
		}
		
		protected function ReleaseTracker(e:MouseEvent):void
		{
			if(dragging)
			{
				tholder.stopDrag();
				dragging = false;
				
				tholder.removeEventListener(Event.ENTER_FRAME, adjustVolume);
				//active.width   = (tholder.x + 4 +startX*(-1));
				vol = (tholder.x + startX*(-1)) / bg.width;
				// Set width of the active bar
				active.width   = (tholder.x + 4 +startX*(-1));
				player.volume = vol;
				SoundCenter.volume = vol;
				// Set sound volume
				if(Cache.getInstance().previousMenu == "projefilm")
					ExternalInterface.call('setVolume',vol);
			}
			
		}
		
		public function stop():void
		{
			player.stop();
		}
		
	}
}