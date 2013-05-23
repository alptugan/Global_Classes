package alptugan.Backup {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;


	public class TxtClass extends Sprite {
		//Font Embedding

		private var txt         : String;
		private var transTime   : Number;
		private var txtColor    : uint;
		private var txtColor2   : uint;
		public var tf           : TextField;
		private var tf_format   : TextFormat;
		private var style       : String;
		private var mouse       : String;
		private var fontSize    : Number;
		public var rect         : Shape;    
		public var holder       : Sprite;  
		
		private var w           : Number;
		private var lineH       : Number;
		private var fontName    : String;
		private var selectable  : Boolean;
		private var spacing     : Number;


		public  function TxtClass (_txt:String = "", 
								 _style:String = "h", 
							  _fontSize:Number = 41.5, 
							    _txtColor:uint = 0xb89378, 
								_lineH:Number  = 0, 
								_spacing:Number= 0.5,
								     _w:Number = 100, 
						    _fontName : String = "Neue-Condensed",
						 _selectable : Boolean = true,    
						       _txtColor2:uint = 0x000000) 
		{
		
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,remove);
			txt                 = _txt;
			txtColor              = _txtColor;
			txtColor2             = _txtColor2;
			style                 = _style;
			fontSize              = _fontSize;
			w                     = _w;
			lineH                 = _lineH;
			fontName              = _fontName;
			selectable            = _selectable;
			spacing               = _spacing;
			//txtAlign            = _txtAlign;
			//url                 = _url;
			
				
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			holder           = new Sprite();
			tf               = new TextField();
			tf_format        = new TextFormat();
			tf.embedFonts    = true;
			addChild(holder);
			
            tf.antiAliasType = AntiAliasType.ADVANCED;
          //  tf.gridFitType   = GridFitType.PIXEL;
           // tf.sharpness=fldSharpness;
			
			switch(style)
			{
				case "t":
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = true;
				tf.wordWrap             = false;
				tf_format.letterSpacing = 1;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "st":
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = true;
				tf.wordWrap             = false;
				tf_format.letterSpacing = 0.25;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "10":
				//tf.width                = 240;
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = false;
				//tf.wordWrap             = true;
				tf_format.letterSpacing = 1;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "9":
				tf.width                = 240;
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = true;
				tf.wordWrap             = true;
				tf_format.letterSpacing = 1;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "8":
				tf.width                = 280;
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = true;
				tf.wordWrap             = true;
				tf_format.letterSpacing = 0.5;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "news":
				tf.width                = 224;
				tf.selectable           = false;
				tf.multiline            = true;
				tf.condenseWhite        = false;
				tf.wordWrap             = true;
				tf_format.letterSpacing = 0.25;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "underline":
				//tf.width                = 224;
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = false;
				tf.wordWrap             = false;
				tf_format.letterSpacing = 0.25;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.underline     = true;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "recent":
				//tf.width                = 240;
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = false;
				//tf.wordWrap             = true;
				tf_format.letterSpacing = 0.25;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "abo":
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = false;
				tf_format.letterSpacing = 0;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "w":
				tf.width                = w;
				tf.selectable           = true;
				tf.multiline            = true;
				tf.wordWrap             = true;
				tf.condenseWhite        = true;
				tf_format.leading       = lineH;
				tf_format.letterSpacing = spacing;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = fontName;	
				break;
				
				case "uw":
				tf.width                = w;
				tf.selectable           = selectable;
				tf_format.leading       = lineH;
				tf_format.letterSpacing = spacing;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = fontName;	
				break;
				
				case "abo-info":
				
				tf_format.letterSpacing = 0.5;
				tf_format.leading       = 5;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Condensed";	
				break;
				
				case "h":
				
				tf.selectable           = false;
				tf.multiline            = false;
				tf.condenseWhite        = true;
				
			//	tf_format.letterSpacing = 0.8;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				tf_format.font          = fontName;	
				break;
				
				case "About":
				tf.width                = 510;
		
				tf.multiline            = true;
				tf.condenseWhite        = true;
				tf.wordWrap             = true;
				tf_format.letterSpacing = 0.8;
				tf_format.size          = fontSize;	
				tf_format.italic        = true;	
				tf_format.color         = txtColor;
				tf_format.font          = "Neue-Italic";	
				break;
				/*case "m":
				
				tf.selectable           = false;
				tf.multiline            = true;
				tf.condenseWhite        = true;
				tf_format.letterSpacing = 0.8;
				tf_format.size          = fontSize;		
				tf_format.color         = txtColor;
				break;
				
				case "cap":
				tf.width                = 187;
				tf.selectable           = false;
				tf.multiline            = true;
				tf.wordWrap             = true;
				tf_format.letterSpacing = 0.8;
				tf_format.size          = fontSize;
				tf_format.color         = txtColor;	
				tf_format.align         = TextFormatAlign.RIGHT;

				break;
				
				
				
				case "g_info":
				tf.width                = 210;
				tf.selectable           = true;
				tf.multiline            = true;
				tf.wordWrap             = true;
				tf_format.letterSpacing = 0.8;
				tf_format.size          = 11;
				tf_format.color         = 0x000000;	
				break;
				
				case "n_date":
				tf.width                = 272;
				tf.selectable           = true;
				tf.multiline            = false;
				tf.wordWrap             = true;
				
				tf_format.letterSpacing = 0;
				tf_format.size          = 11;
				tf_format.color         = 0x000000;
				break;
				
				case "n_header":
				tf.width                = 272;
				tf.selectable           = true;
				tf.multiline            = true;
				tf.wordWrap             = true;
				
				tf_format.letterSpacing = 0;
				tf_format.size          = 14;
				tf_format.color         = 0x000000;
				break;
				
				case "n_info":
				tf.width                = 272;
				tf.selectable           = true;
				tf.multiline            = true;
				tf.wordWrap             = true;
				
				tf_format.letterSpacing = 0.8;
				tf_format.size          = 11;
				tf_format.color         = txtColor;
				break;				*/
			}
			
			
					
			//tf_format.leading       = Leading;
			tf.defaultTextFormat    = tf_format;
			tf.htmlText			    = txt;		
			tf.autoSize             = TextFieldAutoSize.LEFT;
			holder.addChild(tf);
			
			if(!selectable)
			{
				holder.mouseChildren = false;
				holder.buttonMode    = true;
			}
			
			if(style == "h")
			{
				rect    = new Shape();
				rect.graphics.beginFill(0x17110b);
				rect.graphics.drawRect(0,0,tf.textWidth + 20, tf.textHeight + 8);
				rect.graphics.endFill();
				rect.alpha = 0.7;
				tf.x       = ( rect.width / 2 - tf.textWidth / 2 ) - 3;
				tf.y       = (rect.height / 2 - tf.height / 2) + 2;
				addChildAt(rect,0);
			}
		}
		
		public function SetText(_str:String):void
		{
			tf.htmlText			    = _str;
		}
		
		public function updateW(_n:Number):void
		{
			rect.width = tf.textWidth + 20;
			tf.x       = ( rect.width / 2 - tf.textWidth / 2 ) - 3;
			tf.y       = (rect.height / 2 - tf.height / 2) + 3;
		}
		
		private function remove(e:Event):void
		{	
			
			holder.removeChild(tf);
			removeChild(holder);
			removeEventListener(Event.REMOVED_FROM_STAGE,remove);
			if(style == "h")
			{
				removeChild(rect);
			}
		}

		
	}//class ends
}//package ends