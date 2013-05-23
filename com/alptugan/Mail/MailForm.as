package com.alptugan.Mail
{
	import com.alptugan.events.EmailEvent;
	import com.alptugan.drawing.shape.PixelArrow;
	import com.alptugan.text.AInputTextField;
	import com.alptugan.text.ATextFieldCss;
	import com.alptugan.text.TextArea.ABasicTextArea;
	
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	TweenPlugin.activate([BlurFilterPlugin]);
	import com.greensock.easing.Expo;
	import com.greensock.plugins.TintPlugin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import com.alptugan.drawing.DottedLine;
	
	public class MailForm extends Sprite
	{
		public static var Name:String, 
		Email:String, 
		Subject:String, 
		Message:String;
		
		private var Input_Name    : AInputTextField,
		Input_Email   : AInputTextField,
		Input_Subject     : AInputTextField,
		Input_Message : AInputTextField;
		
		private var Send_Btn      : ATextFieldCss, 
		Send_Holder   : Shape, 
		Send_Tolder   : Sprite,
		Arrow         : PixelArrow;
		
		private var Addres_Header : ATextFieldCss, 
		Address       : ATextFieldCss, 
		Contact_Header: ATextFieldCss, 
		Contact       : ATextFieldCss;
		
		
		private var div1             : DottedLine;
		
		private var Mail_Message     : EMailForm;
		private var php_path         : String;
		
		private var Adres_Header_Str : String, 
		Adres_Text       : String; 
		
		private var TR :Boolean;
		
		public function MailForm(_php_path:String,_Adres_Header_Str:String, Adres_Text:String,_TR:Boolean = false)
		{
			OverwriteManager.init();
			addEvent(this,Event.ADDED_TO_STAGE,init);
			addEvent(this,Event.REMOVED_FROM_STAGE,remove);
			php_path         = _php_path;
			Adres_Header_Str = _Adres_Header_Str;
			this.Adres_Text  = Adres_Text;
			TR               = _TR;
		}
		
		private function init(e:Event):void
		{
			removeEvent(this,Event.ADDED_TO_STAGE,init);
			
			/**Debug Txt and URL Request and PHP**/
			Mail_Message = new EMailForm (php_path);
			addChild(Mail_Message);
			
			
			/**Check Language**/
			if(TR)
			{
				Name       = "Ad Soyad";
				Email      = "E-Posta";
				Subject    = "Konu";
				Message    = "Mesaj";
				Send_Btn   = new ATextFieldCss("GÖNDER", "uw","mail",0,false);
			}else{
				Name       = "Name Surname";
				Email      = "E-Mail";
				Subject    = "Subject";
				Message    = "Message";
				Send_Btn   = new ATextFieldCss("SEND", "uw","mail",0,false);
			}
			
			/**Input Field Paramaeters**/
			var InputTxtH   : int = 20;
			var InputTxtW   : int = 273;
			var InputTxtGap :int  = 10;
			
			/**Input Fields**/
			Input_Name     = new AInputTextField(0xcccccc,InputTxtW,InputTxtH,0x333333,11,0xffffff,Name,1);
			Input_Email    = new AInputTextField(0xcccccc,InputTxtW,InputTxtH,0x333333,11,0xffffff,Email,2);
			Input_Subject      = new AInputTextField(0xcccccc,InputTxtW,InputTxtH,0x333333,11,0xffffff,Subject,3);
			Input_Message  = new AInputTextField(0xcccccc,InputTxtW,90,0x333333,11,0xffffff,Message,4);
			
			addChild(Input_Name);
			addChild(Input_Email);
			addChild(Input_Subject);
			addChild(Input_Message);
			
			Input_Name.x    = 0;
			Input_Name.y    = 0;
			Input_Email.x   = Input_Name.x;
			Input_Email.y   = Input_Name.y + Input_Name.height + InputTxtGap;
			Input_Subject.y     = Input_Email.y + Input_Email.height + InputTxtGap;
			Input_Subject.x     = Input_Name.x;
			Input_Message.y = Input_Subject.y + Input_Subject.height + InputTxtGap;
			Input_Message.x = Input_Name.x;
			
			/**Send Button**/
			Send_Tolder = new Sprite();
			addEvent(Send_Tolder,MouseEvent.MOUSE_OVER,color);
			addEvent(Send_Tolder,MouseEvent.MOUSE_OUT,uncolor);
			addEvent(Send_Tolder,MouseEvent.CLICK,click);
			Send_Tolder.alpha = 0;
			Send_Tolder.tabIndex = 4;
			addChild(Send_Tolder);
			Send_Holder = new Shape();
			with(Send_Holder.graphics)
			{
				beginFill(Globals.BlueLight);
				drawRect(0,0,72,16);
				endFill();
			}
			Send_Tolder.x   = InputTxtW + Input_Name.x - 72;
			Send_Tolder.y   = Input_Message.y + Input_Message.height + InputTxtGap;
			
			Send_Tolder.mouseChildren = false;
			Send_Tolder.buttonMode    = true;
			
			Arrow = new PixelArrow();
			Send_Tolder.addChild(Send_Holder);
			Send_Tolder.addChild(Send_Btn);
			Send_Tolder.addChild(Arrow);
			
			Arrow.x = 5;
			Arrow.y = (Send_Holder.height - Arrow.height) >> 1;
			Send_Btn.x = Arrow.x + 5;
			Send_Btn.y = 1;
			
			
			
			/**Address and Contact Information**/
			Addres_Header  = new ATextFieldCss(Adres_Header_Str, "uw","content",0,false);
			Address        = new ATextFieldCss(String(this.Adres_Text), "w","content",InputTxtW*3,true);
			//Adress Header position
			Addres_Header.x = Input_Name.x - 2;
			Addres_Header.y = Send_Tolder.y + Send_Tolder.height + 30;
			Addres_Header.alpha = 0;
			addChild(Addres_Header);
			
			//Adress position
			Address.x       = Input_Name.x - 2;
			Address.y       = Addres_Header.y + Addres_Header.height + 5;
			Address.alpha = 0;
			addChild(Address);
			
			/**Seperator For The Address and Contact Information Title**/
			div1 = new DottedLine(Addres_Header.width + 8,1, 0xCCCCCC,1,1,1);
			div1.y = int(Addres_Header.y + Addres_Header.height - 5);
			div1.x = Addres_Header.x - 2;
			//div1.alpha = 0;
			addChild(div1); 
			
			//Warning Message Position
			Mail_Message.x  = Input_Name.x;
			Mail_Message.y  = Send_Tolder.y +( Send_Tolder.height / 2  - Mail_Message.height/ 2);
			
			RunAnimation();
		}
		
		private function RunAnimation():void
		{
			var delayT: Number = 0.2;
			TweenLite.from(Input_Name, 0.5, {alpha:0});
			TweenLite.from(Input_Name.messageBr, 0.5, {blurFilter:{blurX:15, blurY:15,ease:Expo.easeOut}});
			
			TweenLite.from(Input_Email, 0.5, {alpha:0});
			TweenLite.from(Input_Email.messageBr, 0.5, {delay:delayT,blurFilter:{blurX:15, blurY:15,ease:Expo.easeOut}});
			
			TweenLite.from(Input_Subject, 0.5, {alpha:0});
			TweenLite.from(Input_Subject.messageBr, 0.5, {delay:delayT * 2,blurFilter:{blurX:15, blurY:15,ease:Expo.easeOut}});
			
			TweenLite.from(Input_Message, 0.5, {alpha:0});
			TweenLite.from(Input_Message.messageBr, 0.5, {delay:delayT * 3,blurFilter:{blurX:15, blurY:15,ease:Expo.easeOut}});
			
			TweenLite.to(Send_Tolder, 0.5, {delay:delayT * 4,alpha:1,ease:Expo.easeOut});
			TweenLite.to(Addres_Header, 0.5, {delay:delayT * 5,alpha:1,ease:Expo.easeOut});
			TweenLite.to(Address, 0.5, {delay:delayT * 6,alpha:1,ease:Expo.easeOut});
		}
		
		private function color(e:MouseEvent):void
		{
			TweenLite.to(Send_Holder,1,{alpha:1,tint: 0xff0000,ease:Expo.easeOut});
		}
		
		private function uncolor(e:MouseEvent):void
		{
			TweenLite.to(Send_Holder,1,{alpha:0.8,tint: 0xff0000,ease:Expo.easeOut});
		}
		
		private function click(e:MouseEvent):void
		{
			trace(Input_Name.Tf.text);
			trace(Input_Email.Tf.text);
			trace(Input_Subject.Tf.text);
			trace(Input_Message.Tf.text);
			addEvent(Mail_Message, EmailEvent.EMAIL_SENT, onSend);
			addEvent(Mail_Message, EmailEvent.EMAIL_ERROR, onError);
			Mail_Message.SendVars(Input_Name.Tf.text,Input_Email.Tf.text,Input_Subject.Tf.text,Input_Message.Tf.text);
		}
		
		private function onError(e:EmailEvent):void
		{
			if(e.customMessage == "invalidMail")
				stage.focus = Input_Email.Tf;
			
			removeEvent(Mail_Message, EmailEvent.EMAIL_ERROR, onError);
		}
		
		private function onSend(e:EmailEvent):void
		{
			//TweenLite.to(_alertTextField, 0.1, {tint:confirmationColor});
			Input_Name.Tf.text = Name;
			Input_Email.Tf.text = Email;
			Input_Subject.Tf.text = Subject;
			Input_Message.Tf.text = Message;
			stage.focus = null;
			TweenLite.to(Input_Name.messageBr, 0.5, {tint:null});
			TweenLite.to(Input_Email.messageBr, 0.5, {tint:null});
			TweenLite.to(Input_Subject.messageBr, 0.5, {tint:null});
			TweenLite.to(Input_Message.messageBr, 0.5, {tint:null});
			TweenLite.to(Input_Name.messageBg, 0.5, {tint:null});
			TweenLite.to(Input_Email.messageBg, 0.5, {tint:null});
			TweenLite.to(Input_Subject.messageBg, 0.5, {tint:null});
			TweenLite.to(Input_Message.messageBg, 0.5, {tint:null});
			removeEvent(Mail_Message, EmailEvent.EMAIL_SENT, onSend);
		}
		
		private function remove(e:Event):void
		{
			removeEvent(Send_Tolder,MouseEvent.MOUSE_OVER,color);
			removeEvent(Send_Tolder,MouseEvent.MOUSE_OUT,uncolor);
			removeEvent(Send_Tolder,MouseEvent.CLICK,click);
			removeChild(Mail_Message);
			removeChild(Input_Name);
			removeChild(Input_Email);
			removeChild(Input_Subject);
			removeChild(Input_Message);
			Send_Tolder.removeChild(Send_Holder);
			Send_Tolder.removeChild(Send_Btn);
			removeChild(Send_Tolder);
			removeChild(Address);
			removeChild(div1);
			Mail_Message = null;
			Input_Name = null;
			Input_Email = null;
			Input_Subject = null;
			Input_Message = null;
			Send_Holder = null;
			Send_Btn = null;
			Send_Tolder = null;
			Address = null;
			div1 = null;
			removeEvent(this,Event.REMOVED_FROM_STAGE,remove);
			
		}
		
		private function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, true);
		}
		
		private function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
		
	}
}