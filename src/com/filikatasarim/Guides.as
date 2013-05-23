/*
 * Guides.as - Live Color Pointer Detection Example
 * Copyright (c) 2009 Yusuke Kawasaki http://www.kawa.net/
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 */

package src.com.filikatasarim{

	import com.alptugan.events.CameraEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	import org.libspark.LivePointers.LP_Detector;
	import org.libspark.LivePointers.LP_Guide;
	
	

	
    public class Guides extends Sprite {

		private var bmLive:Bitmap;
		private var lpdetector:LP_Detector;
		private var video:Video;

		static private var captureFPS:int = 30;
		static private var captureX:int = 320;
		static private var captureY:int = 240;
		static public var displayX:int = 640;
		static public var displayY:int = 480;
		static private var workX:int = 80;
		static private var workY:int = 60;	
		
		
		
		static private var guidesH:Object = {
			/*red_gumball:	0xBF4D58,*/
			blue_gumball:	0x0033FF,
			fingercap:  	0x0066FF,
			blue3:0x0066CC,
			blue4:0x0033CC,
			blue5:0x0000CC,
			blue6:0x3300FF,
			blue7:0x3300CC
		};

		public var spPointer:Sprite;

		private var camera:Camera;
		private var _allowH:Number;
		private var _allowS:Number;
		private var _allowV:Number;
		private var _minVolume:Number;

        public function Guides ():void {

			bmLive = new Bitmap();

			var spLive:Sprite = new Sprite();
			spLive.addChild( bmLive );
			spLive.scaleX = displayX / captureX;
			spLive.scaleY = displayY / captureY;
			this.addChild( spLive );
			
            // Webcam
            camera = Camera.getCamera('0');
			camera.addEventListener(StatusEvent.STATUS, statusHandler);
			//Security.showSettings(SecurityPanel.CAMERA);
			
            if (!camera) {
                throw new Error('No camera found.');
            }
            camera.setMode(captureX, captureY, captureFPS);

            // Video
            video = new Video(captureX, captureY);
            video.attachCamera(camera);
			
			// Live Pointer
			lpdetector = new LP_Detector(workX, workY);
			lpdetector.allowH = _allowH;
			lpdetector.allowS = _allowS;//0.25;
			lpdetector.allowV = _allowV;//0.25;
			lpdetector.minVolume = _minVolume;//4;
			spPointer = lpdetector.getPreview(displayX,displayY);
			this.addChild(spPointer);

			
			// Pointer Guides
			for ( var name:String in guidesH ) {
				var rgb:uint = guidesH[name];
				var gi:LP_Guide = new LP_Guide( name );
				gi.fromRGB( rgb );
				gi.max = 2;
				lpdetector.addGuide(gi);
			}

            this.addEventListener( Event.ENTER_FRAME, this.onEnterFrame );
        }
		
		
		protected function statusHandler(e:StatusEvent):void
		{
			camera.removeEventListener(StatusEvent.STATUS, statusHandler);

			switch(e.code)
			{
				case "Camera.Muted":
					dispatchEvent(new CameraEvent(CameraEvent.CAMERA_DENIED));
					break;
				case "Camera.Unmuted":
					dispatchEvent(new CameraEvent(CameraEvent.CAMERA_ALLOWED));
					break;
			}
		}		
		
		
        private function onEnterFrame (e:Event):void {
			lpdetector.allowH = _allowH;
			lpdetector.allowS = _allowS;//0.25;
			lpdetector.allowV = _allowV;//0.25;
			lpdetector.minVolume = _minVolume;//4;
            var bmdLive:BitmapData = new BitmapData( captureX, captureY, false, 0xCCCCCC );
            bmdLive.draw( video );
			bmLive.bitmapData = bmdLive;
			lpdetector.setFrame(bmdLive);
			lpdetector.findClusters();
		}
		
		//========================================================================================================
		// GETTERS & SETTERS
		//========================================================================================================
		
		public function get minVolume():Number
		{
			return _minVolume;
		}
		
		public function set minVolume(value:Number):void
		{
			_minVolume = value;
		}
		
		public function get allowV():Number
		{
			return _allowV;
		}
		
		public function set allowV(value:Number):void
		{
			_allowV = value;
		}
		
		public function get allowS():Number
		{
			return _allowS;
		}
		
		public function set allowS(value:Number):void
		{
			_allowS = value;
		}
		
		public function get allowH():Number
		{
			return _allowH;
		}
		
		public function set allowH(value:Number):void
		{
			_allowH = value;
			
		}

	}
}
