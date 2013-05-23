package  src.com.azinliklarittifaki.mail
{
	import com.alptugan.drawing.shape.PixelArrow;
	import com.alptugan.events.EmailEvent;
	import com.alptugan.text.AInputText;
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
	
	import org.casalib.display.CasaSprite;
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.text.AText;
	import com.alptugan.utils.Colors;
	import src.com.galea.Globals;
	import com.alptugan.Mail.AMailButton;
	
	public class AMailForm extends CasaSprite
	{
		public static var Name:String, 
		Email:String, 
		Subject:String, 
		Message:String;
		
		private var Input_Name    : AInputText,
		Input_Email   : AInputText,
		Input_Subject     : AInputText,
		Input_Message : AInputText;
		
		private var Send_Btn      :AMailButton, 
		Arrow         : PixelArrow;
		
		private var Mail_Message     : AEMailForm;
		private var php_path         : String;
		
		private var Adres_Header_Str : String, 
		Adres_Text       : String; 
		
		private var TR :Boolean;
		
		private var InputTxtH:int;
		
		private var InputTxtW:int;
		
		private var InputTxtGap:int;
		
		public function AMailForm(_php_path:String,InputTxtW:int,InputTxtH:int,InputTxtGap:int,_TR:Boolean = false)
		{
			OverwriteManager.init();
			addEvent(this,Event.ADDED_TO_STAGE,init);
			addEvent(this,Event.REMOVED_FROM_STAGE,remove);
			this.php_path         = _php_path;
			this.TR               = _TR;
			this.InputTxtW 		  = InputTxtW;
			this.InputTxtH        = InputTxtH;
			this.InputTxtGap      = InputTxtGap;
		}
		
		private function init(e:Event):void
		{
			removeEvent(this,Event.ADDED_TO_STAGE,init);
			
			/**Debug Txt and URL Request and PHP**/
			Mail_Message = new AEMailForm (php_path,this.TR ? 'tr' : 'en');
			addChild(Mail_Message);
			
			
			/**Check Language**/
			if(TR)
			{
				Name       = "Ad Soyad";
				Email      = "E-Posta";
				Subject    = "Konu";
				Message    = "Mesaj";
				Send_Btn   = new AMailButton("GÖNDER",FontNamesFB.regular,0xffffff,8,true,true);
			}else{
				Name       = "Name Surname";
				Email      = "E-Mail";
				Subject    = "Subject";
				Message    = "Message";
				Send_Btn   = new AMailButton("SEND",FontNamesFB.regular,0xffffff,8,false,true);
			}
			
			
			
			/**Input Fields**/
			Input_Name     = new AInputText(FontNamesFB.regular, Colors.cWhite,Colors.cGrayIV,InputTxtW,InputTxtH,Colors.cGrayIII,8,Colors.cWhite,Name,1);
			Input_Email    = new AInputText(FontNamesFB.regular,Colors.cWhite,Colors.cGrayIV,InputTxtW,InputTxtH,Colors.cGrayIII,8,Colors.cWhite,Email,2);
			Input_Subject  = new AInputText(FontNamesFB.regular,Colors.cWhite,Colors.cGrayIV,InputTxtW,InputTxtH,Colors.cGrayIII,8,Colors.cWhite,Subject,3);
			Input_Message  = new AInputText(FontNamesFB.regular,Colors.cWhite,Colors.cGrayIV,InputTxtW,124,Colors.cGrayIII,8,Colors.cWhite,Message,4);
			
			addChild(Input_Name);
			addChild(Input_Email);
			addChild(Input_Subject);
			addChild(Input_Message);
			
			Input_Name.x    = 0;
			Input_Name.y    = 0;
			Input_Email.x   = Input_Name.x;
			Input_Email.y   = Input_Name.y + Input_Name.height + InputTxtGap- 5;
			Input_Subject.y     = Input_Email.y + Input_Email.height + InputTxtGap - 5;
			Input_Subject.x     = Input_Name.x;
			Input_Message.y = Input_Subject.y + Input_Subject.height + InputTxtGap- 4;
			Input_Message.x = Input_Name.x;
			addChild(Send_Btn);
			/**Send Button**/
			addEvent(Send_Btn,MouseEvent.MOUSE_OVER,color);
			addEvent(Send_Btn,MouseEvent.MOUSE_OUT,uncolor);
			addEvent(Send_Btn,MouseEvent.CLICK,click);
			
			Arrow = new PixelArrow();
			
			Send_Btn.addChild(Arrow);
			
			Arrow.x = 5;
			Arrow.y = (Send_Btn.height - Arrow.height) >> 1;
			Send_Btn.x = Input_Message.x + Input_Message.width - Send_Btn.width - 1;
			Send_Btn.y = Input_Message.y + Input_Message.height - 3; 
			
			//Warning Message Position
			Mail_Message.x  = Input_Name.x;
			Mail_Message.y  = Send_Btn.y + Send_Btn.height * 0.5 - Mail_Message.height*0.5 + 3;
			
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
			
			TweenLite.to(Send_Btn, 0.5, {delay:delayT * 3,alpha:1,ease:Expo.easeOut});
		}
		
		private function color(e:MouseEvent):void
		{
			TweenLite.to(Send_Btn.rect,1,{tint: Colors.cTomato,ease:Expo.easeOut});
		}
		
		private function uncolor(e:MouseEvent):void
		{
			TweenLite.to(Send_Btn.rect,1,{tint:null,ease:Expo.easeOut});
		}
		
		private function click(e:MouseEvent):void
		{
			/*trace(Input_Name.Tf.text);
			trace(Input_Email.Tf.text);
			trace(Input_Subject.Tf.text);
			trace(Input_Message.Tf.text);*/
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
			trace("mail is sent succesfully");
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
			TweenLite.killTweensOf(this);
			removeEvent(Send_Btn,MouseEvent.MOUSE_OVER,color);
			removeEvent(Send_Btn,MouseEvent.MOUSE_OUT,uncolor);
			removeEvent(Send_Btn,MouseEvent.CLICK,click);
			removeChild(Mail_Message);
			removeChild(Input_Name);
			removeChild(Input_Email);
			removeChild(Input_Subject);
			removeChild(Input_Message);
			//Send_Tolder.removeChild(Send_Btn);
			Mail_Message = null;
			Input_Name = null;
			Input_Email = null;
			Input_Subject = null;
			Input_Message = null;
			Send_Btn = null;
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