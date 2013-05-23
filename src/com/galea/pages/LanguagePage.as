package src.com.galea.pages
{
	import com.alptugan.assets.font.FontNamesFB;
	import com.alptugan.events.LanguageEvent;
	import com.alptugan.text.AText;
	import com.alptugan.text.ATextSingleLine;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.casalib.display.CasaSprite;
	
	import src.com.galea.styleGalea;
	/*
	USAGE:
	
	var lang:LanguagePage = new LanguagePage("ENGLISH","TÜRKÇE",FontNamesFB.regular,0x000000,styleGalea.pSize);
	addChild(lang);
	lang.addEventListener(LanguageEvent.LANGUAGE_SELECTED,LangSelected);
	
	
	protected function LangSelected(event:LanguageEvent):void
	{
		lang.removeEventListener(LanguageEvent.LANGUAGE_SELECTED,LangSelected);
		lang.destroy();
	}
	
	*/
	public class LanguagePage extends CasaSprite
	{
		private var _engTxt:String;
		private var _trTxt:String;
		private var _fontName:String;
		private var _fontColor:uint;
		private var _fontSize:Number;
		public var engTf:ATextSingleLine;
		public var trTf:ATextSingleLine;

		public function LanguagePage( engTxt:String = "ENGLISH", trTxt:String = "TÜRKÇE",_fontName:String="regular",_fontColor:uint = 0xffffff,_fontSize:Number = 12 ):void 
		{ 
			this._engTxt = engTxt;
			this._trTxt = trTxt;
			this._fontColor = _fontColor;
			this._fontName  = _fontName;
			this._fontSize  = _fontSize;
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		
		

		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			trTf = new ATextSingleLine(trTxt,_fontName,_fontColor,_fontSize,true);
			addChild(trTf);
			
			
			engTf = new ATextSingleLine(engTxt,_fontName,_fontColor,_fontSize);
			engTf.x = trTf.x + trTf.width + 10;
			engTf.y = trTf.y + 6;
			addChild(engTf);
			
			
			TweenLite.from(trTf,0.5,{alpha:0});
			TweenLite.from(engTf,0.5,{alpha:0,delay:0.5});
			
			this.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.CLICK,onClick);
			TweenLite.to(trTf,0.2,{alpha:0,x:"-40",onComplete:function():void{trTf.destroy();}});
			TweenLite.to(engTf,0.2,{alpha:0,x:"40",onComplete:function():void{engTf.destroy();}});
			
			var l:String;
			
			if (e.target.tr) 
			{
				l = "tr";
			}else{
				l = "en";
			}
			
			dispatchEvent(new LanguageEvent(l,LanguageEvent.LANGUAGE_SELECTED));
		}
		
		//======================================================================================================================
		// GETTERS
		//======================================================================================================================
		public function get engTxt():String { return _engTxt; }
		public function get trTxt():String { return _trTxt; }
		public function get fontName():String { return _fontName; }
		public function get fontColor():uint { return _fontColor; }
		public function get fontSize():Number { return _fontSize; }
		
		
		//======================================================================================================================
		// SETTERS
		//======================================================================================================================
		public function set trTxt( value:String ):void
		{
			_trTxt = value;
		}
		
		public function set engTxt( value:String ):void
		{
			_engTxt = value;
		}
	}
}