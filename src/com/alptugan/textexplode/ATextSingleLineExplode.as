package src.com.alptugan.textexplode
{
	import com.alptugan.text.AText;
	import com.alptugan.utils.BitmapUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import org.casalib.display.CasaShape;
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaTextField;
	
	
	public class ATextSingleLineExplode extends CasaSprite
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
		
		
		private var splitString			: Array;
		private var dynamicText3Ds		: Array;
		private var xPositions			: Dictionary;		// Dictionary for storing x positions of all DynamicText3Ds
		public var assembled			: Boolean;
		
		
		/*
		========================================================
		| Private Variables                         | Data Type  
		========================================================
		*/
		
		private var _lifeSpan:                      int;
		private var _age:                           int = 0;
		public var _size:                          Number;
		
		/*
		========================================================
		| Public Variables                          | Data Type  
		========================================================
		*/
		
		public var vx:                              Number = 0;
		public var vy:                              Number = 0;
		public var vr:                              Number = 0;
		
		public function ATextSingleLineExplode(src:String,fontName:String,fontColor:uint,fontSize:int,_tr:Boolean = false,bg:Boolean =false,bolPxFont:Boolean = false,life:int=0, size:Number=0)
		{
			super();
			this.src = src;
			this.fontSize  = fontSize;
			this.fontColor = fontColor;
			this.fontName  = fontName;
			this._tr	   = _tr;
			this.bg        = bg;
			this.bolPxFont = bolPxFont;
			
			_lifeSpan = life;
			_size = size;
		
			
			setSize(_size);
			
			rotation = Math.random() * 360;
			//alpha = 0;
			
			splitString = this.src.split( "" );
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		public function setSize(ed:Number):void
		{
			scaleX = scaleY = ed / 100;
		}		
		
		
		public function get tr():Boolean
		{
			return _tr;
		}
		
		protected function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			
			/*dynamicText3Ds = new Array( splitString.length );
			xPositions = new Dictionary();
			var currentLetterPosition:Number = 0;
			
		
			
			assembled = true;
			
			this.mouseChildren = false;
			this.buttonMode    = true;
			
			for ( var i:int = 0; i < splitString.length; i++ )
			{
					
				
				
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
				tf.autoSize          = TextFieldAutoSize.LEFT;
				tf.defaultTextFormat = new TextFormat(fontName, fontSize,fontColor,null,null,null,null,null,"left",null,null,null);		
				tf.htmlText          = splitString[ i ];
				
				if (!tr) 
				{
					tf.x = -BitmapUtil.getTextFieldBounds( tf ).x;
					tf.y = -BitmapUtil.getTextFieldBounds( tf ).y;
				}
				
				
				tf.x = currentLetterPosition;
				xPositions[ tf ] = currentLetterPosition; 
				
				addChild(tf);
				
				dynamicText3Ds[ i ] = tf;
				
				var letterWidth:Number = tf.width-2;
				
				currentLetterPosition += letterWidth;
				
				
			
			}*/
			
			
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
			tf.autoSize          = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat(fontName, fontSize,fontColor,null,null,null,null,null,"left",null,null,null);		
			tf.htmlText          =  this.src;
			
			if (!tr) 
			{
				tf.x = -BitmapUtil.getTextFieldBounds( tf ).x;
				tf.y = -BitmapUtil.getTextFieldBounds( tf ).y;
			}
			
			
			
			addChild(tf);
			
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
			
			TweenLite.to(tf,0.5,{alpha:1});
		}
		
		// === A P I ===
		public function assemble( seconds:Number = 4, ease:Function = null ): void
		{
			ease = ease == null ? Back.easeInOut : ease
			
			for ( var i:int = 0; i < dynamicText3Ds.length; i++ )
			{
				var t:CasaTextField = dynamicText3Ds[ i ];
				TweenLite.to( 
					t, 
					Math.random() * ( seconds / 2 ) + seconds / 2, 
					{ alpha:1, y:0, x:xPositions[ t ], ease:ease } 
				);
			}
			
			assembled = true;
		}
		
		// 'distance' is the furthest the letters can travel from the ( 0, 0, 0 ) point of this Sprite3D
		public function explode( seconds:Number = 4, ease:Function = null, distance:Number = 600 ): void
		{
			ease = ease == null ? Back.easeInOut : ease;
			
			for ( var i:int = 0; i < dynamicText3Ds.length; i++ )
			{
				var t:CasaTextField = dynamicText3Ds[ i ];
				TweenLite.to( 
					t, 
					Math.random() * ( seconds / 2 ) + seconds / 2, 
					{ 
						x: Math.random() * distance - distance / 2, 
						y: Math.random() * distance - distance / 2, 
						alpha:1, 
						ease:ease 
					} 
				);
			}
			
			assembled = false;
			
		}
		
		
		/*
		========================================================
		| Getters + Setters
		========================================================
		*/
		
		public function get age():int
		{
			return _age;
		}
		
		public function get life():int
		{
			return _lifeSpan;
		}
		
		public function set age( n:int ):void
		{
			_age = n;
		}
	}
}

