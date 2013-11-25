/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : RootAir.as
 * Release Date : Sep 27, 2013
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/
package com.alptugan.globals
{
	import com.alptugan.utils.debug.Stats;
	import com.alptugan.utils.keys.KeyCode;
	
	import flash.desktop.InteractiveIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.NotificationType;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Screen;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.ui.Key;
	
	
	public class RootAir extends CasaSprite
	{
		[Embed(source="com/alptugan/assets/icons/128x128.png")]
		public var icon128:Class;
		
		/**
		 * stage : Globals stage variable
		 * root  : Globals root (top layer) object 
		 */
		public static var
		stage : Stage,
		root  : DisplayObject;
		
		public static var	
		W:int,
		H:int,
		monitor:Stats;
		
		/**
		 * profiler : enabled with right-click on stage in order to see performance monitor hide/show
		 * rEvt     : TopLevel Class Events 
		 */		
		private var _loaderInfo  : Boolean;
		
		private var appWin:NativeWindow;
		private var screen:Screen;
		
		public function RootAir()
		{
			/*this._loaderInfo = _loaderInfo;
			
			this.addEventListener(Event.ADDED_TO_STAGE,setupRoot );*/
			
			if (this.stage){
				setupRoot();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, setupRoot);
			}
			
		}
		
		/**
		 * initialize System Performance Monitor
		 * 
		 */
		public function initDebugView(pos:String = "tl"):void
		{
			var _x:int,_y:int = 0;
			monitor = new Stats(_x,_y); 
			addChild(monitor);
			switch(pos)
			{
				case "tl":
				{
					_x=0;
					_y=0;
					break;
				}
					
				case "tr":
				{
					_x=W-monitor.width;
					_y=0;
					break;
				}
					
				case "bl":
				{
					_x=0;
					_y=H-monitor.height;
					break;
				}
					
				case "bl":
				{
					_x=W-monitor.width;
					_y=H-monitor.height;
					break;
				}
			}
			
			monitor.setPos(_x,_y);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		public function disableKeyBoard():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		public function enableKeyBoard():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == KeyCode.D)
			{
				monitor.visible = !monitor.visible;
			}
			
			else if(e.keyCode == KeyCode.F) 
			{
				if(appWin.stage.displayState == StageDisplayState.NORMAL)
					appWin.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				else
					appWin.stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		public function showMouseCursor(vis:Boolean=false):void {
			if(vis)
				Mouse.show();
			else
				Mouse.hide();
		}
		

		
		public function showDebugView(bol:Boolean=false):void
		{
			
			monitor.visible = bol;
		}
		
		public function initAppWindow(isFront:Boolean,w:int,h:int,frameRate:int = 30, quality:String = "HIGH",_x:int=0,_y:int =0):void
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = quality;
			stage.frameRate = frameRate;
			
			var winOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			winOptions.systemChrome = NativeWindowSystemChrome.NONE;
			
			
			
			appWin = stage.nativeWindow;
			//appWin = new NativeWindow(winOptions);
			appWin.addEventListener(Event.CLOSE,onClosedMainWindow);
			appWin.x = _x;
			appWin.y = _y;
			appWin.alwaysInFront = isFront;
			
			// Detect Screens
			screen = Screen.screens[0];
			
			// Set Window Screen Size
			//appWin.bounds = new Rectangle(_x,_y,w,h);
			appWin.width = w;
			appWin.height = h;
			
			
			// If we're on Windows, return. This icon wouldn't look very good in the system tray. 
			if (NativeApplication.supportsSystemTrayIcon) return;  
			
			
			// The Dynamic128IconClass referenced below is embedded. 
			var appData:BitmapData = new icon128().bitmapData;  
			var appIcon:Bitmap = new Bitmap(appData); 
			// If you do want to change the system tray icon on Windows, as well, add a 16x16 icon to the array below. 
			InteractiveIcon(NativeApplication.nativeApplication.icon).bitmaps = [appIcon];
			
			
			appWin.activate();
			
			
		}
		
		public function fullScreen():void
		{
			appWin.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public function fullScreenClose():void
		{
			appWin.stage.displayState = StageDisplayState.NORMAL;
		}
		
		protected function onClosedMainWindow(e:Event):void
		{
			
			trace("window closed");
			exitApp();
		}
		
		public function initMainClass(rootClass:Class):void
		{
			var rootObject:DisplayObject = new rootClass();
			if (rootObject == null) throw new Error("Invalid root class: " + rootClass);
			addChildAt(rootObject,0);
		}
		
		private function setupRoot(event : Event = null ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,setupRoot );
			
			Root.stage = this.stage;
			Root.root  = this;
			
			W = Root.stage.stageWidth; 
			H = Root.stage.stageHeight;
			
			Root.stage.addEventListener(Event.RESIZE, on_Resize);
			/*
			//Adjust framerate and customize right-click menu
			Config.setup( this );
			*/
			//trace numereous loaderinfo parameters if needed for debug purposes
			(_loaderInfo) ? loaderInfo.addEventListener(Event.INIT, onLoaderInfo_INIT) : void; 
		}
		
		public function setFullScreen():void {
			if (stage.displayState== "normal") {
				stage.displayState="fullScreen";
				stage.scaleMode = StageScaleMode.NO_SCALE;
			} else {
				stage.displayState="normal";
			}
		}
		
		public function alignRight(obj:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj.x = marginX + (stage.stageWidth - obj.width);
			obj.y = marginY;
		}
		
		public function alignCenterLeft(obj:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj.x = marginX ;
			obj.y = marginY + (stage.stageHeight - obj.height) >> 1;
		}
		
		public function alignCenterRight(obj:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj.x = marginX + (stage.stageWidth - obj.width);
			obj.y = marginY + (stage.stageHeight - obj.height) >> 1;
		}
		
		
		
		public function alignCenter(obj:Object,marginX:int = 0, marginY:int = 0):void
		{
			obj.x = marginX + (stage.stageWidth - obj.width) >> 1;
			obj.y = marginY + (stage.stageHeight - obj.height) >> 1;
		}
		
		public function alignBottomRight(obj:Object,marginX:int = 30, marginY:int = 30):void
		{
			obj.x = stage.stageWidth - obj.width - marginX;
			obj.y = stage.stageHeight - obj.height - marginY;
		}
		
		public function onLoaderInfo_INIT(event:Event):void
		{
			loaderInfo.removeEventListener(Event.INIT, onLoaderInfo_INIT); 
			
			//trace(Capabilities.screenResolutionX);
			trace("loaderInfo.actionScriptVersion: "+loaderInfo.actionScriptVersion);
			trace("loaderInfo.applicationDomain: "+loaderInfo.applicationDomain);
			//trace("loaderInfo.bytes: "+loaderInfo.bytes);
			trace("loaderInfo.bytesLoaded: "+loaderInfo.bytesLoaded);
			trace("loaderInfo.bytesTotal: "+loaderInfo.bytesTotal);
			trace("loaderInfo.childAllowsParent: "+loaderInfo.childAllowsParent);
			//trace("loaderInfo.constructor: "+loaderInfo.constructor);
			trace("loaderInfo.content: "+loaderInfo.content);
			trace("loaderInfo.contentType: "+loaderInfo.contentType);
			trace("loaderInfo.frameRate: "+loaderInfo.frameRate);
			trace("loaderInfo.height: "+loaderInfo.height);
			trace("loaderInfo.loader: "+loaderInfo.loader);
			trace("loaderInfo.loaderURL: "+loaderInfo.loaderURL);
			trace("loaderInfo.parameters: "+loaderInfo.parameters);
			trace("loaderInfo.parentAllowsChild: "+loaderInfo.parentAllowsChild);
			//trace("loaderInfo.prototype: "+loaderInfo.prototype);
			trace("loaderInfo.sameDomain: "+loaderInfo.sameDomain);
			trace("loaderInfo.sharedEvents: "+loaderInfo.sharedEvents);
			trace("loaderInfo.swfVersion: "+loaderInfo.swfVersion);
			trace("loaderInfo.url: "+loaderInfo.url);
			trace("loaderInfo.width: "+loaderInfo.width);
		}
		
		
		
		
		//======================================================================================================================
		// PUBLIC METHODS
		//======================================================================================================================
		
		public function exitApp():void
		{
			appWin.close();
		}
		public function minimizeApp():void
		{
			appWin.minimize();
		}
		
		
		public function initResizeHandler():void
		{
			
			
		}
		
		public function initMouseLeave():void
		{
			Root.stage.addEventListener(Event.MOUSE_LEAVE, on_MouseLeave);
		}
		
		public function initMouseWheel():void
		{
			Root.stage.addEventListener(MouseEvent.MOUSE_WHEEL, on_MouseWheel);
		}
		
		public function initMouseUp():void
		{
			Root.stage.addEventListener(MouseEvent.MOUSE_UP, on_MouseUp);
		}
		
		protected function on_MouseUp(e:MouseEvent):void{}
		protected function on_Resize(e:Event):void{ W = Root.stage.stageWidth; H = Root.stage.stageHeight; }
		protected function on_MouseLeave(e:Event):void{}
		protected function on_MouseWheel(e:MouseEvent):void{}
		
		
		public function disposeResizeHandler():void
		{
			Root.stage.removeEventListener(Event.RESIZE, on_Resize);
		}
		
		public function disposeMouseLeave():void
		{
			Root.stage.removeEventListener(Event.MOUSE_LEAVE, on_MouseLeave);
		}
		
		public function disposeMouseWheel():void
		{
			Root.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, on_MouseWheel);
		}
		
		public function disposeMouseUp():void
		{
			Root.stage.removeEventListener(MouseEvent.MOUSE_UP, on_MouseUp);
		}
	}
}