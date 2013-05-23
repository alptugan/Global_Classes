package  src.com.galea{	
	import br.com.stimuli.loading.BulkLoader;
	
	import com.alptugan.events.AccordionMenuEvent;
	import com.alptugan.globals.Root;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
		
	public class AccordionMenu extends Root
	{
		public var ContentHolder : Sprite;
		
		private var itemLen       : int;
		private var MenuItem      : Array = [];
		private var SubMenuItem   : Array  = [];
		private var itemTxt       : Array = [];
		private var query       : Array = [];
		private var subItemTxt    : Array = [];
		private var subItemMarginV : int  = 4;
		private var textLenght    : int = 0;
		private var textHeight    : int = 0;
		private var menu_SpaceH   : int = 40;
		private var menu_SpaceV   : int = 1;
		
		private var Id              : int    = -1;
		private var subId            : int    = -1;
		private var PreId           : int    = 0;
		private var SubId           : int    = -1;
		
		
		public var ContentIsRemoved: Boolean = true;
		private var SubIsAdded      : Boolean = false;
		private var isFirstClick    : Boolean = false;
		
		private var SWFMainClickedId   : String = "-1";
		private var SWFPreMainClickedId   : String = " ";
		private var SWFSubClickedId   : String = "0";
		
		public static var LastSubValue     : String = "";
		public static var LastMainValue    : String = "";
		private var PreLastmainValue : String = "";
		private var SubIsListed      : Boolean = false;
		
		private 	var t:Number = 100;
		
		private var fontName:String;
		private var fontSize:int;
		
		[Embed(source="assets/ayrac.png")]
		public var ayrac:Class;
		
		public function AccordionMenu(fontName:String,fontSize:int):void 
		{
			this.fontName = fontName;
			this.fontSize = fontSize;
			addEvent(this,Event.ADDED_TO_STAGE, init);
			addEvent(this,Event.REMOVED_FROM_STAGE,remove);
		}
		
		private function Line(X:int,Y:int):Bitmap
		{
			
			/*var S:Shape = new Shape();
			with(S.graphics)
			{
				lineStyle(1,Globals.GreyLine,1,true);
				moveTo(0,0);
				lineTo(0,23);
			}
			S.x = X;
			S.y = Y;
			addChild(S);
			return S;*/
			
			var d:Bitmap = new ayrac() as Bitmap;
			d.x = X;
			d.y = Y+8;
			addChild(d);
			
			return d;
		}
		
		private function init (e:Event):void
		{
			addEvent(stage,MouseEvent.CLICK,onClickStage);

			ContentHolder   = new Sprite();
			
			//MAIN MENU length
			itemLen = Globals.MenuXML.item.length();
			
			
			addChild(ContentHolder);
			for (var i:int = 0; i < itemLen; i++) {
				itemTxt[i]        = (Globals.MenuXML.item[i].@title);
				query[i]          = (Globals.MenuXML.item[i].@query);
				MenuItem[i]      = new AButton(String(itemTxt[i]).toUpperCase(),fontName,0x000000,fontSize,true);
				MenuItem[i].name = String(i);
				//MenuItem[i].y    = MenuItem[i].Y = textHeight + menu_SpaceV*i ; 
				MenuItem[i].x    = MenuItem[i].X = textLenght +  menu_SpaceH*i;
				
				ContentHolder.addChild(MenuItem[i]);
				if(i != itemLen - 1)
					Line(MenuItem[i].x + MenuItem[i].width + ((menu_SpaceH - 17) >> 1), 0);
				
				
						
				MenuItem[i].alpha = 0.5;
				textLenght += MenuItem[i].width;
				textHeight += MenuItem[i].height

				//TweenMax.to(MenuItem[i],0.8,{ease:Expo.easeOut, delay: i / 19,alpha:1,onComplete:AddMouseListeners,onCompleteParams:[i]});
			}			
			
			for (var j:int = 0; j < itemLen; j++) {
			
				//MenuItem[j].x    = ContentHolder.width - MenuItem[j].width;//textLenght + menu_SpaceH*i ; 
				//TweenMax.to(MenuItem[j],0.3,{ease:Expo.easeOut, delay: j / 19,alpha:0.5,onComplete:AddMouseListeners,onCompleteParams:[j]});
				AddMouseListeners(j);
			}		
			
			
			removeEvent(this,Event.ADDED_TO_STAGE, init);	
		}
		
		private function onClickStage (e:MouseEvent):void
		{
			/*if(SubIsListed )
			{
				RemoveSubMenus(subId);
				if(Globals.MenuXML.item[subId].subitem.length() == 0 && Id != 0)
					TweenMax.to(MenuItem[subId],0.5,{tint:Globals.LightGray,glowFilter:{color:Globals.Blue, blurX:0, blurY:0,alpha:0.5, strength:0, quality:0}});
			}*/
		}
		//ADD  MENU LISTENERS
		//-------------------------------------------------------------------------------------------------------		
		private function AddMouseListeners (_i:int):void
		{
			if(_i == itemLen-1) 
			{
				MouseActive(-1," ");
				/*Id=0;
				subId=0;
				SubMenuClicked(0);*/
				var menuEvt2:AccordionMenuEvent = new AccordionMenuEvent(AccordionMenuEvent.MENU_ADDED_TO_STAGE);
				dispatchEvent(menuEvt2);
			}
		}
		
		
		private function onClick(e:Event):void
		{	
			MainMenuClicked(e.target.name);
		}
		
		//On Click Main Menu Item Function
		public function MainMenuClicked(MainId:int):void
		{
			BulkLoader.removeAllLoaders();
			if(!isFirstClick && MainId != 1) RemoveMainPageItems();	
			//REset sub-menu index
			SubId = -1;
			
			if(Id != -1) //previously clicked main menu number
			{
				MouseActive(Id," ");
				TweenMax.to(MenuItem[Id],0.5,{alpha:0.5});
				
				if(Globals.MenuXML.item[Id].subitem.length() != 0) 
					RemoveSubMenus(Id);
				
				if(SubIsAdded) 
					RemoveSubMenuContent();
				
				if(!ContentIsRemoved)
					RemoveMainMenuContent();
			}
			
			
			Id = MainId;
			
			MouseInActive(Id," ");
			TweenMax.to(MenuItem[Id],0.5,{alpha:1,ease:Expo.easeOut});

			
			if(Globals.MenuXML.item[Id].subitem.length() == 0 ) 
			{
				AddContent(Globals.RemoveSpace(String(query[Id])));
			}
			
			//SUB MENU SIDE
			//-------------------------------------------------------------------------------------------------------		
			if(Globals.MenuXML.item[Id].subitem.length() > 0)
			{
				var subLength:Number = 0;
				var subheight:Number = 0;
				for (var i:int = 0; i < Globals.MenuXML.item[Id].subitem.length(); i++) 
				{
					subItemTxt[i]                = Globals.MenuXML.item[Id].subitem[i].@title;
					SubMenuItem[i]               = new AButton(subItemTxt[i],fontName,0x000000,fontSize,true,true);
					SubMenuItem[i].name          = String(i);
					SubMenuItem[i].x             = MenuItem[Id].X;
					SubMenuItem[i].y             = int(MenuItem[Id].Y + MenuItem[Id].height + subheight + menu_SpaceV*i + subItemMarginV); 
					ContentHolder.addChild(SubMenuItem[i]);
					
					subLength                   += SubMenuItem[i].width;
					subheight                   += SubMenuItem[i].height;
					SubMenuItem[i].alpha  = 0;
					SubIsListed = true;
					ShowSubMenus(i);
				}
			}
		}
		
		//ADD MAIN CONTENT TO STAGE
		public function AddContent(val:String):void
		{
			/*Content         = new Content_Switcher(val);
			Content.alpha   = 0;
			ContentHolder.addChild(Content);
			TweenMax.to(Content,0.5,{ease:Expo.easeOut,alpha:1});*/
			ContentIsRemoved = false;
			var menuEvt:AccordionMenuEvent = new AccordionMenuEvent(AccordionMenuEvent.CONTENT_ADDED_TO_STAGE);
			menuEvt.menuType = "main";
			menuEvt.name     = val;
			menuEvt.mainId   = Id;
			
			dispatchEvent(menuEvt);
		}
		
		//REMOVE SUB MENUS FROM STAGE
		private function RemoveSubMenus(_Id:int):void
		{
			if(Globals.MenuXML.item[_Id].subitem.length() > 0 && SubIsListed)
			{
				for ( var j : uint = 0; j < Globals.MenuXML.item[_Id].subitem.length(); j ++ )
				{
					ContentHolder.removeChild(SubMenuItem[j]);  
				}
				SubIsListed = false;

			}			
		}
		
		//REMOVE SUB MENU CONTENT FROM STAGE
		private function RemoveSubMenuContent():void
		{
			//ContentHolder.removeChild(Sub_Content);
			SubIsAdded = false;
		}
		
		//REMOVE MAIN MENU CONTENT FROM STAGE
		private function RemoveMainMenuContent():void
		{
			//ContentHolder.removeChild(Content);
			ContentIsRemoved = true;
		}
		
		//ADD SUB MENU LISTENERS
		//-------------------------------------------------------------------------------------------------------		
		private function AddSubMouseListeners (_j:int):void
		{
			if(_j == Globals.MenuXML.item[Id].subitem.length()-1) 
			{
				MouseActive(-1,"sub");
			}
		}
		//-------------------------------------------------------------------------------------------------------		
		//SUB MENU CLICK FUNCTION
		//-------------------------------------------------------------------------------------------------------
		private function onSubClick (e:Event):void
		{
			BulkLoader.removeAllLoaders();
			SubMenuClicked(e.target.name);
			//this.RemoveSubMenus(subId);
			/*if(Id != -1)
				TweenMax.to(MenuItem[Id],0.5,{tint:Globals.LightGray,glowFilter:{color:Globals.Blue, blurX:0, blurY:0,alpha:0},ease:Expo.easeOut});
			TweenMax.to(MenuItem[subId],0.5,{delay:0.1,tint:Globals.Blue,glowFilter:{color:Globals.Blue, blurX:4, blurY:4,alpha:0.5, strength:2, quality:2},ease:Expo.easeOut});
			Id = subId;*/
		}
		
		private function SubMenuClicked(SubMenuId:int):void
		{
			//setChildIndex(Pre, this.numChildren-1);
			if(!isFirstClick) 
			{
				RemoveMainPageItems();	
				
			}else{
				if(!ContentIsRemoved)
				{
					RemoveMainMenuContent();
				}	
			}
			
			if(SubIsAdded)
				RemoveSubMenuContent();
			
			if(SubId != -1) //previously clicked main menu number
			{
				MouseActive(SubId,"sub");
				TweenMax.to(SubMenuItem[SubId],0.5,{alpha:0.5});

				if(SubIsAdded)
					RemoveSubMenuContent();
			}
			
			SubId = SubMenuId;

			MouseInActive(SubId,"sub");
			dispatchEvent(new Event("MainContent"));
			
			AddSubContent(Globals.RemoveSpace(String(Globals.MenuXML.item[Id].subitem[SubId].@query)));
			MouseActive(Id,"main");
		}
		
		//ADD SUB CONTENT
		private function AddSubContent (val2:String):void
		{
			/*Sub_Content         = new Sub_Content_Switcher(Globals.RemoveSpace(String(subItemTxt[SubId])), Id);
			//Sub_Content.alpha   = 0;
			ContentHolder.addChild(Sub_Content);
			//TweenMax.to(Sub_Content,0.5,{ease:Expo.easeOut,alpha:1});*/
			var menuEvt3:AccordionMenuEvent = new AccordionMenuEvent(AccordionMenuEvent.CONTENT_ADDED_TO_STAGE);
			menuEvt3.menuType = "sub";
			menuEvt3.name = val2;
			menuEvt3.subId = SubId;
			dispatchEvent(menuEvt3);
			SubIsAdded = true;
		}
		
		//-------------------------------------------------------------------------------------------------------	
		//REMOVE MAIN PAGE ITEMS FROM STAGE
		//-------------------------------------------------------------------------------------------------------
		private function  RemoveMainPageItems ():void
		{			
			isFirstClick = true;
		}
		
		private function RemoveFromStage ():void
		{
			isFirstClick = true;
		}
		
	
		private function remove(e:Event):void
		{
			for (var k:int = 0; k < itemLen; k++)
			{
				TweenMax.killTweensOf(MenuItem[k]);
				MenuItem[k].addEventListener("click",onClick);
				ContentHolder.removeChild(MenuItem[k]);
			}
			
			MenuItem.length = 0;

			removeEvent(this,Event.REMOVED_FROM_STAGE,remove);
		}
		
		public function MouseActive(_i:int,s:String):void
		{
			if(_i == -1)
			{
				if(s!="sub")
				{
					for(var i:int = 0; i < itemLen; i++)
					{
				
						addEvent(MenuItem[i],MouseEvent.MOUSE_OVER, onOver);
						addEvent(MenuItem[i],MouseEvent.MOUSE_OUT, onOut);
						addEvent(MenuItem[i],MouseEvent.CLICK, onClick);
					}
				}else{
					for(var j:int = 0; j < Globals.MenuXML.item[Id].subitem.length(); j++)
					{	
						addEvent(SubMenuItem[j],MouseEvent.MOUSE_OVER, onSubOver);
						addEvent(SubMenuItem[j],MouseEvent.MOUSE_OUT, onSubOut);
						addEvent(SubMenuItem[j],MouseEvent.CLICK, onSubClick);
					}
				}
			}else{
				if(s!="sub")
				{
					addEvent(MenuItem[_i],MouseEvent.MOUSE_OVER, onOver);
					addEvent(MenuItem[_i],MouseEvent.MOUSE_OUT, onOut);
					addEvent(MenuItem[_i],MouseEvent.CLICK, onClick);
				}else{
					addEvent(SubMenuItem[_i],MouseEvent.MOUSE_OVER, onSubOver);
					addEvent(SubMenuItem[_i],MouseEvent.MOUSE_OUT, onSubOut);
					addEvent(SubMenuItem[_i],MouseEvent.CLICK, onSubClick);
				}
			
			}
			
		}
		
		public function MouseInActive(_i:int,s:String):void
		{
			if(_i == -1)
			{
				if(s!="sub")
				{
					for(var i:int = 0; i < itemLen; i++)
					{
						
						removeEvent(MenuItem[i],MouseEvent.MOUSE_OVER, onOver);
						removeEvent(MenuItem[i],MouseEvent.MOUSE_OUT, onOut);
						removeEvent(MenuItem[i],MouseEvent.CLICK, onClick);
						
					}
				}else{
					for(var j:int = 0; j < Globals.MenuXML.item[Id].subitem.length(); j++)
					{	
						removeEvent(SubMenuItem[j],MouseEvent.MOUSE_OVER, onSubOver);
						removeEvent(SubMenuItem[j],MouseEvent.MOUSE_OUT, onSubOut);
						removeEvent(SubMenuItem[j],MouseEvent.CLICK, onSubClick);
					}
				}
			}else{
				if(s!="sub")
				{
					removeEvent(MenuItem[_i],MouseEvent.MOUSE_OVER, onOver);
					removeEvent(MenuItem[_i],MouseEvent.MOUSE_OUT, onOut);
					removeEvent(MenuItem[_i],MouseEvent.CLICK, onClick);
				}else{
					removeEvent(SubMenuItem[_i],MouseEvent.MOUSE_OVER, onSubOver);
					removeEvent(SubMenuItem[_i],MouseEvent.MOUSE_OUT, onSubOut);
					removeEvent(SubMenuItem[_i],MouseEvent.CLICK, onSubClick);
				}	
			}
		}
		
		
		
		
		
		private function ShowSubMenus(_j:int):void
		{
			TweenMax.to(SubMenuItem[_j],1,{delay:_j*(0.1),alpha:0.5,onStart:MouseActive,onStartParams:[_j,"sub"],ease:Expo.easeOut});
		}
		
		private function onOver(e:MouseEvent):void
		{
			TweenMax.to(e.target,0.5,{alpha:1,ease:Expo.easeOut});

			/*if(subId != -1)
			{
				PreId = subId;
				if(Globals.MenuXML.item[subId].subitem.length() > 0 && PreId != int(e.target.name) && SubIsListed)
				{
					addEvent(MenuItem[PreId],MouseEvent.MOUSE_OUT,onOut);
					TweenMax.to(MenuItem[PreId],0.5,{tint:Globals.LightGray,glowFilter:{color:Globals.Blue, blurX:0, blurY:0,alpha:0},ease:Expo.easeOut});
					this.RemoveSubMenus(PreId);
				}
				
			}
			
			subId = e.target.name;
			Globals.MenuXML.item[subId].subitem.length() > 0 ? removeEvent(MenuItem[subId],MouseEvent.MOUSE_OUT,onOut) : void;
			TweenMax.to(e.target,0.5,{tint:Globals.Blue,glowFilter:{color:Globals.Blue, blurX:4, blurY:4,alpha:0.5, strength:2, quality:2},ease:Expo.easeOut});
			//SUB MENU SIDE
			//-------------------------------------------------------------------------------------------------------		
			if(Globals.MenuXML.item[subId].subitem.length() > 0 && !SubIsListed)
			{
				var subLength:Number = 0;
				var subheight:Number = 0;
				for (var i:int = 0; i < Globals.MenuXML.item[subId].subitem.length(); i++) 
				{
					subItemTxt[i]                = Globals.MenuXML.item[subId].subitem[i].@title;
					SubMenuItem[i]               = new ATextFieldCss(String(subItemTxt[i]),"hh","submenu",150,false);
					SubMenuItem[i].name          = String(i);
					SubMenuItem[i].y             = MenuItem[subId].Y + MenuItem[subId].height + subheight + menu_SpaceV*i + 5; 
					SubMenuItem[i].x             = MenuItem[subId].X;
					ContentHolder.addChild(SubMenuItem[i]);
					
					subLength                   += SubMenuItem[i].width;
					subheight                   += SubMenuItem[i].height;
					SubMenuItem[i].alpha  = 0;
					SubIsListed = true;
					ShowSubMenus(i,subId);
				}
			}*/
			
		}
		private function onOut(e:MouseEvent):void
		{
		
			TweenMax.to(e.target,0.5,{alpha:0.5,ease:Expo.easeOut});
		}
		
		private function onSubOver(e:MouseEvent):void
		{
			TweenMax.to(e.target,0.5,{ease:Expo.easeOut,alpha:1});
		}
		
		private function onSubOut(e:MouseEvent):void
		{
			TweenMax.to(e.target,0.5,{alpha:0.5,ease:Expo.easeOut});
		}
		
		private function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, false);
		}
		
		private function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
		
	}
}
