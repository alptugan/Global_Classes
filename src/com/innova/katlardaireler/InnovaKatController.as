package src.com.innova.katlardaireler
{
	import com.alptugan.valueObjects.TextFormatVO;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	import src.com.innova.InnovaMessage;
	import src.com.innova.SoundCenter;
	import src.com.innova.events.KatControllerEvent;
	
	public class InnovaKatController extends CasaSprite
	{
		[Embed(source="assets/images/katlar/0.png")]
		protected var Zero:Class;
		
		[Embed(source="assets/images/katlar/1.png")]
		protected var One:Class;
		
		[Embed(source="assets/images/katlar/2.png")]
		protected var Two:Class;
		
		[Embed(source="assets/images/katlar/3.png")]
		protected var Three:Class;
		
		[Embed(source="assets/images/katlar/4.png")]
		protected var Four:Class;
		
		[Embed(source="assets/images/katlar/5.png")]
		protected var Five:Class;
		
		[Embed(source="assets/images/katlar/6.png")]
		protected var Six:Class;
		
		[Embed(source="assets/images/katlar/7.png")]
		protected var Seven:Class;
		
		[Embed(source="assets/images/katlar/8.png")]
		protected var Eigth:Class;
		
		[Embed(source="assets/images/katlar/9.png")]
		protected var Nine:Class;
		
		[Embed(source="assets/images/katlar/temizle.png")]
		protected var Temizle:Class;
		
		[Embed(source="assets/images/katlar/devam.png")]
		protected var Devam:Class;
		
		[Embed(source="assets/images/katlar/semin.png")]
		protected var ZeminClass:Class;
		
		private var Zemin:CasaSprite;
		
		
		
		private var k0:CasaSprite;
		private var k1:CasaSprite;
		private var k2:CasaSprite;
		private var k3:CasaSprite;
		private var k4:CasaSprite;
		private var k5:CasaSprite;
		private var k6:CasaSprite;
		private var k7:CasaSprite;
		private var k8:CasaSprite;
		private var k9:CasaSprite;
		private var ktemizle:CasaSprite;
		private var kdevam:CasaSprite;
		private var message:InnovaMessage;
		private var holder:CasaSprite;
		private var arr:Array = [];
		private var isClean:Boolean;

		private var toplam:String;

		private var hata:String;
		
		private var hataFmt:Vector.<TextFormatVO> = new Vector.<TextFormatVO>;
		private var targetObj:Object;

		private var a:int;

		private var b:int;

		private var ab:int;
		
		private var isZemin:Boolean = false;
		public function InnovaKatController()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			hataFmt[0] = new TextFormatVO();
			hataFmt[0].size = 150;
			hataFmt[0].font = "bold";
			
			hata = Globals.Style.messages[0].kathata[0];
			
			message = new InnovaMessage(Globals.Style.messages[0].kat[0],true);
			addChild(message);
			
			holder = new CasaSprite();
			addChild(holder);
			
			holder.y = message.height + 16;
			
			k7 = new CasaSprite();
			k7.name = "7";
			holder.addChild(k7);
			k7.addChild(new Seven() as Bitmap);
			arr.push(k7);
			
			k8 = new CasaSprite();
			k8.name = "8";
			holder.addChild(k8);
			k8.addChild(new Eigth() as Bitmap);
			arr.push(k8);
			
			k9 = new CasaSprite();
			k9.name = "9";
			holder.addChild(k9);
			k9.addChild(new Nine() as Bitmap);
			arr.push(k9);
			
			k4 = new CasaSprite();
			k4.name = "4";
			holder.addChild(k4);
			k4.addChild(new Four() as Bitmap);
			arr.push(k4);
			
			k5 = new CasaSprite();
			k5.name = "5";
			holder.addChild(k5);
			k5.addChild(new Five() as Bitmap);
			arr.push(k5);
			
			k6 = new CasaSprite();
			k6.name = "6";
			holder.addChild(k6);
			k6.addChild(new Six() as Bitmap);
			arr.push(k6);
			
			k1 = new CasaSprite();
			k1.name = "1";
			holder.addChild(k1);
			k1.addChild(new One() as Bitmap);
			arr.push(k1);
			
			k2 = new CasaSprite();
			k2.name = "2";
			holder.addChild(k2);
			k2.addChild(new Two() as Bitmap);
			arr.push(k2);
			
			k3 = new CasaSprite();
			k3.name = "3";
			holder.addChild(k3);
			k3.addChild(new Three() as Bitmap);
			arr.push(k3);
			
			k0 = new CasaSprite();
			k0.name = "0";
			holder.addChild(k0);
			k0.addChild(new Zero() as Bitmap);
			arr.push(k0);
			
			Zemin = new CasaSprite();
			Zemin.name = "zemin";
			holder.addChild(Zemin);
			Zemin.addChild(new ZeminClass() as Bitmap);
			arr.push(Zemin);
			
			ktemizle = new CasaSprite();
			ktemizle.name = "temizle";
			holder.addChild(ktemizle);
			ktemizle.addChild(new Temizle() as Bitmap);
			arr.push(ktemizle);
			
			kdevam = new CasaSprite();
			kdevam.visible = false;
			kdevam.alpha   = 0;
			kdevam.name = "devam";
			holder.addChild(kdevam);
			kdevam.addChild(new Devam() as Bitmap);
			
			
			
			kdevam.x = 22;
			kdevam.y = 475;
			
			holder.buttonMode = true;
			holder.addEventListener(MouseEvent.MOUSE_DOWN, onClickKat);
			this.addEventListener(MouseEvent.MOUSE_UP,onClickNavUp);
			generateBoard(0,0,3,3,20,10);
		}
	
		
		protected function onClickKat(e:MouseEvent):void
		{
			// Play sound Whenever user clicks..
			SoundCenter.play();
			switch(e.target.name)
			{
				case "devam":
				{
					
					
					if(int(message.tf._tf.text) < 32 && int(message.tf._tf.text) > 0 && isZemin==false)
					{
						ExternalInterface.call("onClickKat",int(message.getMessage()));
						var evt:KatControllerEvent = new KatControllerEvent(KatControllerEvent.DEVAM_CLICK,message.getMessage());
						dispatchEvent(evt);
						
					}else{
						/*message.tf.setDefaultTextFormat();
						message.setMessage(hata,"");
						isClean = false;*/
					}
					
					if(isZemin)
					{
						ExternalInterface.call("onClickKat",0);
						var evt2:KatControllerEvent = new KatControllerEvent(KatControllerEvent.DEVAM_CLICK,String(0));
						dispatchEvent(evt2);
						isZemin = false;
					}
					
					break;
				}
					
				case "temizle":
				{
					message.tf.setDefaultTextFormat();
					cleanMessage();
					TweenMax.to(kdevam,0.5,{autoAlpha:0,ease:Expo.easeOut});
					break;
				}
					
				case "zemin":
				{
					message.tf.setDefaultTextFormat();
					message.setMessage('ZEMİN KAT',"");
					TweenMax.to(kdevam,0.5,{autoAlpha:1,ease:Expo.easeOut});
					isClean = false;
					isZemin = true;
					break;
				}
					
				default:
				{
					
					if(isClean)
					{	
						message.setMessage(e.target.name,"append");
						
						a = int(message.tf._tf.text.charAt(0));
						b = int(message.tf._tf.text.charAt(1));
						ab =  int(message.tf._tf.text);
						
						if(ab > 32 || ab < 1)
						{
							TweenMax.to(kdevam,0.5,{autoAlpha:0,ease:Expo.easeOut});
							message.tf.setDefaultTextFormat();
							message.setMessage(hata,"");
						}
						else if(a == 3 && b > 1)
						{
							TweenMax.to(kdevam,0.5,{autoAlpha:0,ease:Expo.easeOut});
							message.tf.setDefaultTextFormat();
							message.setMessage(hata,"");
							
						}else{
							TweenMax.to(kdevam,0.5,{autoAlpha:1,ease:Expo.easeOut});
						}
						
						
							
						isClean = false;
					}else{
						
						//message.tf.setDefaultTextFormat();
						message.setTextFormat(hataFmt);
						message.setMessage(e.target.name,"");
						
						a = int(message.tf._tf.text.charAt(0));
						
						if(a < 1)
						{
							TweenMax.to(kdevam,0.5,{autoAlpha:0,ease:Expo.easeOut});
							message.tf.setDefaultTextFormat();
							message.setMessage(hata,"");
							isClean = false;
						}else{
							isClean = true;
							TweenMax.to(kdevam,0.5,{autoAlpha:1,ease:Expo.easeOut});
							isZemin = false;
						}
							
						
						
						/*if(int(e.target.name) > 3)
						{
							message.setMessage(hata,"");
						}*/
						
							
					}
					
					break;
				}
			}
			
			
			targetObj = e.target;
			// Kullanıcı klikleme efekti
			TweenMax.to(e.target,0.1,{tint:0xffffff});
		}
		
		protected function onClickNavUp(e:MouseEvent):void
		{
			if(targetObj)
				TweenMax.to(targetObj,0.5,{tint:null});
		}
		
		private function generateBoard(startX:Number,startY:Number,totalRows:Number,totalCols:Number,hGap:int,vGap:int):void {
			
			for (var i:uint = 0; i < arr.length; i++)
			{
				arr[i].x = startX + (hGap + arr[i].width) * ( i % totalCols );
				arr[i].y = startY + (vGap + arr[i].height) * Math.floor( i / totalCols );
			}
		}
		
		public function cleanMessage():void
		{
			message.setMessage(Globals.Style.messages[0].kat[0],"");
			isClean = false;
		}
	}
}