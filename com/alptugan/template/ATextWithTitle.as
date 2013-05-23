package com.alptugan.template
{
	import com.alptugan.text.AText;
	import com.alptugan.utils.BitmapUtil;
	
	import flash.events.Event;
	import flash.text.GridFitType;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;
	
	public class ATextWithTitle extends CasaSprite
	{
		public var _tf:CasaTextField;
		protected var _text:String = "";
		protected var _html:Boolean = false;
		private var tfWidth:int;
		private var fontSize:int;
		private var fontColor:uint;
		private var textAlign:String;
		private var bolSelectable:Boolean;
		private var lineSpace:Number;
		
		private var p:AText, 
					p_txt:String,
					paragraphSize:int,
					paragraphColor:uint;
					
		//Gap Between title and paragraph
		private var gap:int = 0;
		
		
		public function ATextWithTitle(t:String,p_txt:String,tfWidth:int = 260, fontSize:int = 18, paragraphSize:int = 12, fontColor:uint=0x666666, paragraphColor:uint = 0x666666,bolSelectable:Boolean = true,textAlign:String=TextAlign.LEFT,lineSpace:Number = 0)
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onremoved);
			
			this._text     = t;
			this.tfWidth   = tfWidth;
			this.fontSize  = fontSize;
			this.fontColor = fontColor;
			this.textAlign = textAlign;
			this.bolSelectable = bolSelectable;
			this.lineSpace = lineSpace;
			
			this.p_txt     = p_txt;
			this.paragraphSize = paragraphSize;
		}
		
		protected function onremoved(e:Event):void
		{
			this.removeEventListeners();
			_tf = null;
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			_tf                   = new CasaTextField();
			_tf.width             = tfWidth;
			_tf.embedFonts        = true;
			/*_tf.antiAliasType     = AntiAliasType.ADVANCED;*/
			_tf.gridFitType       = GridFitType.PIXEL;
			
			_tf.multiline         = true;
			_tf.wordWrap          = true;
			_tf.selectable        = bolSelectable;
			_tf.type              = TextFieldType.DYNAMIC;
			_tf.defaultTextFormat = new TextFormat("helvetica-bold", fontSize,fontColor,null,null,null,null,null,textAlign,null,null,null,lineSpace);		
			_tf.htmlText              = _text;
			_tf.height            = _tf.textHeight ;
			addChild(_tf);
			

			_tf.x = -BitmapUtil.getTextFieldBounds( _tf ).x;
			_tf.y = -BitmapUtil.getTextFieldBounds( _tf ).y;
			
			p = new AText("roman",p_txt,tfWidth,paragraphSize,paragraphColor,bolSelectable);
			p.y = _tf.height + gap;
			addChild(p);
			
			
		}
	}
}