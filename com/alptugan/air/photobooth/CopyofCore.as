package com.alptugan.air.photobooth
{
	import com.adobe.images.JPGEncoder;
	import com.alptugan.drawing.Navigation.ShareButton;
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.facebook.graph.FacebookDesktop;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import org.casalib.display.CasaSprite;
	
	public class Core extends CasaSprite
	{
		private var video:Video;
		private var camera:Camera;
		
		// Snapshot image
		private var imgBD:BitmapData;
		private var imgBitmap:Bitmap;
		
		// JPG Encoder
		private var imgBA:ByteArray;
		private var jpgEncoder:JPGEncoder;
		
		private var sendBtn: CasaSprite;
		private var removeBtn:CasaSprite;
		private var takeSnapShot:CasaSprite;
		private var imagePath:String;
		private var phpPath:String;
		
		private var sendHeader:URLRequestHeader;
		private var sendReq:URLRequest;
		private var sendLoader:URLLoader;

		private var varLoader:URLLoader;

		//Facebook
		private var appID:String = "400437036681583";
		private var accToken:String = "b332b6219ea0240ae33bf0cdcf64d322";
		
		public function Core()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onAddedtoStage);
		}
		
		protected function onAddedtoStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedtoStage);
			trace('Core Class is added to stage');
			
			setupCamera(480,320);
			setupApplication();
			setupFacebookConnection();
			
		}
		
		private function setupFacebookConnection():void
		{
			
			FacebookDesktop.init(appID,handleLogin,accToken);
			
			
			
		}
		
		private function doLogin():void {
			FacebookDesktop.login(handleLogin, []);
		}			
		
		private function handleLogin(session:Object, fail:Object):void {
			if (session) {
				trace("loggedin");
				var user:Object = FacebookDesktop.getSession().user; 
				trace(user.first_name + " " + user.last_name); 
				//add listener to logout btn 
				
			}else{
				doLogin();
			}
			
			
		}
		
		private function postToFacebook():void 
		{ 
			/*
			var bmd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight); 
			bmd.draw(this); 
			var img:* = bmd; 
			var values:Object = {message:'Testa bildes', fileName:'FILE_NAME',image:img}; 
			
			FacebookDesktop.api('/QrCodeReaderCommunity/photos', handleUploadComplete, values,'POST'); 
			*/
			
			var method:String = "/QrCodeReaderCommunity/feed";
			var data:Object = {};
			
			data.message = "Your message";
			data.picture = imagePath;
			data.link = "http://www.mysite.com/link";
			data.caption = "Your caption";
			data.description = "Your description";
			data.source = "http://www.mysite.com/video.swf";//(optional) source is a video or Flash SWF
			
			
			FacebookDesktop.api(method, yourCallback, data, "POST");
			
			function yourCallback(result:Object, fail:Object):void {
				if (result) {
					trace("get it done");
				} else if (fail) {
					trace("faiil");
				}
			}
		} 
		
		private function handleUploadComplete(response:Object, fail:Object):void 
		{ 
			if (response) { 
				trace("upload done"); 
			}else { 
				trace("oops... error"); 
			} 
		} 
		
		private function sayHello():void {
			
			trace(FacebookDesktop.getSession().user.name +"\n"+ 
				FacebookDesktop.getSession().accessToken);
		}
		
		private function setupApplication():void
		{
			phpPath = "http://www.filikatasarim.com/serratest/sendphototoserver.php";
			jpgEncoder = new JPGEncoder(90);
			
			sendHeader = new URLRequestHeader("Content-type","application/octet-stream");
			sendReq = new URLRequest(phpPath);
			sendReq.requestHeaders.push(sendHeader);
			sendReq.method = URLRequestMethod.POST;
			
			sendLoader = new URLLoader();
			sendLoader.addEventListener(Event.COMPLETE,imageSentHandler);
			sendLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			// Add snapshotbutton
			takeSnapShot = new CasaSprite();
			addChild(takeSnapShot);
			takeSnapShot.addChild(new RectShape(new Rectangle(0,0,100,25),new FillStyle(0x666666)));
			
			takeSnapShot.y = 320;
			takeSnapShot.addEventListener(MouseEvent.CLICK, createSnapshot);
		}		
	
		private function setupCamera(w:int,h:int):void {
			camera = Camera.getCamera();
			camera.addEventListener(StatusEvent.STATUS, camStatusHandler);
			camera.setMode(w,h,stage.frameRate);
			
			video = new Video(w,h);
			video.attachCamera(camera);
			addChild(video);
			
			
		}
		
		private function camStatusHandler(event:StatusEvent):void {
			// Camera.Muted or Camera.Unmuted -> User's security
			trace(event.code);
		}
		
		private function createSnapshot(event:MouseEvent):void {
			
			takeSnapShot.removeEventListener(MouseEvent.CLICK, createSnapshot);
			
			imgBD = new BitmapData(video.width,video.height);
			imgBD.draw(video);
			
			imgBitmap=new Bitmap(imgBD);
			addChild(imgBitmap);
			
			trace('button is clicked');
			
			
			
			// Send image to server
			jpgEncoder = new JPGEncoder(90);
			sendBtn = new CasaSprite();
			addChild(sendBtn);
			sendBtn.addChild(new RectShape(new Rectangle(0,0,100,25),new FillStyle(0xcccccc),null));
			
			// Remove Button TO retake snapshot again
			removeBtn = new CasaSprite();
			removeBtn.addChild(new RectShape(new Rectangle(101,0,100,25),new FillStyle(0xff0000),null));
			addChild(removeBtn);
			
			// Click onto image to remove it from stage
			removeBtn.addEventListener(MouseEvent.CLICK, removeSnapshot);
			
			sendBtn.addEventListener(MouseEvent.CLICK, sendImage);
			postToFacebook();
		}
		
		private function sendImage(event:MouseEvent):void {
			imgBA = jpgEncoder.encode(imgBD);
			
			
			sendReq.data = imgBA;
			sendLoader.load(sendReq);
		}
		
		protected function ioErrorHandler(e:IOErrorEvent):void
		{
			trace(e.toString());
		}
		
		private function imageSentHandler(event:Event):void {
			var dataStr:String = event.currentTarget.data.toString();
			
			var resultVars:URLVariables = new URLVariables();
			resultVars.decode(dataStr);
			
			imagePath = "http://" + resultVars.base + "/" +resultVars.filename;
			trace(imagePath+" "+resultVars.folder);
			
			
			//postToFacebook();
			
			/*
			
			var shareHeader:URLRequestHeader = new URLRequestHeader("Content-type","application/octet-stream");
			
			var shareReq:URLRequest = new URLRequest("http://www.filikatasarim.com/test/facebook_share/process.php");
			shareReq.requestHeaders.push(shareHeader);
			shareReq.method = URLRequestMethod.POST;
			
			var myData:URLVariables = new URLVariables();
			myData.firstName = "Kirill";
			myData.lastName = "Poletaev";
			
			
			shareReq.data = myData;
			
			
			
			var shareLoader:URLLoader;
			shareLoader = new URLLoader(shareReq);
			
			shareLoader.addEventListener(Event.COMPLETE, imageShareHandler);
			shareLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorShareHandler);
			shareLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			shareLoader.load(shareReq);
			
			var variables:URLVariables = new URLVariables();
			var varSend:URLRequest = new URLRequest("http://www.filikatasarim.com/serratest/process.php");
			varLoader = new URLLoader();
			
			varSend.method = URLRequestMethod.POST;
			varSend.data = variables;
			
			variables.picturePth = "cococombo";
			varLoader.addEventListener(Event.COMPLETE, imageShareHandler);
			varLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorShareHandler);
			varLoader.load(varSend);*/
		}
		
		protected function ioErrorShareHandler(event:IOErrorEvent):void
		{
			trace(event);
		}
		
		protected function imageShareHandler(e:Event):void
		{
			
			trace(e.toString());
		}		
		
		private function removeSnapshot(event:MouseEvent):void {
			removeChild(imgBitmap);
			takeSnapShot.addEventListener(MouseEvent.CLICK, createSnapshot);
		}

		
		
	}
}