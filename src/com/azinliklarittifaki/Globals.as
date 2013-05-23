package src.com.azinliklarittifaki
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	

	import com.alptugan.valueObjects.styleVO;
	
	import flash.display.Sprite;
	

	
	/*
	Usage:
	
	private function loadXML():void
	{
	Globals.GlobalXML();
	Globals.XMLLoader.addEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
	Globals.XMLLoader.addEventListener(BulkLoader.PROGRESS, this.onAllProgress);
	Globals.XMLLoader.start();
	}
	
	private function onAllProgress(e:BulkProgressEvent):void
	{
	//trace("alo : ",Math.round(e.bytesLoaded / e.bytesTotal * 100 )  );
	}
	
	private function onAllLoaded(e:Event):void
	{
	Globals.XMLLoader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
	Globals.XMLLoader.removeEventListener(BulkLoader.PROGRESS, this.onAllProgress);
	Globals.onAllXMLLoaded();
	}
	
	
	
	
	*/
	
	public class Globals
	{
		//Symbols &#xD;
		public static var br              : String = "\n",
			cr              : String = "©";
		public static var Language        : String = "tr";
		
		
		//XML VARIABLES
		public static  var XMLLoader       : BulkLoader, bolXML : Boolean;
		
		private static var 
		_Style : XML,
		
		_ContentXpos:int,
		_ContentYpos:int,
		
		_MenuXpos:int,
		_MenuYpos:int,
		
		_Domain:String
		;

		private static var _css:Vector.<styleVO> = new Vector.<styleVO>();
		

		public static function  GlobalXML():void
		{
			XMLLoader = new BulkLoader("Main");
			XMLLoader.add("xml/style.xml",{id:"css"});
		}
		
		public static function load(src:String):void
		{
			XMLLoader.add(src,{id:"xml"});
			XMLLoader.start();
		}
		
		public static function onAllXMLLoaded():void
		{
			_Style  = XMLLoader.getXML("css");
			
			//Content position
			_ContentXpos    = Style.global[0].content[0].@X; 
			_ContentYpos    = Style.global[0].content[0].@Y; 
			
			//Menu Position
			_MenuXpos       = Style.menu[0].@X; 
			_MenuYpos       = Style.menu[0].@Y; 
			
			//Domain Name
			_Domain         = Style.domain[0];
			
			
			// Text csss like CSS properties
			var styleLength : int = Style.textstyle[0].style.length();
			
			for(var i:int = 0; i < styleLength; i++)
			{
				_css[i]            = new styleVO();
				_css[i].color      = Style.textstyle[0].style[i].color;
				_css[i].height     = Style.textstyle[0].style[i].height;
				_css[i].hovercolor = Style.textstyle[0].style[i].hovercolor;
				_css[i].leading    = Style.textstyle[0].style[i].leading;
				_css[i].name       = Style.textstyle[0].style[i].name;
				_css[i].size       = Style.textstyle[0].style[i].size;
				_css[i].spacing    = Style.textstyle[0].style[i].spacing;
				_css[i].width      = Style.textstyle[0].style[i].width;
				//trace(_css[i].color,_css[i].height,_css[i].hovercolor,_css[i].name,_css[i].leading,_css[i].size,_css[i].spacing,_css[i].width);
			}
			
			XMLLoader.clear();
			XMLLoader.removeAll();
			
			bolXML = true;
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
		
		
		//========================================================================================================
		// GETTERS & SETTERS
		//========================================================================================================
		public static function get css():Vector.<styleVO>
		{
			return _css;
		}
		
		public static function get Domain():String
		{
			return _Domain;
		}
		
		
		public static function get MenuYpos():int
		{
			return _MenuYpos;
		}
		
		public static function set MenuYpos(value:int):void
		{
			_MenuYpos = value;
		}
		
		public static function get MenuXpos():int
		{
			return _MenuXpos;
		}
		
		public static function set MenuXpos(value:int):void
		{
			_MenuXpos = value;
		}
		
		public static function get ContentYpos():int
		{
			return _ContentYpos;
		}
		
		public static function set ContentYpos(value:int):void
		{
			_ContentYpos = value;
		}
		
		public static function get ContentXpos():int
		{
			return _ContentXpos;
		}
		
		public static function set ContentXpos(value:int):void
		{
			_ContentXpos = value;
		}
		
		public static function get Style():XML
		{
			return _Style;
		}
		
		
		
	}
}