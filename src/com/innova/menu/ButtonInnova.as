package  src.com.innova.menu
{
	import com.alptugan.display.CreateMask;
	import com.alptugan.drawing.shape.PixelArrow;
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.layout.Aligner;
	import com.alptugan.utils.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;
	
	import src.com.innova.Globals;
	
	public class ButtonInnova extends CasaSprite
	{
		
		[Embed(source="assets/images/menu-bg.png")]
		protected var menubg:Class;
		
		public var holder:CasaSprite;
		
		public var arrowHolder:Shape;
		
		public var arrowSub:Shape;
		
		public var X   : int,
		Y   : int;
		
		public var H:Number;
		
		public var maskH:Number;
		private var src : String;
		public var tf : CasaTextField;
		private var fontSize:int;
		private var fontColor:uint;
		private var fontName : String;
		private var tr       : Boolean;
		private var bg       : Boolean;

		public var sMask:Shape;
		public var menuBg:RectShape;
		
		public function ButtonInnova(src:String,fontName:String,fontColor:uint,fontSize:int,tr:Boolean = false,bg:Boolean =false)
		{
			this.src = src;
			this.fontSize  = fontSize;
			this.fontColor = fontColor;
			this.fontName  = fontName;
			this.tr		   = tr;
			this.bg        = bg;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//
			
			
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
			
		
			if (bg) 
			{
				// Holder for menü background graphics
				holder = new CasaSprite();
				addChildAt(holder,0);
				
				// Menu background bmp
				holder.addChild(new menubg() as Bitmap);
				Aligner.alignLeft(tf,holder,40);
				
				
				// Arrow shape when to menu selected
				arrowHolder = drawArrow(21,35);
				addChild(arrowHolder);
				arrowHolder.alpha = 0;
				Aligner.alignRight(arrowHolder,holder,-46);
				
				holder.buttonMode    = true;
				
			}
			
			// Background color when seleceted
			menuBg = new RectShape(new Rectangle(0,0,this.width,this.height),new FillStyle(Globals.Style.global[0].color[0].@skin,1));
			menuBg.alpha = 0;
			addChildAt(menuBg,0);
			
			
			//this.mouseChildren = false;
		}
		
		/**
		 * MASK FOR SUB ITEMS 
		 * 
		 */
		public function addMask():void
		{
			sMask = CreateMask.Create(0,0,this.width,holder.height);
			this.maskH = this.height+18;
			menuBg.height=this.maskH;
			addChild(sMask);
			this.mask = sMask;
			
			arrowSub = drawArrow(15,25);
			arrowSub.alpha = 0;
			addChild(arrowSub);
			Aligner.alignRight(arrowSub,sMask,-46);
			
		}
		
		private function drawArrow(w:int,h:int):Shape
		{
			var s:Shape = new Shape();
			s.graphics.lineStyle(2,Globals.Style.global[0].color[0].@blue);
			s.graphics.moveTo(0,0);
			s.graphics.lineTo(w,(h-1)*0.5);
			s.graphics.lineTo(0,h);
			
			return s;
		}
	}
}