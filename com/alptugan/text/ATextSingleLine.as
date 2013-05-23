package com.alptugan.text
{
	import com.alptugan.text.AText;
	import com.alptugan.utils.BitmapUtil;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;
	
	
	public class ATextSingleLine extends CasaSprite
	{
		public var X   : int,
		Y   : int;
		
		private var src : String;
		public var tf : CasaTextField;
		private var fontSize:int;
		private var fontColor:uint;
		private var fontName : String;
		private var _tr       : Boolean;
		private var bg       : Boolean;
		private var bgColor:uint;
		public var rect:CasaShape;
		private var bolPxFont:Boolean;
		private var align:String;
		
		
		public function ATextSingleLine(src:String,fontName:String,fontColor:uint,fontSize:int,_tr:Boolean = false,bg:Boolean =false,bolPxFont:Boolean = false,align:String= "left")
		{
			super();
			this.src = src;
			this.fontSize  = fontSize;
			this.fontColor = fontColor;
			this.fontName  = fontName;
			this._tr	   = _tr;
			this.bg        = bg;
			this.bolPxFont = bolPxFont;
			this.align     = align;
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		public function get tr():Boolean
		{
			return _tr;
		}
		
		public function set letterSpacing(val:Number):void
		{
			
		}
		
		protected function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			this.mouseChildren = false;
			this.buttonMode    = true;
			
			tf                   = new CasaTextField();
			
			tf.embedFonts        = true;
			if(bolPxFont)
			{
				tf.antiAliasType     = AntiAliasType.ADVANCED;
				tf.gridFitType       = GridFitType.PIXEL;
			}
			
			
			tf.multiline         = false;
			tf.condenseWhite     = true;
			tf.wordWrap          = false;
			tf.selectable        = false;
			tf.autoSize          = align;
			tf.defaultTextFormat = new TextFormat(fontName, fontSize,fontColor,null,null,null,null,null,"left",null,null,null);		
			tf.htmlText          = src;
			
			if (!tr) 
			{
				tf.x = -BitmapUtil.getTextFieldBounds( tf ).x;
				tf.y = -BitmapUtil.getTextFieldBounds( tf ).y;
			}
			
			
			addChild(tf);
			
			if (bg) 
			{
				rect = new CasaShape();
				rect.graphics.beginFill( 0x333333 );
				rect.graphics.drawRect( 0,0,Math.round(tf.width)+30,10+Math.round(tf.height));
				rect.graphics.endFill();
				rect.alpha = 1;
				
				addChildAt( rect,0 );
				
				tf.x = (( rect.width - tf.width ) >> 1 );
				tf.y = (( rect.height - tf.height ) >> 1 );
			}
		}
		
		public function SetText( _str : String,animate:Boolean=true ) : void
		{
			if( animate ) 
			{
				tf.alpha = 0;
				tf.htmlText = _str;
				showTf(null);
			}else{
				tf.htmlText = _str;
			}
			
			
			//TweenLite.to(tf,0.5,{alpha:0,onComplete:showTf,onCompleteParams:[_str]});
		}
		
		public function setTextPos(_x:int,_y:int):void
		{
			tf.x = _x;
			tf.y = _y;
		}
		
		private function showTf(_str:String):void
		{
			
			//_str;

			if (bg) 
			{
				rect.graphics.clear();
				rect.graphics.beginFill( 0x333333 );
				rect.graphics.drawRect( 0,0,Math.round(tf.width)+30,10+Math.round(tf.height));
				rect.graphics.endFill();
				
				tf.x = (( rect.width - tf.width ) >> 1 );
				tf.y = (( rect.height - tf.height ) >> 1 );
			}
			
			TweenLite.to(tf,0.5,{alpha:0.8});
		}
	}
}

