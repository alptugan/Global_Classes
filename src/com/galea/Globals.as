package src.com.galea
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	/*
	Usage:
	
	private function loadXML():void
	{
	Globals.GlobalXML();
	Globals.XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
	Globals.XMLLoader.addEventListener(BulkLoader.PROGRESS, Globals.onAllProgress);
	Globals.XMLLoader.start();
	}
	
	
	private function onAllLoaded(e:Event):void
	{
	Globals.XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
	Globals.XMLLoader.removeEventListener(BulkLoader.PROGRESS, Globals.onAllProgress);
	Globals.onAllXMLLoaded();
	
	}
	
	
	
	*/
	
	public class Globals
	{
		//Symbols &#xD;
		public static var br              : String = "\n",
						  cr              : String = "©";
		public static var Language        : String = "tr";
		public static var MarginX         : int = 26; 
		public static var MarginY         : int = 26;
		public static var Y    : int = 100, MenuY : int = 87;
		public static var X    : int = 5;
		
		public static var MarginBottomX   : int = 44;
		public static var MarginBottomY   : int = 100;
		
		public static var sH : int, H:int;
		public static var sW : int;
		
		public static var ContentBol : Boolean , SubContent : Boolean,BrowserTitle:String;
		
		//XML VARIABLES
		public static var XMLLoader       : BulkLoader, bolXML : Boolean;

		//COLORS
		public static var ContactXML      : XML;
		public static var MenuXML         : XML;
		public static var SunXML       : XML, SpaXML:XML, GentlemenXML:XML,AboutXML:XML,LadiesXML:XML;
		public static var FaceXML        : XML, BodyXML:XML,MakeXML:XML;
		
		public static var Abs_Path        : String = "http://www.jinglemingle.net/";//"http://www.silo-1.com/new_site/";
		
		public static function  GlobalXML():void
		{
			XMLLoader = new BulkLoader("Main");
			if(Language == "en")
			{
				XMLLoader.add("xml/menu.xml",{id:"menu",type:"xml"});
				XMLLoader.add("xml/about-us.xml",{id:"about",type:"xml"});
				XMLLoader.add("xml/contact.xml",{id:"contact",type:"xml"});
				XMLLoader.add("xml/body.xml",{id:"body",type:"xml"});
				XMLLoader.add("xml/face.xml",{id:"face",type:"xml"});
				XMLLoader.add("xml/sun.xml",{id:"sun",type:"xml"});
				XMLLoader.add("xml/spa.xml",{id:"spa",type:"xml"});
				XMLLoader.add("xml/gentlemen.xml",{id:"gentlemen",type:"xml"});
				XMLLoader.add("xml/ladies.xml",{id:"ladies",type:"xml"});
				XMLLoader.add("xml/makeup.xml",{id:"makeup",type:"xml"});
 
			}else{
				XMLLoader.add("xml/trmenu.xml",{id:"menu",type:"xml"});
				XMLLoader.add("xml/trabout-us.xml",{id:"about",type:"xml"});
				XMLLoader.add("xml/trcontact.xml",{id:"contact",type:"xml"});
				XMLLoader.add("xml/trbody.xml",{id:"body",type:"xml"});
				XMLLoader.add("xml/trface.xml",{id:"face",type:"xml"});
				XMLLoader.add("xml/trsun.xml",{id:"sun",type:"xml"});
				XMLLoader.add("xml/trspa.xml",{id:"spa",type:"xml"});
				XMLLoader.add("xml/trgentlemen.xml",{id:"gentlemen",type:"xml"});
				XMLLoader.add("xml/trladies.xml",{id:"ladies",type:"xml"});
				XMLLoader.add("xml/trmakeup.xml",{id:"makeup",type:"xml"});
			}
			/*XMLLoader.add("xml/locations.xml",{id:"maps"});*/
		}
		public static function onAllProgress (e:BulkProgressEvent):void
		{
			/*MainPage.Pre.Tf.htmlText = (Language == "en" ? " LOADING // " : " YÜKLENİYOR // ")+ int((e.itemsLoaded / e.itemsTotal)*100);
			MainPage.Pre.x = (index.W - MainPage.Pre.width) >> 1;
			MainPage.Pre.y = MainPage.Holder.y + MainPage.Holder.height + 14;*/
		}
		
		public static function onAllXMLLoaded():void
		{
			/*MapsXML    = XMLLoader.getXML("maps");
			*/
			MenuXML    = XMLLoader.getXML("menu");
			AboutXML   = XMLLoader.getXML("about");
			ContactXML = XMLLoader.getXML("contact");
			BodyXML   = XMLLoader.getXML("body");
			FaceXML  = XMLLoader.getXML("face");
			SunXML   = XMLLoader.getXML("sun");
			SpaXML = XMLLoader.getXML("spa");
			GentlemenXML  = XMLLoader.getXML("gentlemen");
			LadiesXML   = XMLLoader.getXML("ladies");
			MakeXML   = XMLLoader.getXML("makeup");
			
			/*

			OdulluXML  = XMLLoader.getXML("od");*/
			bolXML = true;
		}
		
		
		/****************************************************************************************************************
		 * GETTER AND SETTERS																							*
		 ****************************************************************************************************************/
		public function get sH():int
		{
			return sH;
		}
		
		public function set sH(X:int):void
		{
			sH=X;
			
		}
		public static function cevir(_str:String):String
		{
			//Replace Turkish Characters in order to  get converted forlder name on  the server
			
			var dizi1:Array = new Array("İ","Ş","Ü","Ç","Ğ","Ö","ı","ş","ü","ç","ğ","ö","'",'"');
			var dizi2:Array = new Array("I","S","U","C","G","O","i","s","u","c","g","o"," ","");
			var cevrik:String;
			
			for (var i:int = 0; i < dizi1.length; i++)
			{
				cevrik = _str.split(dizi1[i]).join(dizi2[i]);
				_str   = cevrik;
			}
			
			return cevrik;
		}
		
		public static function RemoveSpace(title:String):String
		{
			//change 'SWFAddress Website' to your title/heading name
			var converted : String = title.split(" ").join("-").toLowerCase();
			
			return converted;
		}
		
		public static function FormatValue(title:String):String
		{
			//change 'SWFAddress Website' to your title/heading name
			var converted : String = "";
			title = title.split("/").join("");
			if(title.indexOf("-") == -1)
			{
				converted = (title.substr(0,1).toUpperCase() + (title.substr(1,title.length)).toLowerCase());
			}else{
				title = title.split("-").join(" ").toLocaleLowerCase();
				var ar: Array = title.split(" ");
				
				/*for(var i :int = 0; i< ar.length; i++)
				{
					ar[i] = ar[i].substr(0,1). + ar[i].substring(1).toLowerCase(); 
					converted += ar[i] +((i != ar.length- 1) ? " " : "");
				}*/
			}
			

			
			return converted;
		}
		
		public static function FormatSubTitle(title:String):String
		{
			var RemovedSlash : String = title.slice(title.lastIndexOf("/"));
			var converted : String = RemovedSlash.split(" ").join("-").toLowerCase();
			
			return converted;
			//return 'SWFAddress Website' + (title != '' ? ' / ' + toTitleCase(replace(title, '/', ' / ')) : '');
		}
		public static function ResetArray():void
		{
			/*FooterArr;
			WhatTitleArr;
			WhatInfoArr;
			NewArr;
			ClientArr;
			WorkArr;*/
		}
		

	}
}