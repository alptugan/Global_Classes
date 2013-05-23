package com.alptugan.text
{
	import com.alptugan.utils.BitmapUtil;
	import com.alptugan.valueObjects.TextFormatVO;
	
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;

	public class AText extends CasaSprite
	{
		public var _tf:CasaTextField;
		protected var format : TextFormat;
		protected var _text:String = "";
		protected var _html:Boolean = false;
		private var tfWidth:int;
		private var fontSize:int;
		private var fontColor:uint;
		private var textAlign:String;
		private var bolSelectable:Boolean;
		private var _lineSpace:Number = 1;
		private var fontName : String;
		public var _spacing:Number = -1;
		
		private var _singleLine : Boolean;
		private var bolPxFont:Boolean;
		
		
		
		public function AText(fontName:String,t:String,tfWidth:int = 350, fontSize:int = 12, fontColor:uint=0x666666, bolSelectable:Boolean = true,_singleLine:Boolean = false,textAlign:String="left",bolPxFont:Boolean = false)
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			
			this._text     = t;
			this.tfWidth   = tfWidth;
			this.fontSize  = fontSize;
			this.fontColor = fontColor;
			this.textAlign = textAlign;
			this.bolSelectable = bolSelectable;
			this.fontName  = fontName;
			this._singleLine =_singleLine ;
			this.bolPxFont = bolPxFont;
			
		}

		public function set singleLine(value:Boolean):void
		{
			_singleLine = value;
		}

		public function set spacing(value:Number):void
		{
			_spacing = value;
		}

		public function set lineSpace(value:Number):void
		{
			_lineSpace = value;
		}

		protected function onRemoved(e:Event):void
		{
			
			/*this.destroy();
			_tf.destroy();
			_tf = null;*/
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			_tf                   = new CasaTextField();
			
			_tf.condenseWhite     = true;
			_tf.embedFonts        = true;
			
			if(!bolPxFont)
			{
				_tf.antiAliasType     = AntiAliasType.ADVANCED;
				_tf.gridFitType       = GridFitType.PIXEL;
			}
			
			_tf.selectable        = bolSelectable;
			
			if(_singleLine)
			{
				_tf.multiline         = false;
				_tf.wordWrap          = false;
				_tf.height = fontSize+10;
				/*_tf.background = true;
				_tf.backgroundColor = 0;*/
			}else{
				_tf.width             = tfWidth;
				_tf.multiline         = true;
				_tf.wordWrap          = true;
			}
			
			
			// Text Format Properties
			setDefaultTextFormat();
			
			_tf.htmlText              = _text;
			
			if(!_singleLine)
				_tf.height                = _tf.textHeight + 12;
			
			/*_tf.x = -BitmapUtil.getTextFieldBounds( _tf ).x;
			_tf.y = -BitmapUtil.getTextFieldBounds( _tf ).y;*/
			
			addChild(_tf);			
		}
		
		public function setDefaultTextFormat():void
		{
			format				  = new TextFormat();
			
			with(format)
			{
				leading       = _lineSpace;
				letterSpacing = _spacing;
				size          = fontSize;		
				color         = fontColor;
				font          = fontName;	
				align  		  = textAlign;
			}
			
			_tf.defaultTextFormat = format;
		}
		
		public function setTextFormat(fmt:Vector.<TextFormatVO>):void
		{
			var tfmt:TextFormat = new TextFormat();
			tfmt.leading       = fmt[0].leading || this._lineSpace;
			tfmt.color         = fmt[0].color || this.fontColor;
			tfmt.font          = fmt[0].font || this.fontName;
			tfmt.align         = fmt[0].align || this.textAlign;
			tfmt.letterSpacing = fmt[0].letterSpacing || this._spacing;
			tfmt.size          = fmt[0].size || this.fontSize;
			
			_tf.defaultTextFormat = tfmt;
		}
		
		public function setText(s:String,type:String=""):void
		{
			if(type == "append")
				_tf.appendText(s);
			else
				_tf.htmlText = s;
		}
	}
}