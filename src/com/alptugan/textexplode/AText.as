package src.com.alptugan.textexplode
{
	import com.alptugan.utils.BitmapUtil;
	
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	//import flashx.textLayout.formats.TextAlign;
	
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
		private var _lineSpace:Number = 0.5;
		private var fontName : String;
		public var _spacing:Number = 1;
		
		private var _singleLine : Boolean;
		
		
		
		public function AText(fontName:String,t:String,tfWidth:int = 350, fontSize:int = 12, fontColor:uint=0x666666, bolSelectable:Boolean = true,_singleLine:Boolean = false)
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
			
			this.destroy();
			_tf.destroy();
			_tf = null;
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			_tf                   = new CasaTextField();
			
			_tf.condenseWhite     = true;
			_tf.embedFonts        = true;
			_tf.antiAliasType     = AntiAliasType.ADVANCED;
			_tf.gridFitType       = GridFitType.PIXEL;
			_tf.selectable        = bolSelectable;
			
			if(_singleLine)
			{
				_tf.multiline         = false;
				_tf.wordWrap          = false;
			}else{
				_tf.width             = tfWidth;
				_tf.multiline         = true;
				_tf.wordWrap          = true;
			}
			
			
			// Text Format Properties
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
			
			_tf.htmlText              = _text;
			
			if(!_singleLine)
				_tf.height                = _tf.textHeight + 12;
			
		/*	_tf.x = -BitmapUtil.getTextFieldBounds( _tf ).x;
			_tf.y = -BitmapUtil.getTextFieldBounds( _tf ).y;*/
			
			addChild(_tf);			
		}
	}
}