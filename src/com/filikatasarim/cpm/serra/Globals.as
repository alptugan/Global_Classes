package src.com.filikatasarim.cpm.serra {
	import br.com.stimuli.loading.*;
	import src.com.filikatasarim.cpm.serra.*;
	
	public class Globals {
		
		public static var br:String = "\n";
		public static var cr:String = "©";
		public static var Language:String = "tr";
		public static var MarginX:int = 26;
		public static var MarginY:int = 26;
		public static var Y:int = 100;
		public static var MenuY:int = 87;
		public static var X:int = 5;
		public static var MarginBottomX:int = 44;
		public static var MarginBottomY:int = 100;
		public static var sH:int;
		public static var H:int;
		public static var sW:int;
		public static var ContentBol:Boolean;
		public static var SubContent:Boolean;
		public static var BrowserTitle:String;
		public static var XMLLoader:BulkLoader;
		public static var bolXML:Boolean;
		public static var ContentXML:XML;
		public static var pageObjects:Array = [];
		
		public static function GlobalXML():void{
			XMLLoader = new BulkLoader("Main");
			XMLLoader.add("xml/content2.xml");
		}
		public static function onAllProgress(e:BulkProgressEvent):void{
		}
		public static function onAllXMLLoaded():void{
			ContentXML = XMLLoader.getContent("xml/content2.xml");
			var i:int;
			while (i < ContentXML.category.subcategory.pages.page.length()) {
				pageObjects[i] = new pageObject();
				pageObjects[i].id = ContentXML.category.subcategory.pages.page[i].@id;
				pageObjects[i].src = String(ContentXML.category.subcategory.pages.page[i]);
				i++;
			};
			bolXML = true;
		}
		public static function cevir(_str:String):String{
			var cevrik:String;
			var dizi1:Array = new Array("İ", "Ş", "Ü", "Ç", "Ğ", "Ö", "ı", "ş", "ü", "ç", "ğ", "ö", "'", "\"");
			var dizi2:Array = new Array("I", "S", "U", "C", "G", "O", "i", "s", "u", "c", "g", "o", " ", "");
			var i:int;
			while (i < dizi1.length) {
				cevrik = _str.split(dizi1[i]).join(dizi2[i]);
				_str = cevrik;
				i++;
			};
			return (cevrik);
		}
		public static function RemoveSpace(title:String):String{
			var converted:String = title.split(" ").join("-").toLowerCase();
			return (converted);
		}
		public static function FormatValue(title:String):String{
			var ar:Array;
			var converted:String = "";
			title = title.split("/").join("");
			if (title.indexOf("-") == -1){
				converted = (title.substr(0, 1).toUpperCase() + title.substr(1, title.length).toLowerCase());
			} else {
				title = title.split("-").join(" ").toLocaleLowerCase();
				ar = title.split(" ");
			};
			return (converted);
		}
		public static function FormatSubTitle(title:String):String{
			var RemovedSlash:String = title.slice(title.lastIndexOf("/"));
			var converted:String = RemovedSlash.split(" ").join("-").toLowerCase();
			return (converted);
		}
		public static function ResetArray():void{
		}
		
		public function get sH():int{
			return (this.sH);
		}
		public function set sH(X:int):void{
			this.sH = X;
		}
		
	}
}