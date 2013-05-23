package com.alptugan.Mail
{
	import alptugan.Text.ATextFieldCss;
	
	import com.kusina.Globals;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	
	public class EmailForm_v2 extends Sprite
	{
		private var checker    : CheckEmail;
		private var timer      : Timer;
		private var checkAlert : Boolean=false;
		private var debug_txt  : ATextFieldCss;
		
		private var SendItems  : Array = new Array();
		private var phpLoc     : String;
		private var isAllChecked : Boolean = false;
		
		public function EmailForm_v2(_phpLoc :String)
		{
			checker= new CheckEmail();
			phpLoc = _phpLoc;
			
			if(Globals.Language == "en")
				debug_txt = new ATextFieldCss("Please fill all of the fields and click Send Button","uw","subButton");
			else
				debug_txt = new ATextFieldCss("Bütün bilgileri girdikten sonra Gönder Düğmesine basın.","uw","subButton");
			addChild(debug_txt);
		}
		public function AddItem(Object : String):void
		{
			SendItems.push(Object);
		}
		
		public function SendVars(_SendItems : Array):void
		{
			SendItems = _SendItems;
			
			for ( var i : uint = 0; i < SendItems.length; i ++ )
			{
				if(SendItems[i].toString() != "")
				{
					isAllChecked = true;
				}
				else
				{
					checkAlert=false;
					isAllChecked = false;
					if(Globals.Language == "en")
						debug_txt.SetText('Please, fill all of the blank fields');
					else
						debug_txt.SetText('Lütfen bütün gerekli alanları doldurun');
					togliAlert();
				}
			}
			
			if(checker.initCheck(SendItems[9].toString()) && isAllChecked) // Specify which Array object is inherits e-mail information
			{
				trace("this is test");
				checkAlert=true;
				inviaDati();
			}
			else
			{
				checkAlert=false;
				if(Globals.Language == "en")
					debug_txt.SetText('Please, use a valid e-mail address');
				else
					debug_txt.SetText('Lütfen geçerli bir e-posta adresi girin.');
				togliAlert();
			}
			
		}
		
		private function togliAlert():void
		{
			timer=new Timer(2000,1);
            timer.addEventListener('timer',cancella);
            timer.start();
		}
		
		private function cancella(t:TimerEvent):void
		{
			if(Globals.Language == "en")
				debug_txt.SetText('Please, fill all of the blank fields');
			else
				debug_txt.SetText('Lütfen bütün gerekli alanları doldurun');
			for ( var i : uint = 0; i < SendItems.length; i ++ )
			{
				if(checkAlert)
				{
					SendItems[i] = "";
				}
			}
			checkAlert=false;
		}
		
		private function inviaDati():void
		{
			var variables:URLVariables = new URLVariables();
			
			variables.var0      = SendItems[0].toString();
			variables.var1      = SendItems[1].toString();
			variables.var2      = SendItems[2].toString();
			variables.var3      = SendItems[3].toString();
			variables.var4      = SendItems[4].toString();
			variables.var5      = SendItems[5].toString();
			variables.var6      = SendItems[6].toString();
			variables.var7      = SendItems[7].toString();
			variables.var8      = SendItems[8].toString();
			variables.var9      = SendItems[9].toString();
			variables.var10      = SendItems[10].toString();
			variables.var11      = SendItems[11].toString();
			variables.var12      = SendItems[12].toString();
			variables.var13      = SendItems[13].toString();
			variables.var14      = SendItems[14].toString();
			variables.var15      = SendItems[15].toString();
			variables.var16      = SendItems[16].toString();
			variables.var17      = SendItems[17].toString();
			variables.var18      = SendItems[18].toString();
			variables.var19      = SendItems[19].toString();
			variables.var20      = SendItems[20].toString();
			variables.var21      = SendItems[21].toString();
			
			var richiesta:URLRequest = new URLRequest();
			richiesta.url            = phpLoc;
			richiesta.method         = URLRequestMethod.POST;
			richiesta.data           = variables;
			
			var loader:URLLoader     = new URLLoader();
			loader.dataFormat        = URLLoaderDataFormat.VARIABLES;
			addListeners(loader);
			
			try 
			{
				loader.load(richiesta);
			} 
			catch (error:Error) 
			{
				trace('Server cannot be loaded. Please try again...');
			}
		}
		
		private function addListeners(d:IEventDispatcher):void
		{
			d.addEventListener(Event.OPEN,inizio);
			d.addEventListener(ProgressEvent.PROGRESS,inProgresso);
			d.addEventListener(Event.COMPLETE,completato);
			d.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			d.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatus);
			d.addEventListener(IOErrorEvent.IO_ERROR,ioError);
		}
		
		private function inizio(e:Event):void 
		{
			if(Globals.Language == "en")
				debug_txt.SetText('Sending...');
			else
				debug_txt.SetText('Gönderiliyor...');
		}
		
		private function inProgresso(e:ProgressEvent):void 
		{if(Globals.Language == "en")
			debug_txt.SetText('Sending...');
		else
			debug_txt.SetText('Gönderiliyor...');
		}
		
		private function completato(e:Event):void
		{
			var loader:URLLoader=URLLoader(e.target);
			var vars:URLVariables=new URLVariables(loader.data);
			if(vars.answer=='ok')
				if(Globals.Language == "en")
					debug_txt.SetText('Your message has been received to us');
				else
					debug_txt.SetText('Mesajınız bize ulaştı.');
				else
					if(Globals.Language == "en")
						debug_txt.SetText('Please try again later');
					else
						debug_txt.SetText('Bir sorun oluştu. Lütfen daha sonra tekrar deneyin.');
			togliAlert();
		}
		
		private function securityError(e:SecurityErrorEvent):void 
		{
			debug_txt.SetText('Error! Please try again later');
		}
		
		private function httpStatus(e:HTTPStatusEvent):void {}
		
		private function ioError(e:IOErrorEvent):void 
		{
			debug_txt.SetText('Error! Please try again later');
		}

	}
}