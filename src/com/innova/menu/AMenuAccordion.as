package src.com.innova.menu
{
	import com.alptugan.display.CreateMask;
	import com.alptugan.events.AccordionMenuEvent;
	import com.alptugan.layout.Aligner;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.reflektions.tween.*;
	import com.reflektions.tween.equations.*;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	
	import src.com.innova.Globals;
	import src.com.innova.events.AMenuAccordionEvent;
	
	public class AMenuAccordion extends CasaSprite
	{
		private var itemLen       : int;
		private var SubItemLen       : int;
		public var MenuItem      : Array = [];
		private var SubMenuItem   : Array  = [];
		
		
		private var fontName:String;
		private var fontSize:int;
		private var color :uint;
		private var menu_SpaceV:int;
		
		private var itemTxt       : Array = [];
		private var SubItemTxt       : Array = [];
		private var query       : Array = [];
		private var textHeight:int = 0;
		private var subTextHeight:int=0;
		
		
		// Component Parameters
		private var maxItems:int = 4;			// number of butons
		private var maxSubItems:int = 4;		// number of sub buttons
		private var dist:int = 4;					// distance in pixels between items
		private var sDist:int = 1;					//distance in pixels between sub items
		private var speed:Number;						// speed of animation	
		private var itemArray:Array = new Array();	// hold reference to all clips
		private var growingVal:Object = null;		// hold reference to growing object
		private var reducingVal:Object = null;		// hold reference to reducing object
		private var Id:int = -1;
		private var subId:int = -1;

		public function AMenuAccordion(fontName:String,fontSize:int, color:uint,menu_SpaceV:int = 0)
		{
			this.fontName = fontName;
			this.fontSize = fontSize;
			this.color      = color;
			this.menu_SpaceV = menu_SpaceV;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			itemLen = Globals.Style.menu.item.length();
			
			//component parameters
			maxItems = itemLen;
			
			for (var i:int = 0; i < itemLen; i++) {
				itemTxt[i]        = (Globals.Style.menu[0].item[i].title);
				
				query[i]          = (Globals.Style.menu[0].item[i].@query);
				
				MenuItem[i]      = new ButtonInnova(String(itemTxt[i]).toUpperCase(),fontName,this.color,fontSize,true,true);
				MenuItem[i].name = String(i);
				MenuItem[i].y    = MenuItem[i].Y = textHeight + menu_SpaceV*i ; 
				
				//MenuItem[i].x    = MenuItem[i].X = textLenght +  menu_SpaceH*i;
				addChild(MenuItem[i]);
				   
				MenuItem[i].H    = MenuItem[i].height;

				textHeight += MenuItem[i].H;
				
				SubItemLen = Globals.Style.menu[0].item[i].subitem.length();
				
				// If there is sub item set them else pass for loop
				if(SubItemLen != 0)
				{
					for (var j:int = 0; j < SubItemLen; j++) 
					{
						SubItemTxt[j]        = (Globals.Style.menu[0].item[i].subitem[j].title);
						SubMenuItem[j]      = new ButtonInnova(String(SubItemTxt[j]),"regular",this.color,fontSize,true,false);
						SubMenuItem[j].name = String(j);
						SubMenuItem[j].y    = 10 + MenuItem[i].H  + subTextHeight + 20*j ; 
						SubMenuItem[j].x    = 55;
						MenuItem[i].addChild(SubMenuItem[j]);
						SubMenuItem[j].H    = SubMenuItem[j].height;
						
						subTextHeight += SubMenuItem[j].H;
					}
					
					MenuItem[i].addMask();
				}
			
				MenuItem[i].addEventListener(MouseEvent.CLICK,onClickHandler);
			}			
			
		}
		
		/**
		 * MAIN MENU CLICKED FUNCNTION
		 * @param e
		 * 
		 */		
		public function onClickHandler(e:MouseEvent):void
		{
			
			MainMenuClicked(e.currentTarget.name);
			
		}
		
		public function MainMenuClicked(MainId:int):void
		{
			if(Id != -1) //previously clicked main menu number
			{
				addRemoveSubMenuListeners(Id,"remove");
				
				MenuItem[Id].menuBg.alpha = 0;
				TweenMax.to(MenuItem[Id].arrowHolder,0.3,{x:"-5",alpha:0});
				TweenMax.to(MenuItem[Id].holder,0.5,{alpha:1});
				
				if(MenuItem[Id].sMask)
				{
					for (var k:int = 0; k < itemLen; k++) {
						if(k > Id)
							TweenMax.to(MenuItem[k],0.5,{y:MenuItem[k].Y,ease:Expo.easeOut});
					}
					TweenMax.to(MenuItem[Id].sMask,0.5,{height: MenuItem[Id].H,ease:Expo.easeOut});
				}else{
					
				}
				MenuItem[Id].addEventListener(MouseEvent.CLICK,onClickHandler);
			}
			
			
			Id = MainId;
			
			MenuItem[Id].menuBg.alpha = 1;
			TweenMax.to(MenuItem[Id].holder,0.5,{alpha:0,ease:Expo.easeOut});
			TweenMax.to(MenuItem[Id].arrowHolder,0.5,{x:"5",alpha:1});
			
			if(MenuItem[Id].sMask)
			{
				for (var i:int = 0; i < itemLen; i++) {
					if(i > Id)
						TweenMax.to(MenuItem[i],0.5,{y:MenuItem[i].Y + MenuItem[Id].maskH -MenuItem[i].H,ease:Expo.easeOut});
				}
				TweenMax.to(MenuItem[Id].sMask,0.5,{height: MenuItem[Id].maskH,ease:Expo.easeOut});	
			}else{
				
			}
			MenuItem[Id].removeEventListener(MouseEvent.CLICK,onClickHandler);
			addRemoveSubMenuListeners(Id,"add");
			
			// Dispatch Clicked Menu Event so Add related content
			var evt:AMenuAccordionEvent = new AMenuAccordionEvent(AMenuAccordionEvent.MENU_CLICKED,Id,query[Id],"main");
			dispatchEvent(evt);
		}
		
		/**
		 *  
		 * @param Id		: CURRENT MENU ID
		 * @param action	: WHETER TO REMOVE OR ADD EVENT LISTENER FROM THE SUBMENU BUTTONS
		 * 
		 */		
		private function addRemoveSubMenuListeners(Id:int,action:String = "add"):void
		{
			SubItemLen = Globals.Style.menu[0].item[Id].subitem.length();
			
			
			for (var j:int = 0; j < SubItemLen; j++) 
			{
				if(action == "add")
				{
					subId = -1;
					SubMenuItem[j].addEventListener(MouseEvent.CLICK,onClickSubHandler);
				}else{
					TweenMax.to(MenuItem[Id].arrowSub,0.3,{x:"-5",alpha:0});
					SubMenuItem[j].removeEventListener(MouseEvent.CLICK,onClickSubHandler);
				}
				
			}
		}
		
		
		/**
		 * SUBMENU CLICK FUNCTION
		 * @param e
		 * 
		 */
		private function onClickSubHandler(e:MouseEvent):void
		{
			setSubMenu( e.currentTarget.name);
		}
		
		public function setSubMenu(selected:int):void
		{
			
			TweenMax.to(MenuItem[Id].arrowHolder,0.3,{x:"-5",alpha:0});
			
			
			if(subId != -1) //previously clicked main menu number
			{
				TweenMax.to(MenuItem[Id].arrowSub,0.3,{x:"-5",alpha:0});
				SubMenuItem[subId].addEventListener(MouseEvent.CLICK,onClickSubHandler);
			}
			
			subId = selected;
			MenuItem[Id].arrowSub.y = SubMenuItem[subId].y+2;
			TweenMax.to(MenuItem[Id].arrowSub,0.3,{x:"5",alpha:1});
			SubMenuItem[subId].removeEventListener(MouseEvent.CLICK,onClickSubHandler);
			
			// Query for the index
			var subQuery : String = Globals.Style.menu[0].item[Id].subitem[subId].@query;
			
			// Dispatch Clicked Menu Event so Add related content
			var evtsub:AMenuAccordionEvent = new AMenuAccordionEvent(AMenuAccordionEvent.MENU_CLICKED,Id,subQuery,"sub",subId);
			dispatchEvent(evtsub);
		}
	}
}