package com.alptugan.air.photobooth
{
	import com.adobe.images.JPGEncoder;
	import com.alptugan.drawing.Navigation.ShareButton;
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.preloader.PreloaderMacStyle;
	import com.alptugan.text.ATextSingleLine;
	import com.facebook.graph.FacebookDesktop;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
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
	import flash.utils.Timer;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.filikatasarim.Counter;
	
	public class Core extends CasaSprite
	{
		[Embed(source="com/alptugan/assets/font/HelveticaNeueLTPro-Bd.otf", embedAsCFF="false", fontName="roman", mimeType="application/x-font", unicodeRange = "U+0000-U+007e,U+00c7,U+00d6,U+00dc,U+00e7,U+00f6,U+00fc,U+0101-U+011f,U+0103-U+0131,U+015e-U+015f")]
		public var Roman:Class;
		
		// counter
		private var txt:ATextSingleLine;
		private var infoTxt:ATextSingleLine;
		
		private var video:Video;
		private var camera:Camera;
		
		// Snapshot image
		private var imgBD:BitmapData;
		private var imgBitmap:Bitmap;
		
		// JPG Encoder
		private var imgBA:ByteArray;
		private var jpgEncoder:JPGEncoder;
		
		private var imagePath:String;
		private var phpPath:String;
		
		private var sendHeader:URLRequestHeader;
		private var sendReq:URLRequest;
		private var sendLoader:URLLoader;

		private var varLoader:URLLoader;

		//Facebook
		private var appID:String = "134321966741814";//'400437036681583';//
		private var accToken:String = "0c74e980f85cc2b7a60cc2e212f5f472";//'b332b6219ea0240ae33bf0cdcf64d322';//
		
		//Background
		private var bg:RectShape;
		
		//UI
		[Embed(source="assets/fbshare.png")]
		protected var fbshareclass:Class;
		private var shareBtn:CasaSprite;
		
		[Embed(source="assets/snapshot.png")]
		protected var snapshotclass:Class;
		private var snapBtn:CasaSprite;
		
		[Embed(source="assets/bg.png")]
		protected var frameclass:Class;
		private var frame:Bitmap;
		
		
		[Embed(source="assets/retake.png")]
		protected var retakeclass:Class;
		private var retake:Bitmap;
		private var retakeBtn:CasaSprite;

		private var myTimer:Timer;
		private var time:int = 3;
		
		private var whiteRect:RectShape;
		
		private var busy:PreloaderMacStyle;
		
		public function Core()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onAddedtoStage);
		}
		
		protected function onAddedtoStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedtoStage);
			trace('Core Class is added to stage');
			
			setupBg();
			setupUI();
			setupTimer();
			setupCamera(70,300,620,620);
			setupApplication();
			setupFacebookConnection();
			setupCounterTxt();
			setupInfoTxt();
			
			whiteRect = new RectShape(new Rectangle(80,300,565,565),new FillStyle(0xffffff));
			whiteRect.alpha = 0;
			whiteRect.visible = false;
			//addChild(whiteRect);
			
			// Busy Icon
			busy = new PreloaderMacStyle(12,14,false,6,18,0xffffff);
			addChild(busy);
			
			onResize(null);
			busy.alpha = 0;
			
			stage.addEventListener(Event.RESIZE, onResize);
			
		}
		
		
		
		private function setupInfoTxt():void
		{
			infoTxt = new ATextSingleLine('Fotoğrafınız facebook.com/SerraSeramik adresine yüklenmektedir.','roman',0xffffff,12,true,true,false);
			infoTxt.alpha = 0;
			infoTxt.visible = false;
			addChild(infoTxt);
			onResize(null);
		}
		
		protected function onResize(e:Event):void
		{
			if(infoTxt)
			{
				infoTxt.x = (stage.stageWidth - infoTxt.width) >> 1;
				infoTxt.y = (stage.stageHeight - infoTxt.height) * 0.5 - 100;
			}
			
			if(busy)
			{
				busy.x = (stage.stageWidth - busy.width >> 1) + 30;
				busy.y = stage.stageHeight - busy.height >> 1;
			}
			
			if(txt)
			{
				txt.x = (stage.stageWidth - txt.width) >> 1;
				txt.y = (stage.stageHeight - txt.height) * 0.5 ;
			}
			
			if(frame)
			{
				frame.width = stage.stageWidth;
				frame.height = stage.stageHeight;
			}
			
			if(snapBtn)
			{
				snapBtn.x = (stage.stageWidth - snapBtn.width) >> 1;
				snapBtn.y = stage.stageHeight - snapBtn.height - 100;
			}
			
			if(shareBtn)
			{
				shareBtn.x = (stage.stageWidth - shareBtn.width) >> 1;
				shareBtn.y = stage.stageHeight - shareBtn.height - 100;
			}
			
			if(retakeBtn)
			{
				retakeBtn.x = shareBtn.x;
				retakeBtn.y = stage.stageHeight - shareBtn.height - 100 - shareBtn.height -4;
			}
		}
		
		private function setupCounterTxt():void
		{
			txt = new ATextSingleLine(String(time),"roman",0xffffff,160,false,false,false,"left");
			txt.alpha = 0;
			
			addChild(txt);
			onResize(null);
			
			txt.visible = false;
		}
		
		private function setupTimer():void
		{
			myTimer = new Timer(1000);
			myTimer.addEventListener(TimerEvent.TIMER, countTime);
		}
		
		protected function countTime(e:TimerEvent):void
		{
			if(time == 0)
			{
				myTimer.stop();
				myTimer.reset();
				TweenMax.to(txt,0.3,{autoAlpha:0,ease:Expo.easeOut,onComplete:function():void{
					TweenMax.to(whiteRect,0.1,{autoAlpha:0.8,ease:Back.easeInOut,onComplete:function():void{
						whiteRect.alpha = 0;
						whiteRect.visible = false;
						nowCreateSnapShot();
						time = 3;
					}});
					
				}});
			}else{
				time--;
			}
			txt.SetText(String(time));
		}
		
		private function setupBg():void
		{
			bg = new RectShape(new Rectangle(0,0,stage.stageWidth,stage.stageHeight),new FillStyle(0x383838));
			addChild(bg);	
			
			frame = new frameclass();
			frame.smoothing = true;
			addChild(frame);
			//frame.alpha = 0.5;
			onResize(null);
		}
		
		private function setupUI():void
		{
			shareBtn = new CasaSprite();
			shareBtn.visible = false;
			shareBtn.alpha = 0;
			addChild(shareBtn);
			var shareBmp : Bitmap = new fbshareclass() as Bitmap;
			shareBmp.smoothing = true;
			shareBtn.addChild(shareBmp);
			
			retakeBtn = new CasaSprite();
			retakeBtn.visible = false;
			retakeBtn.alpha = 0;
			addChild(retakeBtn);
			var retakeBmp : Bitmap = new retakeclass() as Bitmap;
			retakeBmp.smoothing = true;
			retakeBtn.addChild(retakeBmp);
			
			snapBtn = new CasaSprite();
			addChild(snapBtn);
			var snapBmp : Bitmap = new snapshotclass() as Bitmap;
			snapBmp.smoothing = true;
			snapBtn.addChild(snapBmp);
			
			snapBtn.scaleX = snapBtn.scaleY = shareBtn.scaleX = shareBtn.scaleY = retakeBtn.scaleX=retakeBtn.scaleY= 0.4;
			onResize(null);
		}
		
		private function setupFacebookConnection():void
		{
			FacebookDesktop.init(appID,handleLogin,accToken);
		}
		
		private function doLogin():void 
		{
			FacebookDesktop.login(handleLogin, ["manage_pages","publish_stream",'offline_access']);
		}			
		
		private function handleLogin(session:Object, fail:Object):void {
			if (session) {
				trace("loggedin");
				var user:Object = FacebookDesktop.getSession().user; 
				trace(user.first_name + " " + user.last_name); 
				//add listener to logout btn 
			}else{
				trace("do login");
				doLogin();
			}
		}
		
		private function postToFacebook():void 
		{ 
			//trace('OLD ACCES TOKEN: '+ FacebookDesktop.getSession().accessToken);
			//FacebookDesktop.getSession().accessToken = 'AAAFsMgNTiW8BAKyUx40mBNXLJS72hsnnRh27otS5zuyCvyNRpfVNm432OYvrk7jm8mKvBZAGo1ZAmJ1ojIGoRf3gjimhW6HZB20jgYvhwZDZD';
			//trace(FacebookDesktop.getSession().accessToken);
			//
			var bmd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight); 
			bmd.draw(this); 
			var img:* = bmd; 
			//var values:Object = {message:'Testa bildes', fileName:'haranao.jpg',image:img,picture:imagePath,link:imagePath,access_token:'400437036681583|hwNy95etIpi6A_d9E34qMaSva0M'}; 
			//var values:Object = {message:'Testa bildes',file:"@/"+imagePath,access_token:FacebookDesktop.getSession().accessToken}; 
			var values:Object = {message:'Unicera’da Serra Seramik ile Mükemmellik. Daima',
				caption:'8. Hall 802 ve 803 nol’lu standlarda sizleri de bekliyoruz',
				picture:imagePath,link:imagePath,name:'Fotoğrafınızı görmek için buraya tıklayın'/*,access_token:'AAAFsMgNTiW8BAKyUx40mBNXLJS72hsnnRh27otS5zuyCvyNRpfVNm432OYvrk7jm8mKvBZAGo1ZAmJ1ojIGoRf3gjimhW6HZB20jgYvhwZDZD'*/};
			FacebookDesktop.api('/SerraSeramik/feed', handleUploadComplete, values,'POST'); 
			
		} 
		
		private function handleUploadComplete(response:Object, fail:Object):void 
		{ 
			if (response) { 
				trace("upload done"); 
				removeSnapshot(null);
				TweenMax.to(snapBtn,0.5,{autoAlpha:1});
				busy.alpha  = 0;
				infoTxt.alpha = 0;
				infoTxt.visible = false;
			}else { 
				trace("oops... error"); 
				removeSnapshot(null);
				TweenMax.to(snapBtn,0.5,{autoAlpha:1});
				busy.alpha  = 0;
				infoTxt.alpha = 0;
				infoTxt.visible = false;
			} 
		} 
	
		
		private function setupApplication():void
		{
			phpPath = "http://www.filikatasarim.com/serratest/example.php";
			jpgEncoder = new JPGEncoder(90);
			
			sendHeader = new URLRequestHeader("Content-type","application/octet-stream");
			sendReq = new URLRequest(phpPath);
			sendReq.requestHeaders.push(sendHeader);
			sendReq.method = URLRequestMethod.POST;
			
			sendLoader = new URLLoader();
			sendLoader.addEventListener(Event.COMPLETE,imageSentHandler);
			sendLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			// Add snapshotbutton
			snapBtn.addEventListener(MouseEvent.CLICK, createSnapshot);
		}		
	
		private function setupCamera(_x:int,_y:int,w:int,h:int):void {
			camera = Camera.getCamera();
			camera.addEventListener(StatusEvent.STATUS, camStatusHandler);
			camera.setMode(w,h,stage.frameRate);
			
			video = new Video(w,h);
			video.attachCamera(camera);
			video.scaleX=-1;
			addChildAt(video,1);
			
			video.x = _x+w;
			video.y = _y;
			
		}
		
		private function camStatusHandler(event:StatusEvent):void {
			// Camera.Muted or Camera.Unmuted -> User's security
			trace(event.code);
		}
		
		private function createSnapshot(event:MouseEvent):void 
		{
			snapBtn.removeEventListener(MouseEvent.CLICK, createSnapshot);
			TweenMax.to(snapBtn, 0.5, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30, remove:true}, ease:Expo.easeOut,onComplete:hideSnapBtn});
		}
		
		private function nowCreateSnapShot():void
		{
			imgBD = new BitmapData(stage.stageWidth, stage.stageHeight);
			imgBD.draw(this);
			
			busy.alpha  = 1;
			
			
			
			imgBitmap=new Bitmap(imgBD);
			/*imgBitmap.x = video.x;
			imgBitmap.y = video.y;*/
			addChildAt(imgBitmap,3);
			
			trace('snap button is clicked');
			
			// Send image to server
			jpgEncoder = new JPGEncoder(90);
						
			// Click onto image to remove it from stage
			retakeBtn.addEventListener(MouseEvent.CLICK, removeSnapshot);
			
			// Show Share Button
			TweenMax.to(shareBtn,0.25,{autoAlpha:1,delay:0.3,onComplete:function():void{busy.alpha  = 0;}});
			TweenMax.to(retakeBtn,0.25,{autoAlpha:1});
			
			shareBtn.addEventListener(MouseEvent.CLICK, sendImage);
		}
		
		private function hideSnapBtn():void
		{
			TweenMax.to(snapBtn,0.25,{autoAlpha:0});
			txt.SetText(String(time));
			TweenMax.to(txt,0.3,{autoAlpha:1,ease:Expo.easeOut,onComplete:function():void{
				
				myTimer.start();
				
			}});
			
		}
		
		private function sendImage(event:MouseEvent):void {
			shareBtn.removeEventListener(MouseEvent.CLICK, sendImage);
			busy.alpha  = 1;
			
			TweenMax.to(infoTxt,0.4,{autoAlpha:1,ease:Expo.easeInOut});
			
			TweenMax.to(shareBtn, 0.3, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30, remove:true}, ease:Expo.easeOut,onComplete:function():void{
				TweenMax.to(shareBtn,0.25,{autoAlpha:0,delay:0.2,onComplete:processSnapShot});
				TweenMax.to(retakeBtn,0.25,{autoAlpha:0});
				
			}});
		}
		
		private function processSnapShot():void
		{
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
			
			
			postToFacebook();
			
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
			
			TweenMax.to(imgBitmap, 0.3,{alpha:0,ease:Expo.easeOut,onComplete:function():void{removeChild(imgBitmap);}});
			
			TweenMax.to(retakeBtn, 0.25, {glowFilter:{color:0xffff00, alpha:1, blurX:30, blurY:30, remove:true}, ease:Expo.easeOut,onComplete:function():void{
				TweenMax.to(shareBtn,0.25,{autoAlpha:0});
				TweenMax.to(retakeBtn,0.25,{autoAlpha:0});
				TweenMax.to(snapBtn,0.5,{autoAlpha:1,ease:Expo.easeOut});
				snapBtn.addEventListener(MouseEvent.CLICK, createSnapshot);
			}});
		}
	}
}