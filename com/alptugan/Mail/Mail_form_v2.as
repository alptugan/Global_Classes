package com.alptugan.Mail
{
	import alptugan.Backup.Input_Txt_Class;
	import alptugan.Text.ATextFieldCss;
	
	import aze.motion.easing.Expo;
	import aze.motion.eaze;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Mail_form_v2 extends Sprite
	{
		//Send Button
		private var Send_Btn      : ATextFieldCss;
		private var Send_Holder   : Sprite;
		private var Send_Tolder   : Sprite;
		
		//PHP Location Information
		private var adres_str         : String;
		
		private var Mail_Message   : EmailForm_v2;
		
		//Input Field
		private var InputHolder    : Sprite;
		private var InputField     : Array = new Array();
		private var InputTitle     : ATextFieldCss;
		
		private var FieldsArr      : Array = new Array();
		private var FieldHolder    : Sprite = new Sprite();
		private var i : int    = -1;
		private var TR : Boolean;
		
		public function Mail_form_v2(_adres_str:String,_TR:Boolean=false)
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,remove);
			adres_str   = _adres_str;
			TR          = _TR;
		}

		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			Mail_Message = new EmailForm_v2(adres_str);
			addChild(Mail_Message);
			if(TR)
			{
				Send_Btn   = new ATextFieldCss("Gönder", "uw","mail",0,false);
			}else{
				Send_Btn   = new ATextFieldCss("Send", "uw","mail",0,false);
			}
			
			Send_Btn.x      = 6;
			Send_Btn.y      = 5;
			
			Send_Tolder = new Sprite();
			Send_Holder = new Sprite();
			Send_Holder.graphics.beginFill(0x4a4a4a);
			Send_Holder.graphics.drawRect(0,0,82,23);
			Send_Holder.graphics.endFill();
			Send_Tolder.x   = 0;
			Send_Tolder.y   = 0;
			
			//SEND BUTTON
			Send_Tolder.mouseChildren = false;
			Send_Tolder.buttonMode    = true;
			Send_Tolder.addEventListener(MouseEvent.MOUSE_OVER,color);
			Send_Tolder.addEventListener(MouseEvent.MOUSE_OUT,uncolor);
			Send_Tolder.addEventListener(MouseEvent.CLICK,click);
			addChild(Send_Tolder);
			Send_Tolder.addChild(Send_Holder);
			Send_Tolder.addChild(Send_Btn);
			
			addChild(FieldHolder);
			var h: Number = 5;
			if(TR)
			{
				
				FieldsArr[0] = addInputTextField("İsim, Soyisim:", 16);
				FieldHolder.addChild(FieldsArr[0]);
				
				FieldsArr[1]   = addInputTextField("Doğum Tarihi / Yeri:", 16);
				FieldsArr[1].y = FieldsArr[0].y + FieldsArr[0].height + h;
				FieldHolder.addChild(FieldsArr[1]);
				
				FieldsArr[2] = addInputTextField("Cinsiyet:", 16);
				FieldsArr[2].y = FieldsArr[1].y + FieldsArr[1].height + h;
				FieldHolder.addChild(FieldsArr[2]);
				
				FieldsArr[3] = addInputTextField("Askerlik Durumu:", 16);
				FieldsArr[3].y = FieldsArr[2].y + FieldsArr[2].height + h;
				FieldHolder.addChild(FieldsArr[3]);
				
				FieldsArr[4] = addInputTextField("Tecil tarihi:", 16);
				FieldsArr[4].y = FieldsArr[3].y + FieldsArr[3].height + h;
				FieldHolder.addChild(FieldsArr[4]);
				
				FieldsArr[5] = addInputTextField("Medeni Hali:", 16);
				FieldsArr[5].y = FieldsArr[4].y + FieldsArr[4].height + h;
				FieldHolder.addChild(FieldsArr[5]);
				
				FieldsArr[6] = addInputTextField("Çocuk Sayısı / Yaşları:", 39 + h);
				FieldsArr[6].y = FieldsArr[5].y + FieldsArr[5].height + h;
				FieldHolder.addChild(FieldsArr[6]);
				
				FieldsArr[7] = addInputTextField("Tel:", 16);
				FieldsArr[7].y = FieldsArr[6].y + FieldsArr[6].height + h + 7;
				FieldHolder.addChild(FieldsArr[7]);
				
				FieldsArr[8] = addInputTextField("Cep Telefonu:", 16);
				FieldsArr[8].y = FieldsArr[7].y + FieldsArr[7].height + h;
				FieldHolder.addChild(FieldsArr[8]);
				
				//Next Row
				FieldsArr[9] = addInputTextField("E-Posta:", 16);
				FieldsArr[9].y = 0;
				FieldsArr[9].x = FieldHolder.x + FieldHolder.width + 50;
				FieldHolder.addChild(FieldsArr[9]);
				
				FieldsArr[10] = addInputTextField("Adres:", 39 + h);
				FieldsArr[10].y = FieldsArr[9].y + FieldsArr[9].height + h;
				FieldsArr[10].x = FieldsArr[9].x;
				FieldHolder.addChild(FieldsArr[10]);
				
				FieldsArr[11] = addInputTextField("Halen çalışıyor iseniz, şu anki işyeri adı ve adresi:", 65 + h);
				FieldsArr[11].y = FieldsArr[10].y + FieldsArr[10 ].height + h + 7;
				FieldsArr[11].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[11]);
				
				FieldsArr[12] = addInputTextField("Şu anki işyerindeki göreviniz:", 16);
				FieldsArr[12].y = FieldsArr[11].y + FieldsArr[11].height + h + 7;
				FieldsArr[12].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[12]);
				
				FieldsArr[13] = addInputTextField("Şu anki işyerinden ayrılma sebebiniz:", 39 + h);
				FieldsArr[13].y = FieldsArr[12].y + FieldsArr[12].height + h ;
				FieldsArr[13].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[13]);
				
				FieldsArr[14] = addInputTextField("Ehliyet Belgesi / Sınıfı:", 16);
				FieldsArr[14].y = FieldsArr[13].y + FieldsArr[13].height + h ;
				FieldsArr[14].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[14]);
				
				FieldsArr[15] = addInputTextField("Eğitim geçmişi:", 16);
				FieldsArr[15].y = 0;//FieldsArr[14].y + FieldsArr[14].height + h ;
				FieldsArr[15].x = FieldHolder.x + FieldHolder.width + 50;//FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[15]);
				
				FieldsArr[16] = addInputTextField("Yabancı diller:", 16);
				FieldsArr[16].y = FieldsArr[15].y + FieldsArr[15].height + h;
				FieldsArr[16].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[16]);
				
				FieldsArr[17] = addInputTextField("Mezun olunan Okullar:", 39 + h);
				FieldsArr[17].y = FieldsArr[16].y + FieldsArr[16].height + h;
				FieldsArr[17].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[17]);
				
				FieldsArr[18] = addInputTextField("Diğer iş deneyimleri:", 39 + h);
				FieldsArr[18].y = FieldsArr[17].y + FieldsArr[17].height + h + 7;
				FieldsArr[18].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[18]);
				
				FieldsArr[19] = addInputTextField("Tercih edilen Pozisyon:", 16);
				FieldsArr[19].y = FieldsArr[18].y + FieldsArr[18].height + h + 7;
				FieldsArr[19].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[19]);
				
				FieldsArr[20] = addInputTextField("Referanslar:", 39 + h);
				FieldsArr[20].y = FieldsArr[19].y + FieldsArr[19].height + h;
				FieldsArr[20].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[20]);
				
				FieldsArr[21] = addInputTextField("Diğer Bilgiler:", 39 + h);
				FieldsArr[21].y = FieldsArr[20].y + FieldsArr[20].height + h + 7;
				FieldsArr[21].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[21]);
			}else{
				FieldsArr[0] = addInputTextField("Name, Surname:", 16);
				FieldHolder.addChild(FieldsArr[0]);
				
				FieldsArr[1]   = addInputTextField("Birth/Place:", 16);
				FieldsArr[1].y = FieldsArr[0].y + FieldsArr[0].height + h;
				FieldHolder.addChild(FieldsArr[1]);
				
				FieldsArr[2] = addInputTextField("Gender:", 16);
				FieldsArr[2].y = FieldsArr[1].y + FieldsArr[1].height + h;
				FieldHolder.addChild(FieldsArr[2]);
				
				FieldsArr[3] = addInputTextField("Military State:", 16);
				FieldsArr[3].y = FieldsArr[2].y + FieldsArr[2].height + h;
				FieldHolder.addChild(FieldsArr[3]);
				
				FieldsArr[4] = addInputTextField("Date of Registration:", 16);
				FieldsArr[4].y = FieldsArr[3].y + FieldsArr[3].height + h;
				FieldHolder.addChild(FieldsArr[4]);
				
				FieldsArr[5] = addInputTextField("Marital Status:", 16);
				FieldsArr[5].y = FieldsArr[4].y + FieldsArr[4].height + h;
				FieldHolder.addChild(FieldsArr[5]);
				
				FieldsArr[6] = addInputTextField("Kids / Age:", 39 + h);
				FieldsArr[6].y = FieldsArr[5].y + FieldsArr[5].height + h;
				FieldHolder.addChild(FieldsArr[6]);
				
				FieldsArr[7] = addInputTextField("Tel:", 16);
				FieldsArr[7].y = FieldsArr[6].y + FieldsArr[6].height + h + 7;
				FieldHolder.addChild(FieldsArr[7]);
				
				FieldsArr[8] = addInputTextField("Mobile:", 16);
				FieldsArr[8].y = FieldsArr[7].y + FieldsArr[7].height + h;
				FieldHolder.addChild(FieldsArr[8]);
				
				//Next Row
				FieldsArr[9] = addInputTextField("E-Mail:", 16);
				FieldsArr[9].y = 0;
				FieldsArr[9].x = FieldHolder.x + FieldHolder.width + 50;
				FieldHolder.addChild(FieldsArr[9]);
				
				FieldsArr[10] = addInputTextField("Adress:", 39 + h);
				FieldsArr[10].y = FieldsArr[9].y + FieldsArr[9].height + h;
				FieldsArr[10].x = FieldsArr[9].x;
				FieldHolder.addChild(FieldsArr[10]);
				
				FieldsArr[11] = addInputTextField("If you are still working, what is it name of business place and adress:", 65 + h);
				FieldsArr[11].y = FieldsArr[10].y + FieldsArr[10 ].height + h + 7;
				FieldsArr[11].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[11]);
				
				FieldsArr[12] = addInputTextField("What is your task:", 16);
				FieldsArr[12].y = FieldsArr[11].y + FieldsArr[11].height + h + 7;
				FieldsArr[12].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[12]);
				
				FieldsArr[13] = addInputTextField("The reason why she/he wants to leave:", 39 + h);
				FieldsArr[13].y = FieldsArr[12].y + FieldsArr[12].height + h ;
				FieldsArr[13].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[13]);
				
				FieldsArr[14] = addInputTextField("Driving Lic./Class:", 16);
				FieldsArr[14].y = FieldsArr[13].y + FieldsArr[13].height + h ;
				FieldsArr[14].x = FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[14]);
				
				FieldsArr[15] = addInputTextField("Educational Background:", 16);
				FieldsArr[15].y = 0;//FieldsArr[14].y + FieldsArr[14].height + h ;
				FieldsArr[15].x = FieldHolder.x + FieldHolder.width + 50;//FieldsArr[10].x;
				FieldHolder.addChild(FieldsArr[15]);
				
				FieldsArr[16] = addInputTextField("Languages:", 16);
				FieldsArr[16].y = FieldsArr[15].y + FieldsArr[15].height + h;
				FieldsArr[16].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[16]);
				
				FieldsArr[17] = addInputTextField("Alma Mater:", 39 + h);
				FieldsArr[17].y = FieldsArr[16].y + FieldsArr[16].height + h;
				FieldsArr[17].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[17]);
				
				FieldsArr[18] = addInputTextField("Other Business Experiences:", 39 + h);
				FieldsArr[18].y = FieldsArr[17].y + FieldsArr[17].height + h + 7;
				FieldsArr[18].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[18]);
				
				FieldsArr[19] = addInputTextField("Desired Position:", 16);
				FieldsArr[19].y = FieldsArr[18].y + FieldsArr[18].height + h + 7;
				FieldsArr[19].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[19]);
				
				FieldsArr[20] = addInputTextField("Referances:", 39 + h);
				FieldsArr[20].y = FieldsArr[19].y + FieldsArr[19].height + h;
				FieldsArr[20].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[20]);
				
				FieldsArr[21] = addInputTextField("Other Information:", 39 + h);
				FieldsArr[21].y = FieldsArr[20].y + FieldsArr[20].height + h + 7;
				FieldsArr[21].x = FieldsArr[15].x;
				FieldHolder.addChild(FieldsArr[21]);
			}
			
		
			Send_Tolder.y = FieldHolder.height + 10;
			
			Mail_Message.x  = Send_Tolder.x + Send_Tolder.width + 10;
			Mail_Message.y  = Send_Tolder.y +( Send_Tolder.height / 2  - Mail_Message.height/ 2);
		}
		
		private function addInputTextField(_str : String, _h : Number) : Sprite
		{
			i++;
			InputHolder = new Sprite();
			InputTitle = new ATextFieldCss(_str,"w","content",108);
			InputHolder.addChild(InputTitle);
			
			InputField[i] = new Input_Txt_Class(0x999999,150,_h);
			InputHolder.addChild(InputField[i]);
			
			InputTitle.y = (InputField[i].height - InputTitle.height) * 0.5 + 2;
			InputField[i].x = 110;
			
			
			
			return InputHolder;
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
			var VarsToLoad : Array = new Array();
			for ( var j : uint = 0; j < FieldsArr.length; j ++ )
			{
				VarsToLoad[j] = InputField[j].myTextBox1.text;
			}
			
			Mail_Message.SendVars(VarsToLoad);
		}
		
		private function remove(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,remove);
			
		}

	}
}