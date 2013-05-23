/***************************************************************************************************
 * Website      : www.alptugan.com
 * Blog         : blog.alptugan.com
 * Email        : info@alptugan.com
 *
 * Class Name   : FilikaCalibrationUI.as
 * Release Date : Nov 25, 2011
 *
 * Feel free to use this code in any way you want other than selling it.
 * Thanks. -Alp Tugan
 ***************************************************************************************************/
/* USAGE

// Cofigurate user interface
// for debug and calibration
// issues

var filikaCalibration :FilikaCalibrationUI = new FilikaCalibrationUI();
filikaCalibration.addEventListener(FilikaCalibrationEvent.CHANGE,onChangeVal);
addChild(filikaCalibration);

filikaCalibration.x = 0;
filikaCalibration.y = 0;

filikaCalibration.addItem('slider',{max:20,min:0,x:0,y:0,name:'minVolume',value:cam.minVolume});


protected function onChangeVal(e:FilikaCalibrationEvent):void
{
	switch(e.name)
	{
		case "minVolume":
		cam.minVolume = e.value;
		break;
	}
}		

*/
package src.com.filikatasarim.debug
{
	import com.alptugan.drawing.shape.RectShape;
	import com.alptugan.drawing.style.FillStyle;
	import com.alptugan.events.FilikaCalibrationEvent;
	import com.alptugan.globals.Root;
	import com.alptugan.utils.AContextMenu;
	import com.bit101.components.Label;
	import com.bit101.components.Slider;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.casalib.display.CasaSprite;
	
	public class FilikaCalibrationUI extends Root
	{
		private var _blurLabel : Label = new Label();
		private var _brightnessLabel : Label = new Label();
		private var _contrastLabel : Label = new Label();
		private var _minAreaLabel : Label = new Label();
		
		private var _blurSlider : Slider = new Slider();
		private var _brightnessSlider : Slider = new Slider();
		private var _contrastSlider : Slider = new Slider();
		private var _minAreaSlider : Slider = new Slider();
		
		// Holder for user interface
		private var UIHolder:CasaSprite;
		
		private var debug:AContextMenu;
		
		
		public var Labels:Vector.<Label> = new Vector.<Label>();
		public var TextBox:Vector.<Label> = new Vector.<Label>();
		public var Sliders:Vector.<Slider> = new Vector.<Slider>();
		public var Target:Vector.<Number> = new Vector.<Number>();
		private var i:int = -1;
		private var j:int = -1;
		private var bgRect:Boolean;
		private var bolVisible:Boolean;

		private var rect:RectShape;
		
		public function FilikaCalibrationUI(bolVisible:Boolean,
											bgRect:Boolean=false)
		{
			this.bgRect = bgRect;
			this.bolVisible = bolVisible;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		
		
		protected function onAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			
			configureDebugUI();
			drawBackGround();
		}
		
		private function drawBackGround():void
		{
			rect = new RectShape(new Rectangle(0,0,10,10),new FillStyle(0x000000,0.8));
			UIHolder.addChildAt(rect,0);
		}		
		
		/**
		 * DEBUG MODE ON / OFF 
		 * 
		 */
		private function configureDebugUI():void
		{
			UIHolder = new CasaSprite();
			addChild(UIHolder);
			debug = new AContextMenu(this.root);
			debug.addContextMenuItem("developped by Filika");
			debug.addContextMenuItem(this.bolVisible ? "debug mode: off" : "debug mode: on" );
			debug.addContextMenuHandler(hide);
			hide(null);
		}
		
		private function hide(e:Event):void
		{
			if (debug.customItem[1].caption == "debug mode: off") 
			{
				debug.customItem[1].caption = "debug mode: on";
				UIHolder.visible = false;
			}else{
				debug.customItem[1].caption = "debug mode: off";
				UIHolder.visible = true;
			}
			
		}
		
		
		public function addItem(type:String,params:Object):void
		{
			
			switch (type)
			{
				case 'label':
					i++;
					TextBox[i] = new Label();
					UIHolder.addChild(TextBox[i]);
					Labels[i].text = params.name + ': ' + params.value;
					Labels[i].name = params.name;
					Labels[i].x    = params.x;
					Labels[i].y    = params.y;
					
					break;
				
				case 'slider':
					j++;
					Labels[j] = new Label();
					UIHolder.addChild(Labels[j]);
					Labels[j].text = params.name + ': ' + params.value;
					Labels[j].name = params.name;
					Labels[j].x    = params.x;
					Labels[j].y    = params.y;
					
					
					Sliders[j] = new Slider();
					Sliders[j].addEventListener(Event.CHANGE, onComponentChanged);
					
					UIHolder.addChild(Sliders[j]);
					Sliders[j].name    = params.name;
					Sliders[j].value   = params.value;
					
					Sliders[j].x       = params.x;
					Sliders[j].y       = params.y + 16;

					Sliders[j].minimum = params.min;
					Sliders[j].maximum = params.max;
	
					break;
			}

			updateRectSize()
		}
		
		protected function onAddedComp(event:Event):void
		{
			UIHolder.removeEventListener(Event.ADDED_TO_STAGE,onAddedComp);
		}
		
		private function updateRectSize():void
		{
			rect.width  = 120;
			rect.height += 20*j;
			
			
		}
		
		public function setParameter(params:Object):void
		{
			// TO DO : Yeniden düzenlencek
			switch (params.type)
			{
				case 'label':
					for (var k:int = 0; k < i+1; k++) 
					{
						TextBox[k].text = TextBox[k].name + ': ' + String(params.value);
					}
					break;
			}
		}
		
		protected function onComponentChanged(event : Event) : void
		{
			for (var k:int = 0; k < j+1; k++) 
			{
				Labels[k].text = Labels[k].name + ': ' + String(Sliders[k].value);
				Target[k] = Sliders[k].value;
				
				dispatchEvent(new FilikaCalibrationEvent(FilikaCalibrationEvent.CHANGE,Target[k],Labels[k].name));
			}
		}
		
	}
}