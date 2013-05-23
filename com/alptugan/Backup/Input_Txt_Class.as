package alptugan.Backup 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.*;
	
	public class Input_Txt_Class extends Sprite
	{
		public var myTextBox1:TextField = new TextField();
        public var myTextBox2:TextField = new TextField();
        private var _w        : Number;
        private var _h        : Number;
        private var _color    : uint;
		private var format    :TextFormat = new TextFormat();
		

		public function Input_Txt_Class(color:uint = 0xd6d6d6,w:Number = 200, h:Number = 16)
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,remove);
			//txtAlign            = _txtAlign;
			//url                 = _url;
			_w     = w;
			_h     = h;
			_color = color;
		}
		
		private function init(e:Event):void
		{
			//myTextBox1.embedFonts    = true;
			removeEventListener(Event.ADDED_TO_STAGE,init);
			myTextBox1.type          = TextFieldType.INPUT;

            myTextBox1.width         = _w;
            myTextBox1.height        = _h;
            myTextBox1.background    = false;
            myTextBox1.border        = true;
            myTextBox1.borderColor   = _color;
            myTextBox1.selectable    = true;
            myTextBox1.multiline     = true;
            myTextBox1.wordWrap      = true;
            myTextBox1.antiAliasType = AntiAliasType.ADVANCED;
            //myTextBox1.gridFitType   = GridFitType.PIXEL;
            
            myTextBox2.x=200;
			
			format.font = "Arial";
			format.size = 11;
			//format.font = "Neue";	
			format.letterSpacing = 1;
			//addChild(myTextBox2);
			myTextBox1.defaultTextFormat = format;
            addChild(myTextBox1);
            
            myTextBox1.addEventListener(TextEvent.TEXT_INPUT,textInputHandler);
        }

        public function textInputHandler(event:TextEvent):void
        {
        	myTextBox2.text=event.text;
        }
        
        private function remove(e:Event):void
        {
        	
        }
    }
}