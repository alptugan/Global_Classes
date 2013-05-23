package alptugan.Backup
{
	import com.alptugan.Mail.EMailForm;
	
	import alptugan.Text.ATextFieldCss;
	
	import aze.motion.easing.Expo;
	import aze.motion.eaze;
	
	import com.kusina.Globals;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import warmforestflash.drawing.DottedLine;
	
	public class Mail_form extends Sprite
	{
		private var Name:ATextFieldCss;
		private var Email:ATextFieldCss;
		private var Tel:ATextFieldCss;
		private var Message:ATextFieldCss;
		
		private var Input_Name    : Input_Txt_Class;
		private var Input_Email   : Input_Txt_Class;
		private var Input_Tel     : Input_Txt_Class;
		private var Input_Message : Input_Txt_Class;
		
		private var Send_Btn      : ATextFieldCss;
		private var Send_Holder   : Sprite;
		private var Send_Tolder   : Sprite;
		
		private var Addres_Header : ATextFieldCss;
		private var Address       : ATextFieldCss;
		
		private var Contact_Header: ATextFieldCss;
		private var Contact       : ATextFieldCss;
		
		private var Twitter       : Bitmap;
		private var T_Holder      : Sprite;
		
		private var php_path         : String;
		private var div1           : DottedLine;
		
		private var Mail_Message      : EMailForm;
		
		
		private var Adres_Header_Str   : String; 
		private var TR :Boolean;
		
		public function Mail_form(_php_path:String,_Adres_Header_Str:String,_TR:Boolean = false):void
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,remove);
			php_path   = _php_path;
			Adres_Header_Str = _Adres_Header_Str;
			TR = _TR;
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			Mail_Message = new EMailForm (php_path);
			addChild(Mail_Message);
			
			if(TR)
			{
				Name       = new ATextFieldCss("İsim Soyisim :", "uw","content",0,false);
				Email      = new ATextFieldCss("E-Posta :",  "uw","content",0,false);
				Tel        = new ATextFieldCss("Konu :", "uw","content",0,false);
				Message    = new ATextFieldCss("Mesaj :", "uw","content",0,false);
				Send_Btn   = new ATextFieldCss("Gönder", "uw","mail",0,false);
				
			}else{
				Name       = new ATextFieldCss("Name Surname :", "uw","content",0,false);
				Email      = new ATextFieldCss("E-Mail :",  "uw","content",0,false);
				Tel        = new ATextFieldCss("Subject :", "uw","content",0,false);
				Message    = new ATextFieldCss("Message :", "uw","content",0,false);
				Send_Btn   = new ATextFieldCss("Send", "uw","mail",0,false);
				
			}
			Addres_Header  = new ATextFieldCss(Adres_Header_Str, "uw","content",0,false);
			Address        = new ATextFieldCss(String(Globals.FooterXML.adres), "w","content",400,true);
			Input_Name    = new Input_Txt_Class(0x999999);
			Input_Email   = new Input_Txt_Class(0x999999);
			Input_Tel     = new Input_Txt_Class(0x999999);
			Input_Message = new Input_Txt_Class(0x999999,300,70);
						
			Email.y    = Name.y + 28;
			
			Tel.y      = Email.y + 28;
			
			
			
			Input_Name.x    =  100;
			Input_Name.y    = Name.y + 1;
			Input_Email.x   = 100;
			Input_Email.y   = Email.y + 1;
			Input_Tel.y     = Tel.y + 1;
			Input_Tel.x     = 100;
			Input_Message.y = Tel.y + 28 + 2;
			Input_Message.x = 100;
			Send_Btn.x      = 6;
			Send_Btn.y      = 5;
			
			addChild(Name);
			addChild(Email);
			addChild(Tel);
			addChild(Message);
			addChild(Input_Name);
			addChild(Input_Email);
			addChild(Input_Tel);
			addChild(Input_Message);
			
			
			Message.y  = Tel.y + 27;
			
			
			Send_Tolder = new Sprite();
			Send_Holder = new Sprite();
			Send_Holder.graphics.beginFill(0x4a4a4a);
			Send_Holder.graphics.drawRect(0,0,82,23);
			Send_Holder.graphics.endFill();
			Send_Tolder.x   = Input_Name.x;
			Send_Tolder.y   = Message.y + 85;
			
			
			//SEND BUTTON
			Send_Tolder.mouseChildren = false;
			Send_Tolder.buttonMode    = true;
			Send_Tolder.addEventListener(MouseEvent.MOUSE_OVER,color);
			Send_Tolder.addEventListener(MouseEvent.MOUSE_OUT,uncolor);
			Send_Tolder.addEventListener(MouseEvent.CLICK,click);
			addChild(Send_Tolder);
			Send_Tolder.addChild(Send_Holder);
			Send_Tolder.addChild(Send_Btn);
			
			
			Addres_Header.x = Send_Tolder.x - 2;
			Addres_Header.y = Send_Tolder.y + Send_Tolder.height + 30;
			addChild(Addres_Header);
			Address.x       = Send_Tolder.x - 2;
			Address.y       = Addres_Header.y + Addres_Header.height + 10;
			addChild(Address);
			
			//Divider
			div1 = new DottedLine(Addres_Header.width + 4,1,0x000000,0.5,2,1);
			div1.y = Addres_Header.y + Addres_Header.height - 5;
			div1.x = Addres_Header.x - 2;
			addChild(div1); 
			
			Mail_Message.x  = Send_Tolder.x + Send_Tolder.width + 10;
			Mail_Message.y  = Send_Tolder.y +( Send_Tolder.height / 2  - Mail_Message.height/ 2);
		}
		
		private function color(e:MouseEvent):void
		{
			eaze(Send_Holder).to(1, { tint: 0x000000}).easing(Expo.easeOut);
		}
		
		private function uncolor(e:MouseEvent):void
		{
			eaze(Send_Holder).to(1, { tint: 0x4a4a4a}).easing(Expo.easeOut);
		}
		
		private function click(e:MouseEvent):void
		{
			trace(Input_Name.myTextBox1.text);
			trace(Input_Email.myTextBox1.text);
			trace(Input_Tel.myTextBox1.text);
			trace(Input_Message.myTextBox1.text);
			Mail_Message.SendVars(Input_Name.myTextBox1.text,Input_Email.myTextBox1.text,
			Input_Tel.myTextBox1.text,Input_Message.myTextBox1.text);
		}
		
		private function remove(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,remove);
			
		}

	}
}