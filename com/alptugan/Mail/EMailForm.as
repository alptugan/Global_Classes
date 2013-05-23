package com.alptugan.Mail
{
	import com.alptugan.events.EmailEvent;
	import com.alptugan.text.ATextFieldCss;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;

	
	public class EMailForm extends Sprite
	{
		private var checker    : CheckEmail;
		private var timer      : Timer;
		private var checkAlert : Boolean;
		private var debug_txt  : ATextFieldCss;
		private var sEvt       : EmailEvent;
		
		private var isim       : String, 
					email      : String, 
					konu       : String, 
					mesaj      : String, 
					phpLoc     : String,
					language   : String;
		
		public function EMailForm(_phpLoc : String, language:String="en"):void
		{
			phpLoc = _phpLoc;
			this.language = language;
			checker= new CheckEmail();
			
			if(this.language == "en")
				debug_txt = new ATextFieldCss("All fields are required","uw","mailAlert");
			else
				debug_txt = new ATextFieldCss("Lütfen bütün boş alanları doldurun","uw","mailAlert");
			addChild(debug_txt);
			
		}

		public function SendVars(_isim : String, _email : String, _konu : String, _mesaj : String):void
		{
			isim  = _isim;
			email = _email;
			konu   = _konu;
			mesaj = _mesaj;
			//trace(isim + " - " + email + " - " + konu + " - "+ mesaj);
			if(isim != MailForm.Name && email != MailForm.Email && konu != MailForm.Subject && mesaj != MailForm.Message)
			{
				if(checker.initCheck(email))
				{
					checkAlert=true;
					inviaDati();
				}
				else
				{
					checkAlert=false;
					if(this.language == "en")
						debug_txt.SetText('Please, use a valid e-mail address');
					else
						debug_txt.SetText('Lütfen geçerli bir e-posta adresi girin.');
					togliAlert();
					sEvt = new EmailEvent(EmailEvent.EMAIL_ERROR);
					sEvt.customMessage = "invalidMail";
					dispatchEvent(sEvt);
				}
			}
			else
			{
				checkAlert=false;
				if(this.language == "en")
					debug_txt.SetText('All fields are required');
				else
					debug_txt.SetText('Lütfen bütün boş alanları doldurun');
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
			if(this.language == "en")
				debug_txt.SetText('All fields are required');
			else
				debug_txt.SetText('Lütfen bütün boş alanları doldurun');
			if(checkAlert)
			{
				isim='';
				email='';
				konu='';
				mesaj='';
				if(this.language == "en")
					debug_txt.SetText('All fields are required');
				else
					debug_txt.SetText('Lütfen bütün boş alanları doldurun');
			}
			checkAlert=false;
		}
		
		private function inviaDati():void
		{
			var variables:URLVariables = new URLVariables();
			variables.Sender           = isim;
			variables.Email            = email;
			variables.Subject          = konu;
			variables.Mesaj            = mesaj;
			
			var richiesta:URLRequest=new URLRequest();

			richiesta.url=phpLoc;
			richiesta.method=URLRequestMethod.POST;
			richiesta.data=variables;
			
			var loader:URLLoader=new URLLoader();
			loader.dataFormat=URLLoaderDataFormat.VARIABLES;
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
			d.addEventListener(ProgressEvent.PROGRESS,onProgress);
			d.addEventListener(Event.COMPLETE,onComplete);
			d.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			d.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatus);
			d.addEventListener(IOErrorEvent.IO_ERROR,ioError);
		}
		
		private function inizio(e:Event):void 
		{
			if(this.language == "en")
				debug_txt.SetText('Sending...');
			else
				debug_txt.SetText('Gönderiliyor...');
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			if(this.language == "en")
				debug_txt.SetText('Sending...');
			else
				debug_txt.SetText('Gönderiliyor...');
			
			
		}
		
	/**Mesage Sent Succesfully**/
		private function onComplete(e:Event):void
		{
			var loader:URLLoader=URLLoader(e.target);
			var vars:URLVariables=new URLVariables(loader.data);
			if(vars.answer=='ok')
				if(this.language == "en")
					debug_txt.SetText('Your message has been received to us');
				else
					debug_txt.SetText('Mesajınız bize ulaştı.');
			else
				if(this.language == "en")
					debug_txt.SetText('Please try again later');
				else
					debug_txt.SetText('Bir sorun oluştu. Lütfen daha sonra tekrar deneyin.');
			togliAlert();
			
			sEvt = new EmailEvent(EmailEvent.EMAIL_SENT);
			dispatchEvent(sEvt);
		}
		
		private function securityError(e:SecurityErrorEvent):void 
		{
			if(this.language == "en")
				debug_txt.SetText('Error! Please try again later');
			else
				debug_txt.SetText('Hata! Lütfen daha sonra tekrar deneyin.');
		}
		
		private function httpStatus(e:HTTPStatusEvent):void {
			//trace(e);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			if(this.language == "en")
				debug_txt.SetText('Error! Please try again later');
			else
				debug_txt.SetText('Hata! Lütfen daha sonra tekrar deneyin.');
		}

	}
}