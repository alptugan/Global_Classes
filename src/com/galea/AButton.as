package src.com.galea
{
	import com.alptugan.text.AText;
	import com.alptugan.utils.BitmapUtil;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;
	
	import src.com.galea.display.APatternBg;
	import src.net.jwproduction.FontNames;
	
	public class AButton extends CasaSprite
	{
		//public var rect:Shape;
		public var X   : int,
				   Y   : int;
				   
		private var src : String;
		public var tf : CasaTextField;
		private var fontSize:int;
		private var fontColor:uint;
		private var fontName : String;
		private var tr       : Boolean;
		private var bg       : Boolean;
		private var t:APatternBg;
		
		public function AButton(src:String,fontName:String,fontColor:uint,fontSize:int,tr:Boolean = false,bg:Boolean =false)
		{
			this.src = src;
			this.fontSize  = fontSize;
			this.fontColor = fontColor;
			this.fontName  = fontName;
			this.tr		   = tr;
			this.bg        = bg;
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			this.mouseChildren = false;
			this.buttonMode    = true;
			
			tf                   = new CasaTextField();
			
			tf.embedFonts        = true;
			tf.antiAliasType     = AntiAliasType.ADVANCED;
			tf.gridFitType       = GridFitType.PIXEL;
			
			tf.multiline         = false;
			tf.condenseWhite     = true;
			tf.wordWrap          = false;
			tf.selectable        = false;
			tf.autoSize          = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat(fontName, fontSize,fontColor,null,null,null,null,null,"left",null,null,null);		
			tf.htmlText          = src;
			
			if (!tr) 
			{
				tf.x = -BitmapUtil.getTextFieldBounds( tf ).x;
				tf.y = -BitmapUtil.getTextFieldBounds( tf ).y;
			}
			
			
			addChild(tf);
			
			/*
			rect = new Shape();
			rect.graphics.beginFill( 0x333333 );
			rect.graphics.drawRect( 0,0,Math.round(tf.width)+30,10+Math.round(tf.height));
			rect.graphics.endFill();
			rect.alpha = 1;
			
			addChildAt( rect,0 );
			
			tf.x = (( rect.width - tf.width ) >> 1 );
			tf.y = (( rect.height - tf.height ) >> 1 );*/
			
			if (bg) 
			{
				t = new APatternBg(Math.round(tf.width)+30,47);
				addChildAt(t,0);
				
				tf.x = (( t.width - tf.width ) >> 1 );
				tf.y = 2+(( t.height - tf.height ) >> 1 );
			}
			
		}
	}
}